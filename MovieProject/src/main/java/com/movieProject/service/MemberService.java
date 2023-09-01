package com.movieProject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.movieProject.dao.MemberDao;
import com.movieProject.dto.Member;

@Service
public class MemberService {
	@Autowired
	private MemberDao memdao;
	
	public Member getLoginMemberInfo_kakao(String id) {
		System.out.println("getLoginMemberInfo_kakao");
		return memdao.selectMemberInfo(id);
	}

	public int registMember_kakao(Member member) {
		System.out.println("service - registMember_kakao()");
		return memdao.insertMember_kakao(member);		
	}
}
