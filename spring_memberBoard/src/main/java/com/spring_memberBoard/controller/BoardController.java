package com.spring_memberBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring_memberBoard.dto.Board;
import com.spring_memberBoard.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	BoardService bsvc;
	
	@RequestMapping(value = "/boardList")
	public ModelAndView boardForm(){
		System.out.println("게시판 페이지 이동 요청");
		ModelAndView mav = new ModelAndView();
		ArrayList<Board> bList = null;
		try {
			bList = bsvc.getBList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<HashMap<String, String> >bList_map = bsvc.getmap();
		System.out.println(bList_map);
		mav.addObject("bListMap", bList_map);
		mav.addObject("bList", bList);
		mav.setViewName("board/Board");
		return mav;
	}
	@RequestMapping(value = "/boardWriteForm")
	public ModelAndView boardWriteForm(){
		System.out.println("글 작성 페이지 이동 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/boardWriteForm");
		return mav;
	}
	@RequestMapping(value = "/boardWrite")
	public ModelAndView boardWrite(Board board, HttpSession session, RedirectAttributes re){
		System.out.println("글 등록 요청");
		System.out.println(board);
		System.out.println(board.getBfile().getOriginalFilename());
		String bwriter = (String)session.getAttribute("loginId");
		System.out.println(bwriter);
		board.setBwriter(bwriter);
		System.out.println(board.getBfile().getOriginalFilename());
		System.out.println(session.getServletContext().getRealPath("/resources/boardUpload"));
		ModelAndView mav = new ModelAndView();
		int writeResult = 0;
		try {
			writeResult = bsvc.registBoard(board, session);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		// 오류나면 멈춤(더 이상 미룰 수 없다)
		if(writeResult > 0) {
			System.out.println("글 등록 성공");
			//re.addFlashAttribute("noticeMsg", "newBoard");
			mav.setViewName("redirect:/boardList");
		} else {
			System.out.println("글 등록 실패");
			re.addFlashAttribute("msg", "등록 실패");
			mav.setViewName("redirect:/boardWriteForm");
		}
		return mav;
	}
	
	@RequestMapping(value="/boardView")
	public ModelAndView boardView(int bno) {
		System.out.println("글 상세보기 요청");
		System.out.println("글 번호 : "+bno);
		ModelAndView mav = new ModelAndView();
		Board board = bsvc.getBoard(bno);
		System.out.println(board);
		mav.addObject("board", board);
		mav.setViewName("board/boardView");
		return mav;
	}
	
	@RequestMapping(value="/boardDelete")
	public ModelAndView boardDelete(int bno, RedirectAttributes re) {
		ModelAndView mav = new ModelAndView();
		int dResult = bsvc.deleteBoard(bno);
		if(dResult > 0) {
			System.out.println("삭제 완료");
			re.addFlashAttribute("msg", "삭제 완료");
			mav.setViewName("redirect:/boardList");
		} else {
			System.out.println("삭제 실패");
			re.addFlashAttribute("msg", "삭제 실패");
			mav.setViewName("redirect:/boardView");
		}
		return mav;
	}
	@RequestMapping(value="/boardInfo")
	public @ResponseBody String boardInfo(String mid) {
		System.out.println("글, 댓글 수 조회 요청");
		String bnum = bsvc.getBNum(mid);
		return bnum;
	}
}
