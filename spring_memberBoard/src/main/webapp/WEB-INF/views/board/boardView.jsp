<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">

<style type="text/css">
	.formRow>h2{
		margin-left: auto;
		margin-right: auto;
	}
	.formRow{
		border: 1px solid black;
		padding: 10px;
	}
	#bimg{
		width: 1000px;
		height: 400px;
	}
	#bcon{
		width: 1000px;
		height: 400px;
	}
	.replyArea{
		border: 3px solid black;
		border-radius: 10px;
		width: 500px;
		margin: 0 auto;
		padding: 10px;	
	}
	.replyWrite textarea{
		border-radius: 10px;
		width: 96%;
		min-height: 70px;
		font-family: auto;
		resize: none;
		padding: 10px;
	}
	.replyWrite button{
		width: 100%;
		margin-top: 5px;
		cursor: pointer;
		padding: 5px;
	}
	.reply{
		display: flex;
	}
	.reply>p{
		padding: 0;
		margin: 3px;
	}
	.reCom{
		margin-top: 5px;
		border-radius: 10px;
		width: 96%;
		min-height: 70px;
		font-family: auto;
		resize: none;
		padding: 10px;
	}
</style>
</head>
<body>
    <div class="mainWrap">
    <form action="${pageContext.request.contextPath }/boardWrite" method="post">
    <div class="contents">
    <h2 style="text-align: center;">글 상세보기 페이지</h2>
     <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
        <div class="formRow">
        <input type="text" disabled="disabled" name="btitle" value="${board.btitle }" >
		</div>
		<div class="formRow">
        <input type="text" disabled="disabled" name="bwriter" value="${board.bwriter }" >
        <input type="text" disabled="disabled" name="bhits" value="${board.bhits }" >
        <input type="text" disabled="disabled" name="bdate" value="${board.bdate }" >
		</div>
		<div class="formRow">
        	<img alt="" id="bimg" src="${pageContext.request.contextPath }/resources/boardUpload/${board.bfilename}">
		</div>
        <div class="formRow">
        <textarea name="bcontents" disabled="disabled" id="bcon">${board.bcontents }</textarea>
		</div>
		<div class="formRow">
			<button type="button"><a href="${pageContext.request.contextPath }/boardDelete?bno=${board.bno}">글삭제</a></button>
			<button type="button"><a href="${pageContext.request.contextPath }/boardList">글목록</a></button>
		</div>
    </form>
    <hr>
    <div class="replyArea">
    	<c:if test="${sessionScope.loginId != null }">
    	<div class="replyWrite">
    		
    		<form onsubmit="return replyWrite(this)">
    			<input type="hidden" name="rebno" value="${board.bno }">
    			<input type="hidden" name="bwriter" value="${board.bwriter }">
    			<textarea name="recomment" placeholder="내용"></textarea>
    			<button type="submit">등록</button>
    			<button type="button" onclick="getReplyList(${board.bno})">댓글보기</button>
    		</form>
    	</div>
    	<hr>
    	</c:if>
    		
    	<div id="reList" >
    	
    	</div>
    	
    	
    </div>
    </div> <!-- div.contents -->
    </div> <!-- div.mainWrap -->
</body>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	let msg = '${msg}';
    	if(msg.length > 0){
    	alert(msg);
    }
    function replyWrite(formObj){
    	console.log("replyWrite 호출"+formObj.rebno.value);
    	// ajax 댓글 등록 요청 전송
    	/*
    	*/
    	$.ajax({
    		type : "get",
    		url : "replyWrite",
    		data : {"rebno" : formObj.rebno.value, "recomment" : formObj.recomment.value},
    		success: function(result){
    			if(result > 0){
    				alert("작성 완료");
    				// 댓글 목록 조회 요청 >> 데이터 응답
    				formObj.recomment.value = "";
    				getReplyList(formObj.rebno.value);
    				let noticeObj = {"noticeType":"reply",
    								 "noticeMsg":formObj.rebno.value,
    								 "receiveId":formObj.bwriter.value
    								};
    				noticeSock.send(JSON.stringify(noticeObj));
    				//noticeSock에 send
    				//{noticeType:댓글알림,
    				//bno:글번호,
    				//bWriter:글작성자}
    			} else{
    				alert("작성 실패");
    			}
    		}
    	});
  		return false;
  	}
  		// 목록 조회
  	function getReplyList(rebno){
  		console.log("getReplyList()");
		console.log(rebno);
		/*SELECT * FROM REPLYS WHERE REBNO = {rebno} AND RESTATE = '1' ORDER BY REDATE
		>> ArrayList<Reply> -> json -> page*/
		$.ajax({
			type : "get",
			url : "replyList",
			data : { "rebno" : rebno },
			dataType : "json", 
			success : function(reList){
				console.log(reList);
				console.log(reList.length);
				printRList(reList);
			}
		});
    }
</script>
let noticeSock = connectNotice('${noticeMsg}');
<script type="text/javascript">
	let loginId = '${sessionScope.loginId}';
	console.log(loginId);
	function printRList(reList){
		let reListDiv = document.querySelector("#reList");
		reListDiv.innerHTML = "";
		// div 시작
		for(let i=0; i<reList.length; i++){
		let reDiv = document.createElement('div');
		//<div class="reply"></div>
		let replyDiv = document.createElement('div');
		replyDiv.classList.add('reply');
		//<p>작성자</p>
		let rewriterP = document.createElement('p'); 
		rewriterP.innerText = reList[i].remid; 
		replyDiv.appendChild(rewriterP);
		//<p>작성일</p>
		let redateP = document.createElement('p');
		redateP.innerText = reList[i].redate; 
		replyDiv.appendChild(redateP);
		//<button>삭제</button>
		if(loginId == reList[i].remid){
		let rebtn = document.createElement('button');
		rebtn.innerText = "삭제"; 
		rebtn.setAttribute('type','button');
		
		rebtn.setAttribute('onclick','delReply( "'+reList[i].renum+'" )');
		replyDiv.appendChild(rebtn);
		};
		//<textarea class="reCom" disabled="disabled">내용</textarea>
		// 요소 -> 텍스트 -> 클래스 -> 속성
		let recomment = document.createElement('textarea');
		recomment.innerText = reList[i].recomment;
		recomment.classList.add('reCom');
		recomment.setAttribute('disabled','disabled');
		/*
		<div class="reply">
			<p>작성자</p>
			<p>작성일</p>
			<button>삭제</button>
		</div>
		<textarea class="reCom" disabled="disabled">내용</textarea>
		*/
		reDiv.appendChild(replyDiv);
		reDiv.appendChild(recomment);
		//reDiv.appendChild(document.createElement('hr'));
		console.log(reDiv);
		reListDiv.appendChild(reDiv);
		};
	}
</script>
<script type="text/javascript">
	function delReply(delrenum){
		console.log(delrenum);
		let confirmVal = confirm('댓글 삭제?');
		if(confirmVal){
			console.log("삭제");
			$.ajax({
				type : "get",
				url : "deleteReply",
				data : {"renum" : delrenum},
				success : function(result){
					if(result == '1'){
						getReplyList(bno);
					} else {
						alert('댓글 삭제 실패');
					}
				}
			});
		}
	}
	//let noticeSock = connectNotice('${noticeMsg}');
</script>
<%-- 
    <div class="reply">
    	<p>작성자출력</p>
    	<p>작성일출력</p>
		<button onclick="">댓글삭제</button>
    </div>
    <textarea class="reCom" disabled="disabled">내용출력</textarea>
    <hr>
    --%>
<script type="text/javascript">
	let bno = "${board.bno}";
</script>
</html>