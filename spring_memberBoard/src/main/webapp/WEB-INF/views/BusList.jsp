<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
        
    </head>

    <body>
        <div class="mainWrap">
            <div class="header">
                <h1>버스 - views/BusList.jsp</h1>
                <p id = "loginId"></p>
            </div>

            <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

            <div class="contents">
                <h2>컨텐츠 영역</h2>
               	<table>
               		<tr>
               			<th>정류소명</th>
               			<th>버스번호</th>
               			<th>남은정류장</th>
               			<th>도착예정시간</th>
               		</tr>
               		<c:forEach items="${busList }" var="bus">
               			<tr>
               				<td>${bus.nodenm }</td>
               				<td>${bus.routeno } 번</td>
               				<td>${bus.arrprevstationcnt } 번째전</td>	
               				<td>${bus.arrtime } 분 후 도착예정</td>               				
               				
               			</tr>
               		</c:forEach>
               	</table>
            </div>

        </div>
    </body>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
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
    
    </html>
    