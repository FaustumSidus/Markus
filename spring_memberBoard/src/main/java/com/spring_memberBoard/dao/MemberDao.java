package com.spring_memberBoard.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Member;

public interface MemberDao {
	@Select("SELECT * FROM MEMBERS WHERE MID = #{inputId}")
	Member selectMemberInfo(String inputId);
	
	
	@Select("SELECT * FROM MEMBERS WHERE MID = #{inputId} AND MPW = #{inputPw}")
	Member selectMemberLogin(@Param("inputId") String inputId, @Param("inputPw") String inputPw);

	Member selectMemberInfo_mapper(@Param("inputId") String inputId);

	int joinMember(Member member);

	@Update("UPDATE MEMBERS SET MPW = #{mpw},MNAME = #{mname},MBIRTH = #{mbirth},MEMAIL = #{memail} WHERE MID = #{mid}")
	int modifyMember(Member member);
	
	
}
