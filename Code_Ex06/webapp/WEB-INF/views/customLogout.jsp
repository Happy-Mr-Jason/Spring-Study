<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
	<H1>Logout Page</H1>

	<form action="/customLogout" method='post'>
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<button>Logout</button>
	</form>
</body>
</html>