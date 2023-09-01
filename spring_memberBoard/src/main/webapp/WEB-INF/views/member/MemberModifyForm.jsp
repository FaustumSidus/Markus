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
        	.formRow>input{
        		width: 80%;
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
            <h1>정보수정 - views/member/MemberJoinForm.jsp</h1>
        </div>

        <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
            <div class="contents">
                <h2 class="title">정보수정 페이지</h2>
                <!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
                <div class="formWrap">
                
                    <form action="${pageContext.request.contextPath }/memberModify?" method="post"
                    onsubmit="return joinFormCheck(this)">
                        <div class="formRow">
                            아이디 : <input type="text" id="inputId" readonly="readonly" name="mid" value="${member.mid }" >
                        </div>
                        <p id="checkMsg"></p>                   
                        <div class="formRow">
                            비밀번호 : <input type="text" name="mpw" placeholder="비밀번호" class ="font" value="${member.mpw }">
                        </div>
                        <div class="formRow">
                            이름 : <input type="text" name="mname" placeholder="이름" class ="font" value="${member.mname }">
                        </div>
                        <div class="formRow">
                            생년월일 : <input type="date" name="mbirth" class ="date" >
                        </div>
                        <div class="formRow">                  	
                            이메일 : <input type="text" name="memail" placeholder="이메일"> @
                        	<input type="text" name="memailDomain" id="domain" placeholder="이메일도메인">
                        	<select onchange="domainSelect(this)">
                        		<option>직접입력</option>
                        		<option value="naver.com">naver.com</option>
                        		<option value="google.com">google.com</option>
                        		
                        	</select>
                        </div>
                        <div class="formRow">
                            <input type="submit" value="정보수정">
                        </div>
                    </form>
                </div>
            </div>
    	</div>
    </body>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script type="text/javascript">
    function domainSelect(obj){
		document.getElementById("domain").value = obj.value;
	};
	let idcheck = 0;
    	function joinFormCheck(formObj) {
			//아이디~ 주소 모두 입력되어있으면 submit 실행
			//하나라도 미입력 되있다면 submit 중지
			//미입력 항목으로 포커스
			let pwEl = formObj.mpw;
			let nameEl = formObj.mname;
			let birthEl = formObj.mbirth;
			let emailEl = formObj.memail;
			let domainEl = formObj.memailDomain;
			if (pwEl.value == "") {
				alert("비밀번호를 확인 해주세요");
				formObj.mpw.focus();
				return false;
			}
			if (nameEl.value == "") {
				alert("이름을 확인 해주세요");
				formObj.mname.focus();
				return false;
			}
			if (birthEl.value == "") {
				alert("생년월일을 확인 해주세요");
				formObj.mbirth.focus();
				return false;
			}
			if (emailEl.value == "") {
				alert("이메일을 확인 해주세요");
				formObj.memail.focus();
				return false;
			}
			if (domainEl.value == "") {
				alert("도메인을 확인 해주세요");
				formObj.memailDomain.focus();
				return false;
			}

		}
    </script>
    </html>