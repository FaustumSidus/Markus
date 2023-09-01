<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <h1>OliveBest.jsp</h1>
	 <table>
	 	<tr>
			<th>랭킹</th>
			<th>이미지</th>
			<th>브랜드</th>
			<th>이름</th>
			<th>가격</th>
			<th>리뷰</th>	 	
	 	</tr>
	 	<c:forEach items="${prdList }" var="prd" varStatus="status">
	 		<tr>
	 			<td>${status.index+1 }</td>
	 			<td><img alt="" src="${prd.prdImg }" width="30px;"></td>
	 			<td>${prd.prdBrd }</td>
	 			<td>${prd.prdName }</td>
	 			<td>${prd.prdPrice }</td>
	 			<td>${prd.prdRev }</td>
	 		</tr>
	 	</c:forEach>
	 </table>
	 
	 
</body>
<script type="text/javascript">
// 정렬기능(가격, 리뷰순)
</script>
</html>