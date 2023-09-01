package com.spring_memberBoard.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.spring_memberBoard.dto.Reply;
import com.spring_memberBoard.service.ReplyService;

@Controller
public class ReplyController {
	@Autowired
	ReplyService rsvc;
	@RequestMapping(value = "/replyWrite")
	//ajax(비동기) -> data only -> 페이지에 아무 영향 X -> ModelAndView X, @ResponseBody String O
	public @ResponseBody String replyWrite(Reply reply, int rebno, String recomment, HttpSession session, RedirectAttributes re) {
		System.out.println(rebno);
		System.out.println(recomment);
		reply.setRebno(rebno);
		reply.setRecomment(recomment);
		int maxnum = rsvc.getnum()+1;
		System.out.println(maxnum);
		reply.setRenum(maxnum);
		String remid = (String)session.getAttribute("loginId");
		reply.setRemid(remid);
		System.out.println(reply);
		int writeResult = rsvc.write(reply);
		//re.addFlashAttribute("noticeMsg", "작성 완료");
//		if(writeResult > 0) {
//			System.out.println("작성 완료");
//			//ra.addFlashAttribute("msg", "작성 완료");
//			//mav.setViewName("redirect:/boardView?bno="+rebno);
//		} else {
//			System.out.println("작성 실패");
//			//ra.addFlashAttribute("msg", "작성 실패");
//			//mav.setViewName("redirect:/boardView?bno="+rebno);
//		}
		return Integer.toString(writeResult);		
	}
	@RequestMapping(value = "/replyList")
	public @ResponseBody String replyList(int rebno) {
		System.out.println("댓글 조회 요청");
		System.out.println(rebno);
		ArrayList<Reply> replyList = rsvc.getReplyList(rebno);
		System.out.println(replyList);
		System.out.println(replyList.size());
		// gson 사용 -> json 변환 {key : value}
		Gson gson = new Gson();
		String reList = gson.toJson(replyList);
		System.out.println(reList);
		return reList;
	}
	@RequestMapping(value = "/deleteReply")
	public @ResponseBody String deleteReply(int renum) {
		System.out.println("댓글 삭제 요청 -deleteReply");
		System.out.println("삭제 번호 : "+renum);
		int result = rsvc.deleteReply(renum);
		return Integer.toString(result);
	}
	@RequestMapping(value="/replyInfo")
	public @ResponseBody String boardInfo(String mid) {
		System.out.println("글, 댓글 수 조회 요청");
		String rnum = rsvc.getBNum(mid);
		return rnum;
	}
}
