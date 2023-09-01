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
                    <h1 class="fw-bolder">로그인 페이지</h1>
                    <p class="lead mb-0">로그인을 위한 아이디, 비밀번호 입력 페이지</p>
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
            		
            		<form action="">	
            			<div class="row m-1">
            			<input type="text" class="formInput p-1"  name="userId" style="width: 100%; height: 50px;" placeholder="아이디">
            			</div>           			
            			<div class="row m-1">
            			<input type="text" class="formInput p-1" name="userPw" style="width: 100%; height: 50px; margin-bottom: 30px;" placeholder="비밀번호">
            			</div>            			
            			<div class="row m-1">            			
            			<input type="submit" class="formInput p-1" value="로그인" style="text-align: center; width: 100%; height: 50px; background-color: #03c75a;">
            			</div>
            		</form>	
            			<div class="row m-1">
            				<button onclick="memberLogin_kakao()" class="btn btn-warning">카카오로그인</button>
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
        <!-- Core theme JS-->
    </body>
</html>
