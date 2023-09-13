package com.movieProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.dto.Movie;
import com.movieProject.service.MovieService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private MovieService msvc;
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home() {
		System.out.println("메인 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		//1. 영화 랭킹 목록 조회
		// SELECT * FROM MOVIES ORDER BY MVOPEN; 최신영화
		ArrayList<Movie> rankMovList = msvc.getRankMovList();
		//System.out.println(rankMovList);
		mav.addObject("rankMovList",rankMovList);
		//2. 이동 할 페이지 설정
		mav.setViewName("home");
		return mav;
	}
	
}
