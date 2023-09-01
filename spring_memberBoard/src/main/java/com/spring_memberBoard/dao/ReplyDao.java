package com.spring_memberBoard.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Reply;



public interface ReplyDao {
	
	@Insert("INSERT INTO REPLYS VALUES(#{renum},#{rebno},#{remid},#{recomment},SYSDATE,'1' )")
	int write(Reply reply);
	@Select("SELECT NVL(MAX(RENUM), 0) FROM REPLYS")
	int getnum();
	@Select("SELECT * FROM REPLYS WHERE REBNO = #{rebno} AND RESTATE = '1' ORDER BY REDATE DESC")
	ArrayList<Reply> getrList(int rebno);
	@Update("UPDATE REPLYS SET RESTATE = '0' WHERE RENUM = #{renum}")
	int deleteReply(int renum);
	@Select("SELECT COUNT(*) FROM REPLYS WHERE REMID = #{mid} AND RESTATE = '1'")
	String getrNnum(String mid);
	
}
