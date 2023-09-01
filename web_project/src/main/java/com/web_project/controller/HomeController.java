package com.web_project.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.web_project.service.CrawService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	CrawService csvc;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	@RequestMapping(value="/olive")
	public ModelAndView olive() throws IOException {
		ModelAndView mav = new ModelAndView();
		System.out.println("올리브영");
		ArrayList<HashMap<String, String>> prdList = csvc.getOliveRankItem();
		mav.addObject("prdList", prdList);
		mav.setViewName("OliveBest");
		System.out.println(prdList);
		return mav;
	}
	@RequestMapping(value="/prdSearch")
	public ModelAndView prdSerach(String searchText) throws IOException {
		System.out.println("CONTROLLER - /prdSearch");
		ModelAndView mav = new ModelAndView();
		//ArrayList<HashMap<String, String>> prdList_11st = csvc.get11stList(searchText);
		ArrayList<HashMap<String, String>> prdList_coopang = csvc.getPrdList_coopang(searchText);
		System.out.println(prdList_coopang);
		ArrayList<HashMap<String, String>> prdList_gmarket = csvc.getPrdList_gmarket(searchText);
		mav.addObject("prdList_coopang", prdList_coopang);
		mav.addObject("prdList_gmarket", prdList_gmarket);
		mav.setViewName("prdSearchResult");
		System.out.println(prdList_gmarket);
		return mav;
	}
}
