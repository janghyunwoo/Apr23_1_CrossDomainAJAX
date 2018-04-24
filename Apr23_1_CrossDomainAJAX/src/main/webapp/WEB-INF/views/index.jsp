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
		
		//DAO(�ڹ� �ڵ�)�� �̿��ؼ� �������� ���(JSON)
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
					
					$.each(arr, function(i, s) { //s�� ��ü�̴�. {}����
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
		
		//�̿ϼ� �ڵ��̴�.. �ȵǴ� �Ͱ���..
		//���� �ȵȴ�. �ֳ��ϸ�  ���� ��ó ��å(Same-Origin Policy)���� ���� �������� ��û�ϴ� ���� �ƴϸ� ���Ȼ� �źθ� �ϱ� ����
		//�׷��� DAO(�ڹ� �ڵ�)�� �̿��ؼ� �������� ����� ����.
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
				
				//������ xml ���Ͽ��� menu�� ã�Ƽ� foreach�� �Ľ�
				//i�� index ��ȣ, m�� �ش� index ��ȣ�� ��ü
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
				alert("����");
			},
			error:function(xml){
				alert("�ַ�");
			}
		}); 
		}); 
		
		//DAO(�ڹ� �ڵ�)�� �̿��ؼ� �������� ���(XML)
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
					//������ xml ���Ͽ��� menu�� ã�Ƽ� foreach�� �Ľ�
					//i�� index ��ȣ, m�� �ش� index ��ȣ�� ��ü
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
		

		
			//ajax: �������� ���� ��ó ��å���� �ܺ��� xml, json�� �������� ���Ѵ�. 

			// Cross-Domain AJAX
			//		1. JSONP(JSON with Padding)
			//			�����ʿ��� �Ķ���� �ϳ� ����(callback),
			//			callback=asd�� �־� ��û������
			//			����� asd(...) (JS�Լ�����)�� ������ ����
			// �Ʒ� ����Ʈ�� jsonp�� ���� �Ǿ��־ �ڵ����� ũ�ν� �������� ó���� �ش�!
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
	<h2>�����˻�</h2>
	<input id="i1">&nbsp;<button id="b1">���ø����� �˻�</button>
	<br><img id = "img1"><h3 id = "h31"></h3><h3 id = "h32"></h3>
	<hr>
	��ȭ �˻�(���̹� API ���)<p>
	<input id="i2">&nbsp;<button id = 'b2'>DAO�� �̿�</button>
	<button id = 'b3'>�ڹٽ�ũ��Ʈ �̿�</button>
	<hr>
	å �˻�(īī�� API ���)<p>
	<input id="i3">&nbsp;<button id = 'b4'>DAO�� �̿�</button>
</body>
</html>





