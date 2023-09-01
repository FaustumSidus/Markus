package com.spring_memberBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.spring_memberBoard.dto.Board;

public interface BoardDao {
	

	@Select("SELECT NVL(MAX(BNO),0) FROM BOARDS")
	int getBno(Board board);

	
	@Insert("INSERT INTO BOARDS "
			+ "VALUES(#{bno},#{bwriter},#{btitle},#{bcontents},#{bhits},#{bfilename},SYSDATE,'1')")
	int insert(Board board);

	@Select("SELECT * FROM BOARDS WHERE BNO = #{bno}")
	Board getBoard(int bno);

	@Select("SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BY BDATE DESC")
	ArrayList<Board> getBList();

	@Update("UPDATE BOARDS SET BSTATE = '0' WHERE BNO = #{bno}")
	int deleteBoard(int bno);

	@Select("SELECT COUNT(*) FROM BOARDS WHERE BSTATE = '1' AND BWRITER = #{mid}")
	String getBNum(String mid);

	@Select("SELECT COUNT(*) FROM REPLYS WHERE RESTATE = '1' AND REBNO = #{bno}")
	int getrnum(int bno);


	ArrayList<HashMap<String, String>> selectBoards_map();

	
	
}
