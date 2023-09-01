<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
    	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    	<style type="text/css">
    		body{
    			background-color:#d6e6f5;
    		}
    		
    		#chatArea{
				border: 2px solid black;
				border-radius: 10px;
				width: 700px;
				padding: 10px;
				background-color:#b5d692;
				height:500px;
				overflow: scroll;
			}
			.rMsg>.comm{
				background-color:#ffffff;
			}
			.sMsg>.comm{
				background-color:#d6e6f5;
			}
			.comm{
				display: inline-block;
				padding: 10px;
				border-radius: 10px;
				max-width:220px;
				margin: 15px;
			}
			.sMsg{
				text-align: right;
			}
			.connMsg{
				min-width:200px;
				max-width:300px;
				margin:5px auto;
				text-align:center;
				background-color: #a3cca3;
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
				background-color:#b5d692;
			}
			#inputMsg>input{
				width: 90%;
				padding:5px;
			}
			#inputMsg>button{
				width:10%;
				padding:5px;
			}
			#chatContents{
				display: flex;
			}
			#leftContent{
				margin: 5px;
			}
			#rightContent{
				width: 230px;
				margin: 5px;
			}
			#connMembersArea{
				box-sizing: border-box;
				border: 3px solid black;
				border-radius: 10px;
				height:	580px;
				padding: 7px;
			}
			.connMember{
				border: 2px solid black;
				border-radius: 7px;
				padding: 5px;
				margin-bottom: 5px;
			}
    	</style>
    </head>

    <body>
        <div class="mainWrap">
            <div class="header">
                <h1>메인 - views/Chat.jsp</h1>
            </div>

            <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

            <div class="contents">
				<div id="chatContents">
					<div id="leftContent">
						<div id="chatArea">
							<div class="rMsg">
							<div class="mid">아이디</div>
							<div class="comm">수신 메시지</div>
							</div>
							<div class="sMsg">
							<div class="comm">송신 메시지</div>
							</div>
							<div class="connMsg">접속/종료</div>
						</div>
						<div id="inputMsg">
							<input id="sendMsg">
							<button onclick="send()">전송</button>
						</div>
					</div>
					<div id="rightContent">
						<div id="connMembersArea">
							<div class="connMember">접속아이디</div>							
						</div>
					</div>
				</div>
            </div>
            	
        </div>
    </body>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    <script type="text/javascript">
    	let msgInputTag = document.querySelector("#sendMsg");
    	msgInputTag.addEventListener('keyup',function(e){
    			if(e.keyCode == 13){
    				send(); // Enter 키 입력 시 send()실행
    			}
    	})
    	let msg = '${msg}';
    	if(msg.length > 0){
    		alert(msg);
    	}
    	let loginId = '${loginId}';
    	if(loginId.length > 0){
    		$('#loginId').text('${loginId}');
    	}

    </script>
    <script type="text/javascript">
    	let chatDiv = document.querySelector("#chatArea");
    	var sock = new SockJS('memChat');
    	sock.onopen = function() {
    	    console.log('open');
    	    //sock.send('test');
    	};

    	sock.onmessage = function(e) {
    	    console.log('message', e.data);
    	    //sock.close();
    	    let msgObj = JSON.parse(e.data);
    	    let mType = msgObj.msgType;
    	    console.log(mType);
    	   	printMsg(msgObj);
    	    
    	};

    	sock.onclose = function() {
 	   	    //console.log('close');
    	};
    	function send(){
    		let msgInput = document.querySelector("#sendMsg");
    		sock.send(msgInput.value);
    		let sendDiv = document.createElement('div');
    	    sendDiv.classList.add("sMsg");
    	    let msgSendDiv = document.createElement('div');
    	    msgSendDiv.classList.add("comm");
    	    msgSendDiv.innerText=msgInput.value;
    	    sendDiv.appendChild(msgSendDiv);
    	    sendDiv.setAttribute('tabIndex',"0");
    	    chatDiv.appendChild(sendDiv);
    	    sendDiv.focus();
    		msgInput.value="";
    		chatDiv.scrollTop = chatDiv.scrollHeight;
    	}
    	function printMsg(mObj){
    		console.log(mObj);
    		let mType = mObj.msgType;
    		switch(mType){
    		case "c":
    		case "d":
    			let conDiv = document.createElement('div');
    			conDiv.classList.add("connMsg");
    			conDiv.innerText=mObj.msgId+" 이/가 "+mObj.msgComm;
        	    conDiv.setAttribute('tabIndex',"0");
        	    chatDiv.appendChild(conDiv);
        	    conDiv.focus();
        	    chatDiv.scrollTop = chatDiv.scrollHeight;
        	    let connMembersAreaDiv = document.querySelector("#connMembersArea");
        	    if(mType == 'c'){
 					// 접속자 목록에 추가  
 					let connMemberDiv = document.createElement('div');
 					connMemberDiv.classList.add('connMember');
 					connMemberDiv.innerText=mObj.msgId;
 					connMemberDiv.setAttribute("id",mObj.msgId);
 					connMembersAreaDiv.appendChild(connMemberDiv);
        	    } else{
        	    	document.querySelector("#"+mObj.msgId).remove();
        	    	// 접속자 목록에 삭제
        	    }
    			break;
    		case "m":
    			let receiveDiv = document.createElement('div');
        	    receiveDiv.classList.add("rMsg");
        	    let idreceiveDiv = document.createElement('div');
        	    idreceiveDiv.classList.add("mid");
        	    idreceiveDiv.innerText=mObj.msgId;
        	    receiveDiv.appendChild(idreceiveDiv);
        	    let msgreceiveDiv = document.createElement('div');
        	    msgreceiveDiv.classList.add("comm");
        	    msgreceiveDiv.innerText=mObj.msgComm;
        	    receiveDiv.appendChild(msgreceiveDiv);
        	    receiveDiv.setAttribute('tabIndex',"0");
        	    chatDiv.appendChild(receiveDiv);
        	    receiveDiv.focus();
        	    chatDiv.scrollTop = chatDiv.scrollHeight;
    			break;
    		}
    	}
      /*1. porm.xml>spring-websocket,jackson databind 추가
        2. com.spring_memberBoard.sockUtil 패키지에 ChatHandler 생성
        3. servlet-context.xml websocket 설정 추가
        4. ChatPage.jsp sockjs 기능 추가*/
    </script>
    
    </html>
    