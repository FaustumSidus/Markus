package com.movieProject.ApiUtill;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.dto.Reserve;

@Controller
public class ApiController {
	@Autowired
	ApiService asvc;
	@RequestMapping(value = "/kakaoPay_ready")
	public @ResponseBody String kakaoPay_ready(Reserve reInfo, HttpSession session) {
		System.out.println("카카오페이 결제 준비 요청 - kakaoPay_ready");
		System.out.println(reInfo);
		String result = asvc.kakaoPay_ready(reInfo, session);
		return result;
	}
	@RequestMapping(value="/kakaoPay_approval")
	public ModelAndView kakaoPay_approval(String pg_token, HttpSession session) {
		System.out.println("카카오 결제 승인 요청");
		ModelAndView mav = new ModelAndView();
		System.out.println("pg_token : "+pg_token);
		String tid = (String)session.getAttribute("tid");
		System.out.println("tid : "+tid);
		String result = asvc.kakaoPay_approval(tid,pg_token);
		if(result == null) {
			System.out.println("결제 오류");
			mav.addObject("payResult", "N");
		} else {
			System.out.println("결제 승인");
			mav.addObject("payResult", "Y");
		}
		session.removeAttribute("tid");
		mav.setViewName("PayResult");
		return mav;
	}
	@RequestMapping(value="/kakaoPay_cancel")
	public ModelAndView kakaoPay_cancel() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("payResult", "N");
		mav.setViewName("PayResult");
		return mav;
	}
}
