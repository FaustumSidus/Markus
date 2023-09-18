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
                    <h1 class="fw-bolder">내 정보 페이지</h1>
                    <p class="lead mb-0">회원가입 할 때 입력했던 정보 페이지</p>
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
            			<div class="row m-1">
            			아이디 <input type="text" disabled="disabled" value="${mem.mid }" class="formInput p-1" style="width: 100%; height: 50px;">
            			</div>  
            			<c:choose>
            				<c:when test="${sessionScope.loginState == 'YC' }">
		            			<div class="row m-1">
		            			비밀번호 <input type="text" disabled="disabled" value="${mem.mpw }" class="formInput p-1" style="width: 100%; height: 50px;">
		            			</div>              					
            				</c:when>           				
            			</c:choose>
            			<div class="row m-1">
            			이름 <input type="text" disabled="disabled" value="${mem.mname }" class="formInput p-1" style="width: 100%; height: 50px;">
            			</div>  
            			<div class="row m-1">
            			가입일 <input type="text" disabled="disabled" value="${mem.mdate }" class="formInput p-1" style="width: 100%; height: 50px;">
            			</div>  
            			<c:choose>
            				<c:when test="${sessionScope.loginImg == null }">		            			           					
		            			<div class="row m-1">
		            			프로필 이미지 
		            			<img alt="" src="${pageContext.request.contextPath }/resources/user/memUpload/기본이미지.png">
		            			</div>            			            	         			           		
            				</c:when> 
            				<c:when test="${sessionScope.loginState == 'YK' }">
            					<div class="row m-1">
		            			프로필 이미지 
		            			<img alt="" src="${mem.mprofile}">
		            			</div>  
            				</c:when>
            				<c:otherwise>
            					<div class="row m-1">
		            			프로필 이미지 
		            			<img alt="" src="${pageContext.request.contextPath }/resources/user/memUpload/${mem.mprofile}">
		            			</div>      
            				</c:otherwise>          				
            			</c:choose>         
            		
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
        <script type="text/javascript">
        function domainSelect(obj){
    		document.getElementById("domain").value = obj.value;
    	};
        </script>
         <script type="text/javascript">
	        let msg = '${msg}';
	    	if(msg.length > 0){
	    		alert(msg);
	    	}
	    	let loginId = '${loginId}';
	    	if(loginId.length > 0){
	    		$('#loginId').text('${loginId}');
	    	}
        </script>
        <!-- Core theme JS-->
    </body>
</html>
