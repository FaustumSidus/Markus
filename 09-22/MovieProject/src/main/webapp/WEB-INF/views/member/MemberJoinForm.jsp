<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Movie Reserve Project</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/user/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath }/resources/user/css/styles.css" rel="stylesheet" />
   		<style type="text/css">
   			.formInput{
   				font-family: auto;
   				font-size: 20px;
   				border-radius: 1px solid black;
   			}
   			.formInput:focus{
   				border-color: #03c75a;
   				outLine: 0;
   				border-width: 4px;
   			}
   			.emailform{
   				display: flex;
   			}
   			.emailform>input{
   				margin-left: 4px;
   				width: 35.2%;
   			}
   			#idMsg {
		  		color: #007bff;
			}
   		</style>
    </head>
    <body>
    	<!-- 메뉴 시작 -->
        <!-- Responsive navbar-->
        <%@ include file="/WEB-INF/views/include/menu.jsp" %>
        <!-- 메뉴 끝 -->
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">회원가입 페이지</h1>
                    <p class="lead mb-0">회원가입을 위한 정보 입력 페이지</p>
                </div>
            </div>
        </header>
        <!-- Page content-->
        <div class="container"> <!-- 모든 페이지는 constainer 클래스 내부의 코드만 다름 -->
            <!-- 컨텐츠 시작 -->
            <div class="card mb-4 mx-auto" style="width: 500px;">
            
            	<div class="card-body">
            	
            		<div class="card-title">            		
            		</div>
            		
            		<form action="${pageContext.request.contextPath }/memberJoin" method="post" enctype="multipart/form-data" onsubmit="return formCheck(this)">	
            			<div class="row m-1">
            			<input type="text" class="formInput p-1" id="inputId" onkeyup="idCheck(this)" name="mid" style="width: 100%; height: 50px;" placeholder="아이디">
            			</div>  
            			<p id="idMsg">중복확인 해주세요!</p>         			
            			<div class="row m-1">
            			<input type="text" class="formInput p-1" name="mpw" style="width: 100%; height: 50px;" placeholder="비밀번호">
            			</div>   
            			<div class="row m-1">
            			<input type="text" class="formInput p-1" name="mname" style="width: 100%; height: 50px;" placeholder="이름">
            			</div>   
            			<div class="emailform">
            			<input type="text" name="memail" placeholder="이메일">@
            			<input type="text" name="memailDomain" id="domain" placeholder="이메일도메인">
                        	<select onchange="domainSelect(this)" id="domainCheck">
                        		<option>직접입력</option>
                        		<option value="naver.com">naver.com</option>
                        		<option value="google.com">google.com</option>                    		
                        	</select>
            			</div>   
            			<div class="row m-1">
            			<input type="file" class="formInput p-1" name="mfile" style="width: 100%; height: 50px;">
            			</div>            			
            			<div class="row m-1">            			
            			<input type="submit" class="formInput p-1" value="회원가입" style="text-align: center; width: 100%; height: 50px; background-color: #03c75a;">
            			</div>
            		</form>	
            			<div class="row m-1">
            				<button onclick="memberLogin_kakao()" class="btn btn-warning">카카오회원가입</button>
            			</div>
            	</div>
            	
            </div>
            <!-- 컨텐츠 끝 -->
        </div>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
        <!-- 카카오 로그인 JS -->
        <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>
        <script type="text/javascript">
	        Kakao.init('5f9e825dec7177a1b1fbf0f69df23821');
	        console.log(Kakao.isInitialized());
	        
	        function memberLogin_kakao(){
	        	console.log('카카오 로그인 호출()');
	        	Kakao.Auth.authorize({
	        	      redirectUri: 'http://localhost:8081/controller/memberLoginForm',
	        	    });
	        	Kakao.API.request({
	        		  url: '/v2/user/me', // 사용자 정보 가져오기
	        		})
	        		  .then(function(response) {
	        		    console.log(response)
	        		  })
	        		  .catch(function(error) {
	        		    console.error(error)
	        		  })
	        }
	        let authCode = '${param.code}';
	        console.log("authCode : "+authCode);
	        if(authCode.length > 0){
	        	console.log("카카오 인가코드 있음");
	        	console.log("인증토큰 요청");
	        	$.ajax({
	        		type : 'post',
	        		url : 'https://kauth.kakao.com/oauth/token',
	        		contentType : 'application/x-www-form-urlencoded;charset=utf-8',
	        		data : { 'grant_type' : 'authorization_code', 
	        				 'client_id' : '3c712df8ce815b2899cde9d1ea2916a1',
	        				 'redirect_uri' : 'http://localhost:8081/controller/memberLoginForm',
	        				 'code' : authCode
	        				 },
	     			success : function(response){
	     				console.log("인증토큰 : "+response.access_token);
	     				Kakao.Auth.setAccessToken(response.access_token);
	     				Kakao.API.request({
	     					  url: '/v2/user/me',
	     					  })
	     					  .then(function(response) {
	     						console.log('카카오 계정 정보');
	     						console.log('id : '+response.id);
	     						console.log('email : '+response.kakao_account.email);
	     						console.log('nickname : '+response.properties.nickname);
	     						console.log('profil : '+response.properties.profile_image);
	     						// members 테이블에서 카카오계정 정보가 조회 T or F
	     						if(true){
	     							$.ajax({
	     								type : 'get',
	     								url : 'memberLogin_kakao',
	     								data : {'id' : response.id},	     								
	     								success : function(checkMember_kakao){
	     									if(checkMember_kakao == "Y"){									
	     										//alert('로그인 되었습니다');
	     										location.href="${pageContext.request.contextPath }/";	     											
	     									} else {
					     						let check = confirm('가입된 정보가 없습니다 \n 카카오 계정으로 가입하시겠습니까?');	     						
	     										if(check){
	     											console.log('카카오 회원가입 기능 호출');
	     											memberJoin_kakao(response);
	     										}
	     									}
	     								}	     										     									     				
	     							})
	     						} 
	     					  	/* 파라미터 전송법
	     					  	1. location.href="" url 뒤에 결합되어 있기에 보안 취약
	     					  	2. $.ajax()*/
	     					  })
	     					  .catch(function(error) {
	     					    console.log(error);
	     					  });
	     			}
	        	});
	        }
        </script>
        <script type="text/javascript">
        	function memberJoin_kakao(res){
        		console.log('memberJoin_kakao() 호출');
        		$.ajax({
        			type : 'get',
        			url : 'memberJoin_kakao',
        			data : {'mid' : res.id,
        					'mname' : res.properties.nickname,
        					'memail' : res.kakao_account.email,
        					'mprofile' : res.properties.profile_image
        					},
        			success : function(joinResult){
        				alert('카카오 계정으로 회원가입 되었습니다.\n 다시 로그인 해주세요');
        				location.href = "${pageContext.request.contextPath }/memberLoginForm";
        			}
        		})
        		
        	}
        </script>
        <script type="text/javascript">
	        function domainSelect(obj){
	    		document.getElementById("domain").value = obj.value;
	    	};
    	
        </script>
        <!-- 아이디 중복 체크 -->
    	<script type="text/javascript">
    	
    	let idChecked = false; // 아이디 중복확인 
    	
    	function idCheck(inputId){
			// 중복 확인할 아이디 VALUE 확인
			let idEl = document.querySelector('#inputId');
			console.log(idEl.value);
			
			// ajax - 아이디 중복 확인요청(memberIdCheck)
			$.ajax( { type: "get", // 전송 방식
					  url: "memberIdCheck", // 전송 URL
					  data: { "inputId" : idEl.value }, // 전송 파라메터
					  success: function(re){ // 전송에 성공했을 경우
						  // re : 응답받은 데이터
						  console.log("확인결과 : " + re);
		                    if(re == "Y"){
		                    	/* 사용 가능한 아이디입니다. 출력 */
		                    	let msgEl = document.getElementById('idMsg');
		                    	msgEl.innerText = '사용 가능한 아이디입니다.';
		                    	idChecked = true;
		                    	// document.querySelector('#idmsg').innerText = '사용 가능한 아이디입니다.';
		                        // $("#idMsg").css("color", 'green').text("사용 가능한 아이디입니다.");
		                    }
		                    
		                    else{
		                    	/* 중복된 아이디입니다. 출력 */
		                    	let msgEl = document.getElementById('idMsg');
		                    	msgEl.innerText = '이미 가입된 아이디입니다.';
		                    	idChecked = false;
		                    	// document.querySelector('#idmsg').innerText = '이미 가입된 아이디입니다.';
		                        // $("#idMsg").css("color", 'red').text("이미 가입된 아이디입니다.");
		                    }
		                    
		                    
		                }
				 });
		}
    	</script>
    	   
		<script type="text/javascript">
		function formCheck(formObj) {
    		console.log("formCheck() 호출")
    		let idEl = formObj.mid; //아이디 input 태그
    	    let pwEl = formObj.mpw; //비밀번호 input 태그
    	    let nmEl = formObj.mname; //이름 input 태그
    	    let emEl = formObj.memail; //이메일 input 태그
    	    let dnEl = formObj.domain; //도메인 input 태그
    	    
    		//아이디가 입력되지 않았으면 false;
    	    if(idEl.value.length == 0){
    	        alert("아이디를 입력해주세요!");
    	        idEl.focus();
    	        return false;
    	    }
    	    //아이디 길이 체크 false;
    	    if(idEl.value.length > 21){
    	    	alert("아이디 20글자 이내로 입력해주세요!");
    	    	idEl.focus();
    	    	return false;
    	    }
    	    //비밀번호가 입력되지 않았으면 false;
    	    if(pwEl.value.length == 0){
    	    	alert("비밀번호를 입력해주세요!");
    	        pwEl.focus();
    	        return false;	
    	    }
    	    //이름이 입력되지 않았으면 false;
    	    if(nmEl.value.length == 0){
    	    	alert("이름을 입력해주세요!");
    	        nmEl.focus();
    	        return false;	
    	    }
    	    //이름이 입력되지 않았으면 false;
    	    if(emEl.value.length == 0){
    	    	alert("이메일을 입력해주세요!");
    	        emEl.focus();
    	        return false;	
    	    }
    	    //이름이 입력되지 않았으면 false;
    	    if(dnEl.value.length == 0){
    	    	alert("도메인을 선택해주세요!");
    	        domainCheck.focus();
    	        return false;	
    	    }
    	    if(!idChecked){
    	    	alert('아이디를 중복확인 해주세요!');
    	    	inputId.focus();
    	    	return false;
    	    }
    	   }
		</script>
		
		<script type="text/javascript">
		let msg = '${msg}';
		if(msg.length > 0){
			alert(msg);
		}
		</script>
        <!-- Core theme JS-->
    </body>
</html>
