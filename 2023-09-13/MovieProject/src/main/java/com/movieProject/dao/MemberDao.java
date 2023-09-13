package com.movieProject.dao;

import org.apache.ibatis.annotations.Param;

import com.movieProject.dto.Member;

public interface MemberDao {

	Member selectMemberInfo(String id);

	int insertMember_kakao(Member member);

	int registMember(Member member);

	Member getLoginResult(@Param("userId")String userId, @Param("userPw")String userPw);

}
