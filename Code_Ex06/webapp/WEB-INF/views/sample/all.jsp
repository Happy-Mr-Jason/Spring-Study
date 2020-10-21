<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Spring Security</title>
</head>
<body>
	<h1>/sample/all Page</h1>
	
	<sec:authorize access="isAnonymous()">
	<a href="/customLogin">로그인</a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
	<a href="/customLogout">로그아웃</a>
	</sec:authorize>
</body>
</html>