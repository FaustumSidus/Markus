package com.WebSockChat.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatPageHandler extends TextWebSocketHandler {
	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("채팅 페이지 접속");
		Map<String, Object> sessionAttrs = session.getAttributes(); 
		String loginId = (String)sessionAttrs.get("loginId");// 입장 클라이언트 아이디 저장
		Gson gson = new Gson();
		HashMap<String,String> msgInfo = new HashMap<String,String>();
		msgInfo.put("msgType", "c"); // c:connection, d:disconnection, m:Message
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", "접속했습니다.");
		for(WebSocketSession client : clientList) {
			// 새 참여자 접속 안내 메시지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo))); // 에러 
		}
		clientList.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("채팅 메시지 전송");
		System.out.println("전송 메시지 : "+message.getPayload());
		Map<String, Object> sessionAttrs = session.getAttributes(); 
		String loginId = (String)sessionAttrs.get("loginId");
		System.out.println("전송 아이디 : "+loginId);
		Gson gson = new Gson();
		HashMap<String,String> msgInfo = new HashMap<String,String>();
		msgInfo.put("msgType","m");
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", message.getPayload());
		for(WebSocketSession client : clientList) {
			if(!client.getId().equals(session.getId())) {
				client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("채팅 페이지 접속해제");
		clientList.remove(session);
		Map<String, Object> sessionAttrs = session.getAttributes(); 
		String loginId = (String)sessionAttrs.get("loginId");// 입장 클라이언트 아이디 저장
		Gson gson = new Gson();
		HashMap<String,String> msgInfo = new HashMap<String,String>();
		msgInfo.put("msgType", "d"); // c:connection, d:disconnection, m:Message
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", "접속을 해제했습니다.");
		for(WebSocketSession client : clientList) {
			client.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
	}
	
}
