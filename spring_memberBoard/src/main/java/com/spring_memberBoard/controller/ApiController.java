package com.spring_memberBoard.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring_memberBoard.dto.Bus;
import com.spring_memberBoard.service.ApiService;

@Controller
public class ApiController {
	@Autowired
	ApiService asvc;
	@RequestMapping(value="/busapi")
	public ModelAndView busapi() throws IOException {
		ModelAndView mav = new ModelAndView();
		ArrayList<Bus> result = asvc.getBusArrive();
		mav.addObject("busList", result);
		mav.setViewName("BusList");
		return mav;
	}
	@RequestMapping(value="/busapi_ajax")
	public ModelAndView busapi_ajax() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("BusList_ajax");
		return mav;
	}
	@RequestMapping(value="/getBusArr")
	public @ResponseBody String getBusArr(String nodeId, String cityCode) {
		System.out.println("버스 도착정보 조회");
		System.out.println("nodeId : "+nodeId);
		//1. 도착정보 조회 기능 호출
		String arrInfoList;
		try {
			arrInfoList = asvc.getBusArrInfoList(nodeId, cityCode);
			return arrInfoList;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		}
		//2. 도착정보 반환
	}
	@RequestMapping(value="/getBusSt")
	public @ResponseBody String getBusSt(String lati, String longti) throws IOException {
		System.out.println("lati : "+lati);
		System.out.println("longti : "+longti);
		String busStList = asvc.getBusSt(lati, longti);
		return busStList;
	}
	@RequestMapping(value="/busloc")
	public @ResponseBody String busloc(String cityCode, String routeId) throws IOException {
		String locList = asvc.getBusLoc(cityCode, routeId);
		System.out.println(locList);
		return locList;
	}
	@RequestMapping(value="/busloList")
	public @ResponseBody String busloList(String cityCode, String routeId) throws IOException {
		String bList = asvc.getBList(cityCode, routeId);
		return bList;
	}
}
