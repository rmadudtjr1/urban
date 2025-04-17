<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title" /></title>
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

			<main id="content" class="container">
				<tiles:insertAttribute name="body" />
			</main>
		</div>
		<footer id="footer">
			<tiles:insertAttribute name="footer" />
		</footer>
	</div>


</body>
</html>
