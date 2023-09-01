package com.movieProject.dao;

import com.movieProject.dto.Member;

public interface MemberDao {

	Member selectMemberInfo(String id);

	int insertMember_kakao(Member member);

}
