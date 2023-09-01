package com.spring_memberBoard.sockUtil;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class sockController {
	@RequestMapping(value="/memChat")
	public String memChat(HttpSession session) {
		System.out.println("채팅방 이동 요청");
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {
			return "member/MemberLogin";
		}
		return "Chat";
	}
}
