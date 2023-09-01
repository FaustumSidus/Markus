package com.springProject01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springProject01.dto.Member;


@Controller
public class MainController {
	
	@RequestMapping(value = "/")
	public ModelAndView mainPage() {
		System.out.println("controller - /요청");
		ModelAndView mav = new ModelAndView();
		mav.addObject("maindata", "TESTDATA");
/*		1. 데이터 - SERVICE
		ArrayList<Board> bList = svc.getBoardList();
		mav.addObject("이름", 데이터); 데이터 필요 없으면 불필요함
		2. 포워딩 - 페이지 지정		
*/	
		mav.setViewName("MemberJoin");
		return mav; // /WEB-INF/views/main.jsp
	}

	@RequestMapping(value = "/testPage")
	public ModelAndView testPage(int testnum,
							@RequestParam(value="teststr")String tstr,
							@RequestParam(value="testval", defaultValue = "TEST")String testval) {
		System.out.println("testPage - /요청");
		System.out.println("testnm : "+testnum);
		System.out.println("tstr : "+tstr);
		System.out.println("testVal : "+testval);
		return null;
	}
	@RequestMapping(value = "/testJoin")
	public ModelAndView testJoin(Member member) {
		ModelAndView mav = new ModelAndView();
		System.out.println("/testJoin 요청");
		System.out.println(member);
		System.out.println(member.getMid());
		mav.setViewName("redirect:/");
/*		1. 회원가입 회원정보 파라메터 확인
		2. SERVICE 회원가입 기능 호출
		회원가입 성공 >> 메인페이지 이동
*/
		
		return mav;
	}
}
