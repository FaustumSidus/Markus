package com.movieProject.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.movieProject.dao.MemberDao;
import com.movieProject.dto.Member;
import com.movieProject.dto.Reserve;
import com.movieProject.dto.Review;

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

	public int registMember(Member member, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("registMember() 호출");
		MultipartFile mfile = member.getMfile();
		String mfilename = "";
		String savePath = session.getServletContext().getRealPath("/resources/user/memUpload");
		if(!mfile.isEmpty()) {
			System.out.println("첨부파일 O");
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			mfilename = code+"_"+mfile.getOriginalFilename();
			member.setMprofile(mfilename);
			File newFile = new File(savePath,mfilename);
			mfile.transferTo(newFile);
			System.out.println(member);
		} else {
			member.setMprofile(mfilename);
		}
		try {
			int insertResult = memdao.registMember(member);
			return insertResult;
		} catch (Exception e) {
			int insertResult = 0; 
			return insertResult;
		}
	}
	
	public String midCheck(String inputId) {
		System.out.println("SERVICE - midCheck() 호출");
		System.out.println("아이디 : " + inputId);

		// SELECT * FROM MEMBERS WHERE MID = #{아이디}

		Member member = memdao.selectMemberInfo(inputId);

		System.out.println(member);

		String result = "N";

		if (member == null) {
			result = "Y";
		}

		return result;
	}
	
	public Member getLoginResult(String userId, String userPw) {
		System.out.println("getLoginResult");
		System.out.println(userId);
		System.out.println(userPw);
		Member loginResult = memdao.getLoginResult(userId, userPw);
		System.out.println(loginResult);
		return loginResult;
	}

	public Member getMemInfo(String id) {
		System.out.println("getMemInfo");
		return memdao.selectMemberInfo(id);
	}

	public ArrayList<HashMap<String, String>> getReserveList(String loginId) {
		ArrayList<HashMap<String, String>> rList = memdao.selectReserveList(loginId);
		for(HashMap<String,String> re : rList) {
			String recode = re.get("RECODE");
			String rvcode = memdao.selectReviewCode(recode);
			re.put("RVCODE", rvcode);
		}
		//ArrayList<Reserve> rList = memdao.selectReserveList(loginId);
		// 리뷰 유무 추가
		//int reviewCheck = memdao.getReviewCheck(loginId);
		return rList;
	}

	public int deleteReserve(String recode) {	
		return memdao.deleteReserve(recode);
	}
	/*
	public int registReview(Review rv) {
		String maxrvcode = memdao.getMaxrvcode(); 
		System.out.println(maxrvcode);
		String rvcode = genCode(maxrvcode);
		rv.setRvcode(rvcode);
		System.out.println(rv);
		return memdao.insertReview(rv);	
	}
	private String genCode(String currentCode) {
		// System.out.println("genCode() 호출 : "+currentCode);
		// currentCode = MV00000 :: 앞2자리 영문, 뒤 5자리 숫자
		String strCode = currentCode.substring(0, 2);
		int numCode = Integer.parseInt(currentCode.substring(2));
		String newCode = strCode + String.format("%05d", numCode + 1);
		return newCode;
	}
	*/
}
