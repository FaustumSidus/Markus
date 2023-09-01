package com.movieProject.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adsvc;
	@RequestMapping(value ="/getCgvMovieInfo")
	public ModelAndView getCgvMovieInfo() throws IOException {
		ModelAndView mav = new ModelAndView();
		System.out.println("영화정보 수집요청");
		int addCount = adsvc.addCgvMovie(); 
		System.out.println("추가 : "+addCount+"개");
		mav.setViewName("redirect:/");
		return mav;
	}
	@RequestMapping(value="/getCgvTheaterInfo")
	public ModelAndView getCgvTheaterInfo() {
		System.out.println("극장정보 수집요청");
		int addCount = adsvc.addCgvTheaters();
		System.out.println("추가 : "+addCount+"개");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("home");
		return mav;
	}
	@RequestMapping(value="/getCgvScheduleInfo")
	public ModelAndView getCgvScheduleInfo() {
		System.out.println("시간표 정보 수집요청");
		int addCount = adsvc.addCgvScheduleInfo();
		System.out.println("추가 : "+addCount+"개");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("home");
		return mav;
	}
	@RequestMapping(value="/mapperTest")
	public String mapperTest(String thcode) {
		System.out.println("선택한 극장 : "+thcode);
		adsvc.mapperTest_Movie(thcode);
		return "redirect:/";
	}
}
