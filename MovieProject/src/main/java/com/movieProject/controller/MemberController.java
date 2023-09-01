package com.movieProject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {
	@RequestMapping(value="/memberLoginForm")
	public ModelAndView memberJoinForm() {
		System.out.println("로그인 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberLoginForm");
		return mav;
	}
}
