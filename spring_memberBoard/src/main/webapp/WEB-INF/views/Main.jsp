<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                <h1>메인 - views/Main.jsp</h1>
                <p id = "loginId"></p>
            </div>

            <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>

            <div class="contents">
                <h2>컨텐츠 영역</h2>
                
            	<button onclick="sendTest()">출력</button>
            
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
    