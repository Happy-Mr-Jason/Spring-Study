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
						<h1 class="page-header">Logout</h1>
					</div>
					<div class="card-body">
						<form role="form" method="post" action="/customLogout">
							<fieldset>
								<div class="form-group mt-3">
									<a class="btn btn-lg btn-success btn-block">Logout</a>
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
var logoutBtn = document.querySelector(".btn-success");
logoutBtn.addEventListener("click", function(){
	var formObj = document.querySelector("form[role='form']");
	formObj.submit();
});

</script>

</body>
</html>