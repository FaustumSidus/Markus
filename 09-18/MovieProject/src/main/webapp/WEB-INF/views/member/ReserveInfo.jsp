<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <h1 class="fw-bolder">예매 내역 페이지</h1>
                    <p class="lead mb-0">예매했던 정보 페이지</p>
                </div>
            </div>
        </header>
        <!-- Page content-->
        <div class="container"> <!-- 모든 페이지는 constainer 클래스 내부의 코드만 다름 -->
            <!-- 컨텐츠 시작 -->
        <div class="row">
        	<div class="col">
        		<table>
        			<thead>
        				<tr>
        					<th>제목</th>
        					<th>극장</th>
        					<th>상영관</th>
        					<th>날짜</th>
        					<th>비고</th>
        				</tr>
        			</thead>
        			
        			<tbody>
        			<%@ page import="java.util.Date" %>
        			<c:set var="today" value="<%= new Date() %>"></c:set>
        			<c:forEach items="${rList }" var="re">
        				<fmt:parseDate value="${re.SCDATE }" var="scdate_fmt" pattern="yyyy-MM-dd HH:mm"></fmt:parseDate>
        				<!-- re.SCDATE = "2023-09-15 14:50" >> scdate_fmt 2023년 09월 15일 14시 50분 -->
        				<tr>
        					<td> <a href="${pageContext.request.contextPath }/detailMovie?mvcode=${re.MVCODE }">${re.MVTITLE }</a></td>
        					<td>${re.THNAME }</td>
        					<td>${re.SCHALL }</td>
        					<td>${re.SCDATE }</td>
        					<td> 
        					<c:choose>
        						<c:when test="${today < scdate_fmt }">
        							<a href="${pageContext.request.contextPath }/cancelReserve?recode=${re.RECODE}" class="btn btn-danger">예매취소</a> 
        						</c:when>
        						<c:otherwise>
		        					<a href="" class="btn btn-success">관람평</a> 
        						</c:otherwise>
        					</c:choose>
        					</td>
        				</tr>	
        			</c:forEach>
        			</tbody>
        		</table>
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
