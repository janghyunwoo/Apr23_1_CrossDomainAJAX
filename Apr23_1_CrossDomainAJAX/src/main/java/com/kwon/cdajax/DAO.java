package com.kwon.cdajax;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service
public class DAO {

	public String getKakaoBookData(HttpServletRequest req, HttpServletResponse res) {
		try {
			String q = req.getParameter("q");
			URL u 
				= new URL(
			"https://dapi.kakao.com/v2/search/book?query=" + q);
			
			HttpsURLConnection huc = (HttpsURLConnection) u.openConnection();
			huc.addRequestProperty("Authorization", "KakaoAK 172fc1fbb03529f956106c89d5a40c4a");
			
			InputStream is = huc.getInputStream();
			InputStreamReader isr = new InputStreamReader(is, "utf-8");
			BufferedReader br = new BufferedReader(isr);
			String line = null;
			StringBuffer sb = new StringBuffer();
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			return sb.toString();
		} catch (Exception e) {
			return null;
		}
	}
	
	
	public String getNaverMovieData(HttpServletRequest req, HttpServletResponse res) {
		try {
			String q = req.getParameter("q");

			URL u = new URL("https://openapi.naver.com/v1/search/movie.xml?query=" + q);
			
			HttpsURLConnection huc = (HttpsURLConnection) u.openConnection();
			
			huc.addRequestProperty("X-Naver-Client-Id", "X9HvNHRmZ5U2NsZrh3fw");
			huc.addRequestProperty("X-Naver-Client-Secret", "3T5pYJndkn");

			InputStream is = huc.getInputStream();

			InputStreamReader isr = new InputStreamReader(is, "utf-8");
			BufferedReader br = new BufferedReader(isr);
			String line = null;
			StringBuffer sb = new StringBuffer();
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}

			return sb.toString();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

}
