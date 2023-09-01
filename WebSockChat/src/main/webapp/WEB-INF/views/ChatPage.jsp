<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<style type="text/css">
	#chatArea{
		border: 2px solid black;
		border-radius: 10px;
		width: 700px;
		padding: 10px;
		background-color:#9bbbd4;
		height:500px;
		overflow: scroll;
	}
	.rMsg>.comm{
		background-color:#ffffff;
	}
	.sMsg>.comm{
		background-color:#fef01b;
	}
	.comm{
		display: inline-block;
		padding: 10px;
		border-radius: 10px;
		max-width:220px;
	}
	.sMsg{
		text-align: right;
	}
	.connMsg{
		min-width:200px;
		max-width:300px;
		margin:5px auto;
		text-align:center;
		background-color: #556677;
		color: white;
		border-radius: 10px;
		padding:5px;
	}
	.mid{
		font-weight: bold;
		font-size: 13px;
		margin-bottom: 2px;
	}
	#inputMsg{
		border: 2px solid black;
		border-radius: 10px;
		width: 700px;
		padding: 10px;
		display: flex;
	}
	#inputMsg>input{
		width: 90%;
		padding:5px;
	}
	#inputMsg>button{
		width:10%;
		padding:5px;
	}
	</style>
</head>
<body>
	<h1>ChatPage.jsp - ${sessionScope.loginId }</h1>
	<hr>
	<div id="chatArea">
		<div class="rMsg">
			<div clsss="mid">아이디</div>
			<div class="comm">수신 메시지</div>
		</div>
		<div class="sMsg">
		 	<div class="comm">송신메시지</div>
		</div>
		<div class="cMsg">
		 	<div class="connMsg">접속/접속해제</div>
		</div>
	</div>
	<div id="inputMsg">
	<input type="text" id="sendMsg">
	<button onclick="sendMsg()">전송</button>
	</div>
</body>
<script type="text/javascript">
	var sock = new SockJS('chatPage');
	sock.onopen = function() {
	    console.log('open');
	    //sock.send('test');
	};
	
	sock.onmessage = function(e) {
	    console.log('받은 메시지', e.data);
	    let msgObj = JSON.parse(e.data);
	 	//console.log("msgType : "+msgObj.msgType);
	    //console.log("msgId : "+msgObj.msgId);
	    //console.log("msgComm : "+msgObj.msgComm);   
	    //sock.close();
	    let mtype = msgObj.msgType;
	    console.log(mtype);
	    switch(mtype){
	    case "m":
	    	printMessage(msgObj); // 메시지 출력 
	    	break;
	    case "c":
	    case "d":
	    	printMessage(msgObj); // 접속정보 출력
	    	break;
	    }
	};
	
	sock.onclose = function() {
	    console.log('close');
	};
	let chatdiv = document.querySelector("#chatArea");
	function sendMsg(){
		let msgInput = document.querySelector("#sendMsg");
		sock.send(msgInput.value);
		let sendDiv = document.createElement('div');
		sendDiv.classList.add("sMsg");
		msgCommDiv=document.createElement('div');
		msgCommDiv.classList.add('comm');
		sendDiv.setAttribute('tabindex',"0");
		msgCommDiv.innerText = msgInput.value;
		sendDiv.appendChild(msgCommDiv);
		chatdiv.appendChild(sendDiv);
		sendDiv.focus();
		msgInput.value = "";
	}
	function printMessage(mObj){
		let msgtype = mObj.msgType;
		console.log(msgtype)
	    switch(msgtype){
	    case "m":
	    	let receiveDiv = document.createElement('div');
			receiveDiv.classList.add("rMsg");
			rmsgidDiv=document.createElement('div');
			rmsgidDiv.classList.add('mId');
			rmsgidDiv.innerText = mObj.msgId;
			receiveDiv.appendChild(rmsgidDiv);
			rmsgCommDiv=document.createElement('div');
			rmsgCommDiv.classList.add('comm');
			receiveDiv.setAttribute('tabindex',"0");
			rmsgCommDiv.innerText = mObj.msgComm;
			receiveDiv.appendChild(rmsgCommDiv);
			chatdiv.appendChild(receiveDiv);
			receiveDiv.focus();
	    	break;
	    case "c":
	    	
	    case "d":
	    	let conDiv = document.createElement('div');
			conDiv.classList.add("connMsg");
			conDiv.innerText = mObj.msgId+" 이/가 "+mObj.msgComm;
			conDiv.setAttribute('tabindex',"0");
			chatdiv.appendChild(conDiv);
			conDiv.focus();
	    	break;
	    }
	}
</script>
</html>