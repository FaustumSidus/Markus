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
	.reCom{
		margin-top: 5px;
		border-radius: 10px;
		width: 96%;
		min-height: 70px;
		font-family: auto;
		resize: none;
		padding: 10px;
	}
	.num{
		display: flex;
	}
</style>
</head>
<body>
    <div class="mainWrap">
    <div class="contents">
    <h2 style="text-align: center;">회원 정보 조회 페이지</h2>
        <div class="formRow">
        아이디 : <input type="text" disabled="disabled" name="mid" value="${member.mid }" >
		</div>
		<div class="formRow">
        비밀번호 : <input type="text" disabled="disabled" name="mpw" value="${member.mpw }" >
        </div>
        <div class="formRow">
        이름: <input type="text" disabled="disabled" name="mname" value="${member.mname }" >
        </div>
        <div class="formRow">
        생년월일 : <input type="text" disabled="disabled" name="mbirth" value="${member.mbirth }" >
		</div>
		<div class="formRow">
        이메일 : <input type="text" disabled="disabled" name="memail" value="${member.memail }" >
		</div>
		<hr>
		<div class="num">
			<p>작성글 : </p>
			<p id="bnum" ></p>
		</div>
		<hr>
		<div class="num" >
			<p>작성댓글 : </p>
			<p id="rnum" ></p>
		</div>
		<div class="formRow">
			<button type="button"><a href="${pageContext.request.contextPath }/">메인페이지</a></button>
			<button onclick="pwCheck('${member.mpw }')">정보수정</button>
			<button type="button" onclick="boardInfo('${member.mid }')">작성글, 댓글확인</button>
		</div>
    </form>
    <hr>
    </div>
    </div> <!-- div.contents -->
    </div> <!-- div.mainWrap -->
</body>

>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
	let msg = '${msg}';
    	if(msg.length > 0){
    	alert(msg);
    }
    function pwCheck(mpw){
    	let inputpw = prompt("비밀번호 입력");
    	if(mpw == inputpw){
    		location.href = "memberModifyForm?mid=${member.mid}";
    	} else {
    		alert('비밀번호 다시 확인');
    	}
    }
    function boardInfo(mid){
		console.log(mid);
			$.ajax({
				type : "get",
				url : "boardInfo",
				data : {"mid" : mid},
				success : function(result){
					if(result != null){
						$('#bnum').text(result);
						replyInfo(mid);
					} else {
						alert('댓글 삭제 실패');
					}
				}
			});
	}
    function replyInfo(mid){
		console.log(mid);
			$.ajax({
				type : "get",
				url : "replyInfo",
				data : {"mid" : mid},
				success : function(result){
					if(result != null){
						$('#rnum').text(result);
					} else {
						alert('댓글 삭제 실패');
					}
				}
			});
	}
</script>
</html>