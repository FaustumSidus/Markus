<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<style type="text/css">
	#chatArea{
		border: 2px solid black;
		width: 500px;
		padding: 10px;
	}
	.receiveMsg{
		margin-bottom: 3px;
	}
	.sendMsg{
		text-align: right;
		margin-bottom: 3px;
	}
	</style>
</head>
<body>

	<h1>WebSockChat</h1>
	
	<P>  The time on the server is ${serverTime}. </P>
	
	<input type="text" id="sendMsg">
	<button onclick="msgSend()">전송</button>
	<div id="chatArea">
		<div class="receiveMsg">
			<!-- 받은 메시지 -->
			받은 메시지
		</div>
		
		<div class="sendMsg">
			<!-- 보낸 메시지 -->
			보낸 메시지
		</div>
		
	</div>
</body>
<script type="text/javascript">
	let chatDiv = document.querySelector("#chatArea");
	var sock = new SockJS('chatSocket');
	// 접속 시 실행
	sock.onopen = function() {
	    console.log('open');	  
	    //sock.send('test');// 서버로 메시지 전송
	};
	// 
	sock.onmessage = function(e) {
	    console.log('받은 메시지 : ', e.data);
	    let receiveDiv = document.createElement('div');
	    receiveDiv.classList.add("receiveMsg");
		receiveDiv.innerText = e.data;
		chatDiv.appendChild(receiveDiv);
	    //sock.close();
	};
	
	sock.onclose = function() {
	    console.log('close');
	};
	function msgSend(){
		let msgInput = document.querySelector("#sendMsg");
		console.log("보낸 메시지 : "+msgInput.value);
		sock.send(msgInput.value);
		let sendDiv = document.createElement('div');
		sendDiv.classList.add("sendMsg");
		sendDiv.innerText = msgInput.value;
		chatDiv.appendChild(sendDiv);
		msgInput.value = "";
		
	}
</script>
</html>
