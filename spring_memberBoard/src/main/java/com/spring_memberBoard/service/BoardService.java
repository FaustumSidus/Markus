package com.spring_memberBoard.service;

import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring_memberBoard.dao.BoardDao;
import com.spring_memberBoard.dto.Board;

@Service
public class BoardService {
	@Autowired
	BoardDao bdao;

	public int registBoard(Board board, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("service - registBoard");
		// 글번호 생성	
		int bno = bdao.getBno(board)+1;
		board.setBno(bno);
		System.out.println(bno);
		// 업로드 파일 저장 - 경로 설정, 중복파일명 처리
		MultipartFile bfile = board.getBfile(); // 첨부파일
		String bfilename = ""; // 파일명 저장 변수
		String savePath = session.getServletContext().getRealPath("/resources/boardUpload"); // 파일 저장 경로
		if(!bfile.isEmpty()) { // 첨부파일 확인
			// 첨부파일 O
			System.out.println("첨부파일 O");
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			System.out.println("code : "+code);
			bfilename = code + "_" + bfile.getOriginalFilename();
			// 저장 경로 resources/boardUpload 폴더에 저장
			System.out.println("savePath : "+savePath);
			//J:\Spring-WorkSpace\spring_memberBoard\src\main\webapp\resources\boardUpload
			System.out.println("파일이름 : "+bfilename);
			board.setBfilename(bfilename);
			File newFile = new File(savePath,bfilename);
			bfile.transferTo(newFile);
//		bfile.transferTo();
			System.out.println(board);
		} else {
			board.setBfilename(bfilename);
		}
		int insertResult = bdao.insert(board);
		// 업로드 파일 이름 추출 - bfilename
		
		// DAO - INSERT INTO BOARDS....
		
		return insertResult;
	}

	public Board getBoard(int bno) {
		Board board = bdao.getBoard(bno);
		/*
		 1. 조회수 증가
		 2. 글정보 조회
		 3. 글내용 줄바꿈 문자 -> 태그로 치환
		 */
		return board;
	}

	public ArrayList getBList()  {
		System.out.println("service - getBList");
		ArrayList<Board> bList = bdao.getBList();	
		for(Board bo : bList) {
			int bno = bo.getBno();
			int recount = bdao.getrnum(bno);
			bo.setRecount(recount);
			System.out.println(recount);
		}
		return bList;
	}

	public int deleteBoard(int bno) {
		int dResult = bdao.deleteBoard(bno);
		return dResult;
	}

	public String getBNum(String mid) {
		String bNum = bdao.getBNum(mid);
		return bNum;
	}

	public ArrayList<HashMap<String, String>> getmap() {
		System.out.println("bsvc - getmap()");
		return bdao.selectBoards_map();
	}
}
