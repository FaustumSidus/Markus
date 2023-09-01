package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class noticeHandler extends TextWebSocketHandler{
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 클라이언트가 웹소켓에 접속 시 실행
		clientList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 클라이언트가 웹소켓에 메시지를 전송 시 실행
		
		// message >> 댓글 작성 글번호, 작성된 글 작성자
		// 공지종류 : 새 글 등록 알림(전체), 댓글 등록 알림(개별)
		// 새 글 등록 알림 : "새 글이 등록 되었습니다."
		// 댓글 등록 알림 : "??번글에 댓글이 등록되었습니다."
		// 글번호, 알림 받을 대상
		JsonObject noticeObj = JsonParser.parseString(message.getPayload()).getAsJsonObject();
		
		String noticeType = noticeObj.get("noticeType").getAsString();
		HashMap<String,String> msgInfo = new HashMap<String,String>();
	 	msgInfo.put("msgType",noticeType);
		switch(noticeType) {
		case "reply": // 글 작성자(bwriter) 개별 전송 
			String bno = noticeObj.get("noticeMsg").getAsString();
			String bwriter = noticeObj.get("receiveId").getAsString();
			msgInfo.put("msgComm", bno);
			for(WebSocketSession client: clientList) {
				Map<String,Object> clientAttrs = client.getAttributes();
				String clientMemberId = (String)clientAttrs.get("loginId");
				if(clientMemberId.equals(bwriter)) {
					client.sendMessage(new TextMessage(new Gson().toJson(msgInfo)));
				}
			}
			break;
		case "board": // 전체 전송
			// 서버 접속중인 클라이언트들에 메시지 전송
			msgInfo.put("msgComm", "새 글 등록");
			for(WebSocketSession client: clientList) {
				if(!client.getId().equals(session.getId())) {
					client.sendMessage(new TextMessage(new Gson().toJson(msgInfo)));
				}
			}
			break;
		}
	}

	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 클라이언트가 웹소켓에 접속 해제 시 실행
		clientList.remove(session);
	}
	
}
