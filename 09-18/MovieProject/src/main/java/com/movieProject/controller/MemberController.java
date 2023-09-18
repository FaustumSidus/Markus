package com.movieProject.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.movieProject.dto.Member;
import com.movieProject.dto.Reserve;
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
			String mstate = loginMember.getMstate().substring(0, 1);
			System.out.println(mstate.equals("Y")); // "YK", "YC", "NK", "NC"
			System.out.println("로그인 성공");
			session.setAttribute("loginId", loginMember.getMid());
			session.setAttribute("loginImg", loginMember.getMprofile());
			session.setAttribute("loginName", loginMember.getMname());
			session.setAttribute("loginState", loginMember.getMstate());
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
	
	@RequestMapping(value="/memberJoinForm")
	public ModelAndView memberJoinForm(Member member) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/MemberJoinForm");
		return mav;
	}	
	
	@RequestMapping(value="/memberJoin")
	public ModelAndView memberJoin(Member member, String memailDomain, HttpSession session, RedirectAttributes re) throws IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();
		System.out.println(member);
		String memail = member.getMemail()+'@'+memailDomain;
		member.setMemail(memail);
		System.out.println(member.getMfile().getOriginalFilename());		
		int writeResult = 0;
		writeResult = memsvc.registMember(member, session);
		if(writeResult > 0) {
			System.out.println("회원가입 성공");
			re.addFlashAttribute("msg", "회원가입 성공");
			mav.setViewName("redirect:/memberLoginForm");
		} else {
			System.out.println("회원가입 실패");
			re.addFlashAttribute("msg", "회원가입 실패");
			mav.setViewName("redirect:/memberJoinForm");
		}
		return mav;
	}	
	@RequestMapping(value="/memberIdCheck")
	public @ResponseBody String memIdCheck(String inputId) {
		System.out.println("memberIdCheck - 호출");
		
		System.out.println("iputId : " + inputId);
		
		String checkResult = memsvc.midCheck(inputId);
		
		return checkResult;
	}
	@RequestMapping(value="/memberLogin")
	public ModelAndView memberLogin(String userId, String userPw, HttpSession session, RedirectAttributes re) {
		session.removeAttribute("loginId");
		session.removeAttribute("loginKakaoName");
		ModelAndView mav = new ModelAndView();
		System.out.println("userid : "+userId);
		System.out.println("userpw : "+userPw);
		Member loginResult = memsvc.getLoginResult(userId, userPw);
		if(loginResult != null) {
			String mstate = loginResult.getMstate().substring(0, 1);
			System.out.println(mstate.equals("Y")); // "YK", "YC", "NK", "NC"
			System.out.println("로그인 성공");
			re.addFlashAttribute("msg", "로그인 성공");
			session.setAttribute("loginId", loginResult.getMid());
			session.setAttribute("loginName", loginResult.getMname());
			session.setAttribute("loginImg", loginResult.getMprofile());
			session.setAttribute("loginState", loginResult.getMstate());
			mav.setViewName("redirect:/");
		} else {
			System.out.println("로그인 실패");	
			re.addFlashAttribute("msg", "로그인 실패");
			mav.setViewName("redirect:/memberLoginForm");
		}
		return mav;
	}
	@RequestMapping(value="/memberInfo")
	public ModelAndView memberInfo(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String id = (String)session.getAttribute("loginId");
		if(id == null) {
			mav.setViewName("member/MemberLoginForm");
			return mav;
		}
		Member memInfo = memsvc.getMemInfo(id);
		if(memInfo != null) {
			mav.addObject("mem", memInfo);
			System.out.println(memInfo);
			mav.setViewName("member/MemberInfo");
		} else {
			mav.setViewName("redirect:/");
		}
		return mav;
	}
	@RequestMapping(value="/memberLogout")
	public ModelAndView memberLogout(HttpSession session, RedirectAttributes re) {
		ModelAndView mav = new ModelAndView();
		session.removeAttribute("loginId");
		re.addFlashAttribute("msg", "로그아웃 성공");
		mav.setViewName("redirect:/");
		return mav;
	}
	@RequestMapping(value="/reserveInfo")
	public ModelAndView reserveInfo(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {
			mav.setViewName("member/MemberLoginForm");
			return mav;
		}
		ArrayList<HashMap<String, String>> rList = memsvc.getReserveList(loginId);
		System.out.println(rList);
		mav.addObject("rList",rList);
		mav.setViewName("member/ReserveInfo");
		return mav;
	}
	@RequestMapping(value="/cancelReserve")
	public ModelAndView cancelReserve(String recode, HttpSession session, RedirectAttributes ra) {		
		ModelAndView mav = new ModelAndView();
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {
			mav.setViewName("member/MemberLoginForm");
			return mav;
		}
		int delResult = memsvc.deleteReserve(recode);
		if(delResult == 1) {
			ra.addFlashAttribute("msg", "취소 성공");
		} else {
			ra.addFlashAttribute("msg", "취소 실패");
		}	
		mav.setViewName("redirect:/reserveInfo");
		return mav;
	}
	}

