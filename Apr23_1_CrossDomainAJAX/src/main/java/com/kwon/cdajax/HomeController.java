package com.kwon.cdajax;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class HomeController {
	@Autowired private DAO d;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest req, HttpServletResponse res) {
		return "index";
	}
	
	@RequestMapping(value = "/movie.get",
			method = RequestMethod.GET, 
			produces = "application/xml; charset=utf-8")
	public @ResponseBody String movieGet(HttpServletRequest req, HttpServletResponse res) {
		
		return d.getNaverMovieData(req, res);
	}
	
	@RequestMapping(value = "/book.get",
			method = RequestMethod.GET, 
			produces = "application/json; charset=utf-8")
	public @ResponseBody String bookGet(HttpServletRequest req, HttpServletResponse res) {
		return d.getKakaoBookData(req, res);
	}
}















