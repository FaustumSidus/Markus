package com.movieProject.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.movieProject.dto.Movie;
import com.movieProject.dto.Reserve;
import com.movieProject.dto.Review;
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
		String registResult = msvc.registReserveInfo(re);		
		//System.out.println("mid : "+re.getMid());
				
		//System.out.println("mvcode : "+re.getMvcode());
		//System.out.println("thcode : "+re.getThcode());
		//System.out.println("schall : "+re.getSchall());
		//System.out.println("mvcode : "+re.getScdate());
		return registResult;
	}
	@RequestMapping(value="/reviewWriteForm")
	public ModelAndView reviewWriteForm(String recode,String mvcode) {
		System.out.println("관람평 작성 페이지 이동");
		//System.out.println(mvcode);
		Movie mv = msvc.getDetailMovie(mvcode);	
		//System.out.println(mv);
		ModelAndView mav = new ModelAndView();
		mav.addObject("mov", mv);
		// 관람 영화 정보 조회
		mav.setViewName("movie/ReviewWriteForm");
		return mav;
	}
	@RequestMapping(value="/registReview")
	public ModelAndView registReview(Review rv, HttpSession session, RedirectAttributes ra) {
		System.out.println("관람평 등록");
		ModelAndView mav = new ModelAndView();
		String mid = (String)session.getAttribute("loginId");
		rv.setMid(mid);
		//System.out.println(rv);
		int insertResult = msvc.registReview(rv);
		if(insertResult > 0) {
			//System.out.println("작성 완료");
			ra.addFlashAttribute("msg", "작성 완료");
			mav.setViewName("redirect:/reserveInfo");
		} else {
			//System.out.println("작성 실패");
			ra.addFlashAttribute("msg", "작성 실패");
			mav.setViewName("redirect:/reviewWriteForm");
		}
		return mav;
	}
	@RequestMapping(value="/reviewInfo")
	public ModelAndView reviewInfo(String mvcode) {
		//System.out.println(mvcode);
		Movie mv = msvc.getDetailMovie(mvcode);
		//System.out.println(mv);
		ModelAndView mav = new ModelAndView();
		// 2. service - 관람평 목록 조회
		// 관람평 작성자(아이디, 프로필)
		// 관람평 내용, 작성일
		ArrayList<Review> reList = msvc.getReList(mvcode);
		System.out.println(reList);
		mav.addObject("mov", mv);
		mav.addObject("reList", reList);
		mav.setViewName("movie/detailMovieInfo");
		return mav;
	}
	@RequestMapping(value="/deleteReview")
	public ModelAndView deleteReview(String mvcode, String rvcode) {
		ModelAndView mav = new ModelAndView();
		//System.out.println("mvcode : "+mvcode);
		//System.out.println("rvcode : "+rvcode);
		int deleteResult = msvc.deleteReview(rvcode);
		if(deleteResult > 0) {
			mav.setViewName("redirect:/reviewInfo?mvcode="+mvcode);
		} else {
			
		}
		return mav;
	}
}
