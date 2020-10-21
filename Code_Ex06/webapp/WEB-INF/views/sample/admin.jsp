<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Spring Security</title>
</head>
<body>
	<h1>/sample/admin Page</h1>

	<P>
		principal :
		<sec:authentication property="principal" />
	</P>
	<P>
		MemberVO :
		<sec:authentication property="principal.member" />
	</P>
	<P>
		사용자 이름 :
		<sec:authentication property="principal.member.userName" />
	</P>
	<P>사용자 아이디 : <sec:authentication property="principal.username" /> </P>
	<P>사용자 권한 리스트 : <sec:authentication property="principal.member.authList" /> </P>
	
	<a href="/customLogout">Logout</a>
</body>
</html>