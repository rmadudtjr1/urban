<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title" /></title>
<style>
/* 기존 스타일은 유지하고 아래 스타일을 추가 또는 수정 */
#main-layout {
    display: flex;
    min-height: calc(100vh - (헤더 높이) - (푸터 높이)); /* 실제 헤더, 푸터 높이로 대체 */
    padding-left: 260px; /* 사이드바 너비에 맞춰 조정 */
    box-sizing: border-box;
}

#side.sidebar {
    width: 250px; /* 실제 사이드바 너비 */
    /* position: fixed; /* 고정 위치 사용 시 활성화 */
    /* top: (헤더 높이); /* 헤더 아래부터 시작 */
    /* left: 0; */
    /* height: calc(100vh - (헤더 높이) - (푸터 높이)); /* 헤더, 푸터 제외한 높이 */
    /* overflow-y: auto; /* 내용이 많을 경우 스크롤 */ */
}

#header {
    z-index: 10; /* 사이드바 위에 표시 */
}

#footer {
    z-index: 10; /* 사이드바 위에 표시 */
}

/* 사이드바를 고정하지 않을 경우 */
#side.sidebar {
    position: static;
    height: auto; /* 필요에 따라 조정 */
}
</style>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styleInfo.css">
</head>

<body>
	<div id="container">
		<header id="header">
			<tiles:insertAttribute name="header" />
		</header>
		<div id="main-layout">
			<aside id="side" class="sidebar">
				<tiles:insertAttribute name="side" />
			</aside>

			<main id="content" class="container1">
				<tiles:insertAttribute name="body" />
			</main>
		</div>
		<footer id="footer">
			<tiles:insertAttribute name="footer" />
		</footer>
	</div>


</body>
</html>
