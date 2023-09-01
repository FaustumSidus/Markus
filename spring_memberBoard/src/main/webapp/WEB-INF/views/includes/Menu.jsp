<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<div class="nav">
        <ul>
        	<li><a href="${pageContext.request.contextPath }/memChat">회원채팅</a></li>
        	<li><a href="${pageContext.request.contextPath }/tago2">타고2</a></li>
        	<li><a href="${pageContext.request.contextPath }/busapi">버스 도착 정보</a></li>
        	<li><a href="${pageContext.request.contextPath }/busapi_ajax">버스 도착 정보_ajax</a></li>
        	<li><a href="${pageContext.request.contextPath }/boardList">게시판</a></li>
        	<li><a href="${pageContext.request.contextPath }/myInfo?mid=${sessionScope.loginId }">${sessionScope.loginId }</a></li>
        	<c:choose>
        	<c:when test="${sessionScope.loginId == null }">
        	<li><a href="${pageContext.request.contextPath }/memberJoinForm">회원가입</a></li>
        	<li><a href="${pageContext.request.contextPath }/memberLoginForm">로그인</a></li>
        	</c:when>
        	<c:otherwise>
        		<li><a href="${pageContext.request.contextPath }/memberLogout">로그아웃</a></li>
        		<li><a href="${pageContext.request.contextPath }/boardWriteForm">글쓰기</a></li>
        	</c:otherwise>
        
        
        	</c:choose>
        </ul>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js" integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="${pageContext.request.contextPath }/resources/js/NoticeJs.js"></script>
    <script type="text/javascript">
    	function toastrOn(){
			toastr.options.positionClass="toast-bottom-right"; // 위치 지정
			toastr.info('새 글이 등록되었습니다.');
    	}	
    	let nMsg = '${noticeMsg}';
    	let noticeSock = connectNotice('${noticeMsg}');
    	
	</script>
