<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ 	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>
<body>
	<div class="container">
		<form method="post" action="updateUser.do">
			<input type="hidden" name="userId" value="${map.user.userId}" />
			<h2 class="text-center">사용자 정보 수정</h2>
			<table class="table table-bordered table table-hover">
				<tr>
					<td>아이디 :</td>
					<td>${map.user.userId}</td>
				</tr>
				<tr>
					<td>이름 :</td>
					<td><input type="text" name="name" value="${map.user.name}" /></td>
				</tr>
				<tr>
					<td>성별 :</td>
					<td><c:forEach var="genderName" items="${map.genderList}">
							<c:choose>
								<c:when test="${genderName eq map.user.gender}">
									<input type="radio" name="gender" value="${genderName}"
										checked="checked">${genderName}
							</c:when>
								<c:otherwise>
									<input type="radio" name="gender" value="${genderName}">${genderName}
							</c:otherwise>
							</c:choose>
						</c:forEach></td>
				</tr>
				<tr>
					<td>거주지 :</td>
					<td><select name="city">
							<c:forEach var="cityName" items="${map.cityList}">
								<c:choose>
									<c:when test="${cityName eq map.user.city}">
										<option value="${cityName}" selected>${cityName}</option>
									</c:when>
									<c:otherwise>
										<option value="${cityName}">${cityName}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td colspan="2" class="text-center"><input type="submit"
						value="수정" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>