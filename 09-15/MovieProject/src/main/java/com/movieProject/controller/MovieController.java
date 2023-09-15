package com.movieProject.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Reserve;
import com.movieProject.dto.Theater;
import com.movieProject.service.MovieService;

@Controller
public class MovieController {
	@Autowired
	MovieService msvc;
	@RequestMapping(value="/detailMovie")
	public ModelAndView detailMovie(String mvcode) {
		ModelAndView mav = new ModelAndView();
		Movie mov = msvc.getDetailMovie(mvcode);
		mav.setViewName("movie/detailMovieInfo");
		mav.addObject("mov",mov);
		//System.out.println(mov);
		return mav;
	}
	@RequestMapping(value="/movieList")
	public ModelAndView movieList() {
		ModelAndView mav = new ModelAndView();
		ArrayList<Movie> mList = msvc.getMovieList("ALL");
		mav.setViewName("movie/movieList");
		mav.addObject("mov",mList);
		//System.out.println(mList);
		return mav;
	}
	@RequestMapping(value = "/reserveMovie")
	public ModelAndView reserveMovie() {
		System.out.println("영화 예매 페이지 이동요청 - /reserveMovie");
		ModelAndView mav = new ModelAndView();
		//영화 목록		
		ArrayList<Movie> mList = msvc.getMovieList("ALL");
		mav.addObject("mv",mList);
		//극장 목록
		ArrayList<Theater> tList = msvc.getTheaterList("ALL");
		mav.addObject("th",tList);
		mav.setViewName("movie/ReservePage");
		return mav;
	}
	@RequestMapping(value="/getMovieList_json")
	public @ResponseBody String getMovieList_json(String selThcode){
		System.out.println("예매페이지_영화 목록 조회 요청");
		System.out.println("selThcode : "+selThcode);
		//ArrayList<Movie> mList = msvc.getMovieList();
		return new Gson().toJson(msvc.getMovieList(selThcode));
	}
	@RequestMapping(value="/getTheaterList_json")
	public @ResponseBody String getTheaterList_json(String selMvcode){
		//System.out.println("예매페이지_극장 목록 조회 요청");
		//System.out.println(selMvcode);
		//ArrayList<Movie> mList = msvc.getMovieList();
		return new Gson().toJson(msvc.getTheaterList(selMvcode));
	}
	@RequestMapping(value="/getScheduleDateList_json")
	public @ResponseBody String getScheduleDateList_json(String mvcode, String thcode) {
		//System.out.println("mvcode : "+mvcode);
		//System.out.println("thcode : "+thcode);
		return new Gson().toJson(msvc.getScheduleList(mvcode, thcode));
	}
	@RequestMapping(value="/getScheduleTimeList_json")
	public @ResponseBody String getScheduleTimeList_json(String mvcode, String thcode, String scdate) {
		//System.out.println("mvcode : "+mvcode);
		//System.out.println("thcode : "+thcode);
		//System.out.println("scdate : "+scdate);	
		//System.out.println("getScheduleTimeList_json");
		return new Gson().toJson(msvc.getTimeList(mvcode, thcode, scdate));
	}
	@RequestMapping(value="/registReserveInfo")
	public @ResponseBody String registReserveInfo(Reserve re, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {
			return "login";
		} else {			
			re.setMid(loginId);
		}
		int registResult = msvc.registReserveInfo(re);		
		//System.out.println("mid : "+re.getMid());
				
		//System.out.println("mvcode : "+re.getMvcode());
		//System.out.println("thcode : "+re.getThcode());
		//System.out.println("schall : "+re.getSchall());
		//System.out.println("mvcode : "+re.getScdate());
		return Integer.toString(registResult);
	}
}