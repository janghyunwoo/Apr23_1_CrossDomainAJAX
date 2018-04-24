<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- <script type="text/javascript" src="resources/jquery.js"></script> -->
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- <script type="text/javascript" src="resources/jquery.xdomainajax.js"></script> -->
<script type="text/javascript" src="resources/jquery.ajax-cross-origin.min.js"></script>
<script type=""></script>
<script type="text/javascript">
	$(function(){
		
		//DAO(자바 코드)를 이용해서 가져오는 방법(JSON)
		$("#b4").click(function() {
			var bookTitle = $("#i3").val();
			
			bookTitle = encodeURIComponent(bookTitle);
			$.ajax({
				url : "book.get",
				data : {
					q : bookTitle
				},
				success : function(json) {
					$("table").empty();
					var arr = json.documents;
					
					$.each(arr, function(i, s) { //s는 객체이다. {}형태
						var authors = s.authors;
						var category =s.category;
						var thumbnail =s.thumbnail;
						
						var img = $("<img>").attr("src",thumbnail);
						var td1 = $("<td></td>").append(img);
						var td2 = $("<td></td>").text(authors);
						var td3 = $("<td></td>").text(category);
						tr1 = $("<tr></tr>").append(td1,td2,td3);
						$("table").append(tr1);
						
					});
					
				}
			});
		});
		$("#i3").keyup(function() {
			$("#b4").trigger("click");
		});
		
		//미완성 코드이다.. 안되는 것같음..
		//실행 안된다. 왜냐하면  동일 출처 정책(Same-Origin Policy)으로 같은 서버에서 요청하는 것이 아니면 보안상 거부를 하기 때문
		//그래서 DAO(자바 코드)를 이용해서 가져오는 방법을 쓴다.
		$("#b3").click(function() {
			
		$.ajax({
			url :"https://openapi.naver.com/v1/search/movie.xml",
/* 			dataType:"XML",
			type:"GET", */
			crossOrigin: true,
			beforeSend : function(req){
				req.setRequestHeader("X-Naver-Client-Id","X9HvNHRmZ5U2NsZrh3fw");
				req.setRequestHeader("X-Naver-Client-Secret","3T5pYJndkn");
			},
			data : {query:"starwars"},
			success:function(xml){
				
				/* var xmlString = (new XMLSerializer()).serializeToString(xml);
				alert(xmlString ); */
				
				
				console.log(xml);
				//alert(JSON.stringify(xml));
				var myXML = xml.responseText;
				console.log(myXML);
				myXML = $.parseXML(myXML);
				myXML = $(myXML);
				//alert(myXML.find("item"));
				$("table").empty();

               // var idx =myXML.find("rss").children().length;
				//alert(idx);
				
				//가져온 xml 파일에서 menu를 찾아서 foreach로 파싱
				//i는 index 번호, m은 해당 index 번호의 객체
				$(myXML.find("item")).each(function(i, m) {
					alert("dd");
					var name = $(m).find("title").text();
					var price = $(m).find("pubDate").text();
					
					var td1 = $("<td></td>").text(name);
					var td2 = $("<td></td>").text(price);
					var tr1 = $("<tr></tr>").append(td1,td2);
					$("table").append(tr1);
					
				});
			},
			complete:function(){
				alert("성공");
			},
			error:function(xml){
				alert("애러");
			}
		}); 
		}); 
		
		//DAO(자바 코드)를 이용해서 가져오는 방법(XML)
		$("#b2").click(function() {
			var movieTitle = $("#i2").val();
			
			movieTitle = encodeURIComponent(movieTitle);
			$.ajax({
				url : "movie.get",
				data : {
					q : movieTitle
				},
				success : function(xml) {
					$("table").empty();
					//가져온 xml 파일에서 menu를 찾아서 foreach로 파싱
					//i는 index 번호, m은 해당 index 번호의 객체
					$(xml).find("item").each(function(i, m) {
						var t = $(m).find("title").text();
						var i= $(m).find("image").text();
						var u= $(m).find("userRating").text();
						
						var img = $("<img>").attr("src",i);
						var td1 = $("<td></td>").append(img);
						var td2 = $("<td></td>").html(t);
						var td3 = $("<td></td>").text(u);
						var tr1 = $("<tr></tr>").append(td1,td2,td3);
						$("table").append(tr1);
						
					});
					
				}
			});
		});
		$("#i2").keyup(function() {
			$("#b2").trigger("click");
		});
		

		
			//ajax: 브라우저의 동일 출처 정책으로 외부의 xml, json은 가져오지 못한다. 

			// Cross-Domain AJAX
			//		1. JSONP(JSON with Padding)
			//			서버쪽에서 파라메터 하나 지정(callback),
			//			callback=asd를 넣어 요청했을때
			//			결과가 asd(...) (JS함수형태)로 나오게 설정
			// 아래 사이트는 jsonp가 적용 되어있어서 자동으로 크로스 도메인을 처리해 준다!
		$("#b1").click(function() {
			var cityName = $("#i1").val();

			$.ajax({
				url : "http://api.openweathermap.org/data/2.5/weather",
				data : {
					q : cityName,
					appid : "baff8f3c6cbc28a4024e336599de28c4",
					units : "metric",
					lang : "kr"
				},
				success : function(json) {
					// JSON -> String
					//alert(JSON.stringify(json));
					var w = json.weather[0].description;
					var i = json.weather[0].icon;
					i = "https://openweathermap.org/img/w/" + i + ".png"
					var t = json.main.temp;

					//alert(w+":"+i+":"+t);
					$("#h31").text(w);
					$("#h32").text(t);
					$("#img1").attr("src", i);

				}
			});

		});
	});
	
	
</script>
</head>
<body>
	<table></table>
	<h2>날씨검색</h2>
	<input id="i1">&nbsp;<button id="b1">도시명으로 검색</button>
	<br><img id = "img1"><h3 id = "h31"></h3><h3 id = "h32"></h3>
	<hr>
	영화 검색(네이버 API 사용)<p>
	<input id="i2">&nbsp;<button id = 'b2'>DAO를 이용</button>
	<button id = 'b3'>자바스크립트 이용</button>
	<hr>
	책 검색(카카오 API 사용)<p>
	<input id="i3">&nbsp;<button id = 'b4'>DAO를 이용</button>
</body>
</html>





