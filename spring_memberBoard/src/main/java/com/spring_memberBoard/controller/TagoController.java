package com.spring_memberBoard.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.service.TagoService;

@Controller
public class TagoController {
	@Autowired
	TagoService tsvc;
	@RequestMapping(value="/tago")
	public ModelAndView tago() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Tago");
		return mav;
	}
	@RequestMapping(value="/tago2")
	public ModelAndView tago2() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Tago2");
		return mav;
	}
	
	@RequestMapping(value="/getStList")
	public @ResponseBody String getStList(String lati, String loti) throws IOException{
		String result = tsvc.getStList(lati,loti);
		return result;
	}
	@RequestMapping(value="/getArrList")
	public @ResponseBody String getArrList(String cityCode, String nodeId) throws IOException {
		String result = tsvc.getArrList(cityCode, nodeId);
		return result;
	}
	@RequestMapping(value="/getNodeList")
	public @ResponseBody String getNodeList(String cityCode, String routeId) throws IOException {
		String result = tsvc.getNodeList(cityCode,routeId);
		return result;
	}
	@RequestMapping(value="/getLocList")
	public @ResponseBody String getLocList(String cityCode, String routeId) throws IOException {
		String result = tsvc.getLocList(cityCode,routeId);
		return result;
	}
}
