package com.springProject01.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springProject01.dao.BoardDao;
import com.springProject01.dto.Board;

@Service
public class BoardService {
	@Autowired
	private BoardDao bdao;
	public int boardInsert(Board board) {
		int insertResult = bdao.insertBoard(board);
		System.out.println(insertResult);
		return insertResult;
	}
	
}
