package com.spring_memberBoard.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring_memberBoard.dao.ReplyDao;
import com.spring_memberBoard.dto.Reply;

@Service
public class ReplyService {
	@Autowired
	ReplyDao rdao;

	public int write(Reply reply) {
		int writeResult = rdao.write(reply);
		return writeResult;
	}

	public int getnum() {
		int maxnum = rdao.getnum();
		return maxnum;
	}

	public ArrayList<Reply> getReplyList(int rebno) {
		System.out.println("service - getRList");
		ArrayList<Reply> rList = rdao.getrList(rebno);
		return rList;
	}

	public int deleteReply(int renum) {
		System.out.println("service - deleteReply");
		return rdao.deleteReply(renum);
	}

	public String getBNum(String mid) {
		String rnum = rdao.getrNnum(mid);
		return rnum;
	}
	
}
