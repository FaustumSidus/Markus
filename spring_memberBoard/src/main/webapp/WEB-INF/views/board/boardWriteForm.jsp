<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
    <div class="mainWrap">
    	<div class="header">
    		<h1>board/boardWriteForm.jsp</h1>    
    	</div>
    <%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
    <form action="${pageContext.request.contextPath }/boardWrite" method="post" enctype="multipart/form-data">
    <div class="contents">
    <h2>글작성 페이지</h2>
        <div class="formRow">
        <input type="text" name="btitle" placeholder="제목">
		</div>
        <div class="formRow">
        <textarea name="bcontents" placeholder="글내용" ></textarea>
		</div>
        <div class="formRow">
        	<input type="file" name="bfile">
        </div>
        <input type="submit" class="formRow" value="글등록">
    </form>
    </div>
    </div>
</body>
<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<script type="text/javascript">
	let msg = '${msg}';
    	if(msg.length > 0){
    	alert(msg);
    }
</script>
</html>