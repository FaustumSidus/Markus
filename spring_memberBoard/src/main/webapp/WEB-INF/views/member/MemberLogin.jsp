<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
        <style>  
        	form{
        		border: 3px solid black;
        		border-radius: 10px;
        		text-align: center;
        		width: 500px;
        		height: auto;
        		margin-left: auto;
        		margin-right: auto;
       			padding: 10px;
        	}
        	.title{
        		text-align: center;
        	}
   		</style> 
   		<script type="text/javascript">
   			let msg = '${msg}';
    		if(msg.length > 0){
    			alert(msg);
    			
    		}
   		</script>
    </head>

    <body>
    	<div class="mainWrap">
    	
        <div class="header">
            <h1>회원가입 - views/member/MemberJoinForm.jsp</h1>
        </div>

        <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

            <div class="contents">
            	<button onclick="toastrOn()">toastr!</button>
                <h2 class="title">로그인 페이지</h2>
                <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                <div class="formWrap">
                    <form action="${pageContext.request.contextPath }/memberLogin" method="post">
                        <div class="formRow">
                            <input type="text" id="inputId" name="mid" placeholder="아이디" >
                        </div>             
                        <div class="formRow">
                            <input type="text" id="inputPw" name="mpw" placeholder="비밀번호" class ="font">
                        </div>                                             
                        <div class="formRow">
                            <input type="submit" value="로그인">
                        </div>
                    </form>
                </div>
            </div>
    	</div>
    </body>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script type="text/javascript">
    	
    	function joinFormCheck(formObj) {
			//아이디~ 주소 모두 입력되어있으면 submit 실행
			//하나라도 미입력 되있다면 submit 중지
			//미입력 항목으로 포커스
			let idEl = formObj.mid;
			let pwEl = formObj.mpw;
			if (idEl.value == "") {
				alert("아이디를 확인 해주세요");
				idcheck = 0;
				formObj.mid.focus();
				return false;
			}
			if (pwEl.value == "") {
				alert("비밀번호를 확인 해주세요");
				formObj.mpw.focus();
				return false;
			}
		}
    </script>
    </html>