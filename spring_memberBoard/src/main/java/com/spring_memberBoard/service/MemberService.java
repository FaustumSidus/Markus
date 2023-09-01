package com.spring_memberBoard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring_memberBoard.dao.MemberDao;
import com.spring_memberBoard.dto.Member;

@Service
public class MemberService {
	@Autowired
	MemberDao mdao;
	public String idCheck(String inputId) {
//		System.out.println("service - idCheck()");
//		System.out.println("아이디 : "+inputId);
		System.out.println(inputId);
		Member member = mdao.selectMemberInfo(inputId);
		System.out.println(member);
		Member member_mapper = mdao.selectMemberInfo_mapper(inputId);
		System.out.println(member);
		String result = "N";
		if(member == null) {
			result = "Y";
		} 
		return result;
	}
	public int joinMember(Member member) {
		System.out.println("msvc - joinMember()");
		
		int joinMember = 0;
		try {
			joinMember = mdao.joinMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return joinMember;
	}
	public Member getLoginInfo(String mid, String mpw) {
		System.out.println("msvc - loginInfo()");
		Member mem = null;
		try {
			mem = mdao.selectMemberLogin(mid, mpw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mem;
	}
	public Member getInfo(String mid) {
		System.out.println("msvc - getInfo()");
		Member mem = mdao.selectMemberInfo(mid);
		return mem;
	}
	public int modifyMember(Member member) {
		System.out.println("msvc - modifyMember()");
		int modifyMember = 0;
		try {
			modifyMember = mdao.modifyMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return modifyMember;
	}
}
