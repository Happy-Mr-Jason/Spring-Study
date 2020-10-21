<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="includes/header.jsp"%>
<body>
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col-lg-4">
				<div class="card shadow">
					<div class="card-header">
						<h1 class="page-header">Please Sign In</h1>
					</div>
					<div class="card-body">
						<form role="form" method="post" action="/login">
							<fieldset>
								<div class="form-group">
									<input class="form-control" type='text' name='username'
										value='admin'>
								</div>
								<div class="form-group">
									<input class="form-control" type='password' name='password'
										value='admin'>
								</div>
								<div class="input-group">
									<div class="input-group-prepend">
										<div class="input-group-text">
											<input class="form-group mb-0" type="checkbox"
												name='remember-me'>
										</div>
									</div>
									<div class="input-group-append">
										<span class="input-group-text">Remember Me</span>
									</div>
								</div>
								<div class="form-group mt-3">
									<a class="btn btn-lg btn-success btn-block">Login</a>
								</div>
							</fieldset>
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
					<div class="card-footer none">
						<h6>
							<c:out value="${error}" />
						</h6>
						<h6>
							<c:out value="${logout}" />
						</h6>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
var loginBtn = document.querySelector(".btn-success");
loginBtn.addEventListener("click", function(){
	var formObj = document.querySelector("form[role='form']");
	formObj.submit();
});

</script>

</body>
</html>