package com.springProject01.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.springProject01.dto.Member;

public interface MemberDao {
	
	@Insert("INSERT INTO MEMBERS(MID,MPW,MNAME,MBIRTH,MADDR)"		
			+ " VALUES(#{mid},#{mpw},#{mname},#{mbirth},#{maddr})")
	int insertMember(Member member);
	@Select("SELECT * FROM MEMBERS")
	ArrayList<Member> selectMList();
}
