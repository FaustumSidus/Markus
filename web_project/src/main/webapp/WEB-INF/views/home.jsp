<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
	
<P>  The time on the server is ${serverTime}. </P>
<a href="${pageContext.request.contextPath }/olive">올리브영</a>
<form action="${pageContext.request.contextPath }/prdSearch" method="get">
	<input type="text" name="searchText">
	<input type="submit" value="상품검색">
</form>
</body>
</html>
