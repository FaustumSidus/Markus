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
	<h1>Main.jsp</h1>
	<button onclick="chatPage1()">채팅 1</button>
	<button onclick="chatPage2()">채팅 2</button>
	
</body>
<script type="text/javascript">
	function chatPage1(){
		location.href="chatPage1";
	}
	function chatPage2(){
		let chatId = prompt('사용자 이름 입력');
		console.log(chatId);
		location.href="chatPage2?chatId="+chatId;
	}
</script>
</html>
