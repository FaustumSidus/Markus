package com.spring_memberBoard.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring_memberBoard.dto.Member;
import com.spring_memberBoard.service.MemberService;

@Controller
public class MemberController {
	int idCheck = 0;
	@Autowired
	MemberService msvc;
	@RequestMapping(value = "/memberJoinForm")
	public ModelAndView memberJoinForm() {
		System.out.println("회원가입 페이지 접근 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberJoinForm");
		return mav;
	}
	@RequestMapping(value = "/memIdCheck")
	// ajax 사용 시 responsebody 응답 객체 바디(데이터 주고받음)
	public @ResponseBody String memIdCheck(String inputId) {
//		System.out.println("아이디 중복확인 요청");
//		System.out.println("확인할 아이디 : "+inputId);
		String checkResult = msvc.idCheck(inputId);
		//1. 서비스 호출 아이디 중복 확인 기능
		// MEMBERS 테이블 MID 컬럼에 저장된 아이디인지 확인
		// SELECT * FROM MEMBERS WHERE MID = inputId;
		if(checkResult == "Y") {
			idCheck = 1;
		}
		return checkResult;
	}
	/*
	 1. 로그인 페이지 이동 요청 처리
	 2. 로그인 요청 처리 /memberLogin
	 */
	@RequestMapping(value = "/memberLoginForm")
	public ModelAndView memberLoginForm() {
		System.out.println("로그인 페이지 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberLogin");
		return mav;
	}
	
	@RequestMapping(value = "/memberLogout")
	public ModelAndView memberLogout(HttpSession session, RedirectAttributes ra){
		System.out.println("로그아웃 요청");
		ModelAndView mav = new ModelAndView();
		session.removeAttribute("loginId");
		mav.setViewName("redirect:/");
		ra.addFlashAttribute("msg", "로그아웃 성공");
		return mav;
	}
	@RequestMapping(value = "/memberLogin")
	public @ResponseBody ModelAndView memberLogin(String mid, String mpw, HttpSession session, RedirectAttributes ra) {
		System.out.println("로그인 처리 요청 - /memberLogin");
		System.out.println(mid);
		System.out.println(mpw);
		// 1. 로그인 아이디, 비밀번호 파라메터 확인
		// 2. service - 로그인 회원정보 조회 호출
		ModelAndView mav = new ModelAndView();
		Member loginMember = msvc.getLoginInfo(mid, mpw);
		if(loginMember == null) {
			System.out.println("로그인 실패");
			mav.setViewName("redirect:/memberLoginForm");
			ra.addFlashAttribute("msg", "로그인 실패");
		} else {
			System.out.println("로그인 성공");
			session.setAttribute("loginId", mid);
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg", "로그인 성공");
		}
		return mav;
	}
	
	@RequestMapping(value = "/memberJoin")
	public ModelAndView memberJoin(Member member, String memail, String memailDomain,
								   RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		System.out.println("회원가입 요청");
		member.setMemail(memail+"@"+memailDomain);
		System.out.println(member.getMemail());
		int joinResult = msvc.joinMember(member);
		/* RedirectArrtibutes 
		 * */
		if(joinResult > 0) {
			System.out.println("회원가입 성공");
			mav.setViewName("redirect:/");
			//redirect 일 때만 사용 가능
			ra.addFlashAttribute("msg", "회원가입 성공");
		} else {
			System.out.println("회원가입 실패");
			mav.setViewName("redirect:/memberJoinForm");
			ra.addFlashAttribute("msg", "회원가입 실패");
		}
		return mav;
	}
	@RequestMapping(value="/myInfo")
	public ModelAndView myInfo(String mid, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		Member mem = msvc.getInfo(mid);
		if(mem != null) {
			System.out.println(mem);
			ra.addFlashAttribute("msg", "회원 정보 조회 성공");
			mav.addObject("member", mem);
			mav.setViewName("member/MyInfo");
		} else {
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg", "회원 정보 조회 실패");
		}
		return mav;
	}
	@RequestMapping(value="/memberModifyForm")
	public ModelAndView memberModifyForm(String mid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Member mem = msvc.getInfo(mid);
		if(mem != null) {
			System.out.println(mem);
			mav.addObject("member", mem);
			session.setAttribute("loginId", mid);
			mav.setViewName("member/MemberModifyForm");
		} else {
			mav.setViewName("redirect:/");
		}
		return mav;
	}
	@RequestMapping(value="memberModify")
	public ModelAndView memberModify(Member member, String memail, String memailDomain,
			   RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		System.out.println("회원가입 요청");
		member.setMemail(memail+"@"+memailDomain);
		System.out.println(member.getMemail());
		System.out.println(member);
		int modifyResult = msvc.modifyMember(member);
		if(modifyResult > 0) {
			System.out.println("정보수정 성공");
			mav.setViewName("redirect:/myInfo?mid="+member.getMid());
			ra.addFlashAttribute("msg", "정보수정 성공");
		} else {
			System.out.println("정보수정 실패");
			mav.setViewName("redirect:/memberModifyForm?mid="+member.getMid());
			ra.addFlashAttribute("msg", "정보수정 실패");
		}
		return mav;
	}
}
