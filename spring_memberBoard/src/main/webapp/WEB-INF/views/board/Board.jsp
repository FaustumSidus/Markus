<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
    	
    	<style type="text/css">
    		.info{
    			width: auto;
    			height: auto;
    			border: 3px solid black;
    			border-radius: 10px;
    			display: flex;
    			margin-left: 370px;
    			margin-right: 300px;
    			padding: 10px;
    		}
    		.info>p{
    			margin: 23px;
    		}
    		table{
    			border: 3px solid black;
    			border-radius: 10px;
    			margin-left: auto;
    			margin-right: auto;
    			height: auto;
    			width: auto;
    			padding: 10px;
    		}
    		td{
    			padding: 10px;
    			text-align: center;
    			font-size: 20px;
    		}
    		h2{
    			text-align: center;
    		}
    	</style>
    	    <script src="https://kit.fontawesome.com/c0de6b1c45.js" crossorigin="anonymous"></script>
    </head>

    <body>
        <div class="mainWrap">
            <div class="header">
                <h1>메인 - views/board/Board.jsp</h1>
            </div>

            <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
	
            <div class="contents">             
				<table>
				<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>조회수</td>
					<td>작성일</td>
				</div>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${bList }" var="board">
				<tr>
					<td>${board.bno }</td>
					<td><a href="${pageContext.request.contextPath }/boardView?bno=${board.bno}">${board.btitle }</a>
					<c:if test="${board.bfilename != null }">
						<span><i class="fa-solid fa-image"></i></span>
					</c:if>
					<span style="font-size: 20px;" ><i class="fa-regular fa-comment-dots"></i>${board.recount }</span>
					</td>
					<td>${board.bwriter }</td>
					<td>${board.bhits }</td>
					<td>${board.bdate }</td>
				</c:forEach>
				</tr>
				</tbody>
				</table>
            </div>
       
  	<hr>
  
            <div class="contents">            
				<table>
				<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>조회수</td>
					<td>작성일</td>
				</div>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${bListMap }" var="board">
				<tr>
					<td>${board.BNO }</td>
					<td><a href="${pageContext.request.contextPath }/boardView?bno=${board.BNO}">${board.BTITLE }</a>
					<c:if test="${board.BFILENAME != null }">
						<span><i class="fa-solid fa-image"></i></span>
					</c:if>
					<span style="font-size: 20px;" ><i class="fa-regular fa-comment-dots"></i>${board.RECOUNT }</span>
					</td>
					<td>${board.BWRITER }</td>
					<td>${board.BHITS }</td>
					<td>${board.BDATE }</td>
				</c:forEach>
				</tr>
				</tbody>
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
    	let noticeMsg = '${noticeMsg}';
    	function noticeCheck(){
			if(noticeMsg.length > 0){
	    		let noticeObj = {"noticeType":"board"}			};
				noticeSock.send(JSON.stringify(noticeObj));
			}   		
    	}
    </script>
    
    </html>
    