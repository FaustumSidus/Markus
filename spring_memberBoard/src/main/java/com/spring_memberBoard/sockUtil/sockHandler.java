package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class sockHandler extends TextWebSocketHandler {

	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	//ArrayList<String> idList = new ArrayList<String>();
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅방 접속");
		Map<String,Object> sessionAttributes = session.getAttributes();
		String loginId = (String)sessionAttributes.get("loginId");
		System.out.println(loginId);
		Gson gson = new Gson();
		HashMap<String,String> msgInfo = new HashMap<String,String>();
		msgInfo.put("msgType", "c");
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", "접속했습니다.");
		System.out.println(clientList.size());
		for(WebSocketSession client : clientList) {
			// 새 참여자 접속 안내 메시지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo))); // 에러 
		}
		/*
		idList.add(loginId);
		System.out.println(idList);
		for(int i=0; i<idList.size(); i++) {
			msgInfo.put("msgId", idList.get(i));
			session.sendMessage(new TextMessage(gson.toJson(msgInfo)));
		}
		*/
		clientList.add(session);
		for(WebSocketSession client : clientList){
		 	Map<String, Object> clientAttrs = client.getAttributes();
		 	String clientMemberId = (String)clientAttrs.get("loginId");
		 	HashMap<String,String> clientInfo = new HashMap<String,String>();
		 	clientInfo.put("msgType","c");
		 	clientInfo.put("msgId",clientMemberId);		 	
		 	clientInfo.put("msgComm","접속 했습니다.");
		 	session.sendMessage(new TextMessage(gson.toJson(clientInfo)));
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("메시지 전송");
		Map<String,Object> sessionAttributes = session.getAttributes();
		String loginId = (String)sessionAttributes.get("loginId");
		System.out.println(loginId);
		Gson gson = new Gson();
		HashMap<String,String> msgInfo = new HashMap<String,String>();
		msgInfo.put("msgType", "m");
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", message.getPayload());
		for(WebSocketSession client : clientList) {
			// 새 참여자 접속 안내 메시지 전송
			if(!client.getId().equals(session.getId())) {				
				client.sendMessage(new TextMessage(gson.toJson(msgInfo))); // 에러 
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("접속 종료");
		clientList.remove(session);
		Map<String,Object> sessionAttributes = session.getAttributes();
		String loginId = (String)sessionAttributes.get("loginId");
		System.out.println(loginId);
		Gson gson = new Gson();
		HashMap<String,String> msgInfo = new HashMap<String,String>();
		msgInfo.put("msgType", "d");
		msgInfo.put("msgId", loginId);
		msgInfo.put("msgComm", "접속을 종료했습니다.");
		for(WebSocketSession client : clientList) {
			// 새 참여자 접속 안내 메시지 전송
			client.sendMessage(new TextMessage(gson.toJson(msgInfo))); // 에러 
		}
	}
	
}
