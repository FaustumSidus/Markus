<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	 	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath }/">Movie Reserve Project</a><!-- 클릭 시 메인화면 -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/movieList">영화</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">예매</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/memberLoginForm">로그인</a></li>
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/memberJoinForm">회원가입</a></li>
                    </ul>
                </div>
            </div>
        </nav>