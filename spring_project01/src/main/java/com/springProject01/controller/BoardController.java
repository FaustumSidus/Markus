package com.springProject01.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springProject01.dto.Board;
import com.springProject01.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	private BoardService bsvc;
	
	@RequestMapping(value = "/boardWriteForm")
	public ModelAndView BoardWrite() {
		System.out.println("BoardWrite 호출");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/boardWriteForm");
		return mav;
	}
	
	@RequestMapping(value = "/boardWrite")
	public ModelAndView BoardInsert(Board board) {
		System.out.println("BoardWrite 호출");
		ModelAndView mav = new ModelAndView();
		
		int insertResult = bsvc.boardInsert(board);
		if(insertResult > 0) {
			System.out.println("작성 완료");
		} else {
			System.out.println("작성 실패");
		}
		mav.setViewName("redirect:/");
		return mav;
	}
	
}
