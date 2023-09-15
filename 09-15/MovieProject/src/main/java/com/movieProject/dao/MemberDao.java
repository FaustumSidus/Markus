package com.movieProject.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Member;
import com.movieProject.dto.Reserve;

public interface MemberDao {

	Member selectMemberInfo(String id);

	int insertMember_kakao(Member member);

	int registMember(Member member);

	Member getLoginResult(@Param("userId")String userId, @Param("userPw")String userPw);

	ArrayList<HashMap<String, String>> selectReserveList(String loginId);

	int deleteReserve(String recode);

}
