package com.movieProject.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.dto.Movie;
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
		ArrayList<Movie> mList = msvc.getMovieList();
		mav.setViewName("movie/movieList");
		mav.addObject("mov",mList);
		//System.out.println(mList);
		return mav;
	}
}
