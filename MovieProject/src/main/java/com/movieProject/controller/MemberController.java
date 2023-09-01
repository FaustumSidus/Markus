package com.movieProject.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.movieProject.dto.Member;
import com.movieProject.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memsvc;
	@RequestMapping(value="/memberLoginForm")
	public ModelAndView memberJoinForm() {
		System.out.println("로그인 페이지 이동요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberLoginForm");
		return mav;
	}
	@RequestMapping(value="/memberLogin_kakao")
	public @ResponseBody String memberLogin_kakao(String id, HttpSession session) {
		System.out.println("카카오 로그인 요청");
		System.out.println("카카오 id : "+id);
		// Member, MemberService, MemberDao
		Member loginMember = memsvc.getLoginMemberInfo_kakao(id);
		if(loginMember == null) {
			System.out.println("카카오 계정 정보 없음");
			return "N";
		} else {
			System.out.println("카카오 계정 정보 있음");
			System.out.println("로그인 처리");
			session.setAttribute("loginId", loginMember.getMid());
			session.setAttribute("loginName", loginMember.getMname());
			return "Y";
		}
	}
	@RequestMapping(value="/memberJoin_kakao")
	public @ResponseBody String memberJoin_kakao(Member member) {
		System.out.println("카카오 계정 - 회원가입 요청 - memberJoin_kakao");
		System.out.println(member);
		int result = memsvc.registMember_kakao(member);
		return result+"";
	}	

	
}
