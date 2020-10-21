<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@include file="../includes/header.jsp"%>

<script type="text/javascript" src="/resources/js/modify.js"></script>
<script type="text/javascript" src="/resources/js/animation.js"></script>

<body>

	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board Modify</h1>
				<div class="card shadow">
					<div class="card-header">
						<h3>Board Modify</h3>
					</div>
					<!-- /.card-header -->
					<div class="card-body">
						<form role="form" action="/board/modify" method="post">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input type='hidden' name='pageNum'
								value='<c:out value="${cri.pageNum }"/>'> <input
								type='hidden' name='amount'
								value='<c:out value="${cri.amount }"/>'> <input
								type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
							<input type='hidden' name='keyword'
								value='<c:out value="${cri.keyword }"/>'>

							<div class="form-group">
								<label>Bno</label> <input class="form-control" name='bno'
									value='<c:out value="${board.bno }"/>' readonly="readonly">
							</div>

							<div class="form-group">
								<label>Title</label> <input class="form-control" name='title'
									value='<c:out value="${board.title }"/>'>
							</div>

							<div class="form-group">
								<label>Content</label>
								<textarea class="form-control" rows="3" name='content'><c:out
										value="${board.content}" /></textarea>
							</div>

							<div class="form-group">
								<label>Writer</label> <input class="form-control" name='writer'
									value='<c:out value="${board.writer}"/>' readonly="readonly">
							</div>

							<div class="form-group">
								<label>RegDate</label> <input class="form-control"
									name='regDate'
									value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />'
									readonly="readonly">
							</div>

							<div class="form-group">
								<label>Update Date</label> <input class="form-control"
									name='updateDate'
									value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updateDate}" />'
									readonly="readonly">
							</div>
							
							<sec:authentication property="principal" var="pinfo"/>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${pinfo.username eq board.writer }">
									<button type="button" data-oper='modify'
										class="btn btn-outline-primary">Modify</button>
									<button type="button" data-oper='remove' class="btn btn-danger">Remove</button>
								</c:if>
							</sec:authorize>
							
							<button type="button" data-oper='list'
								class="btn btn-outline-info">List</button>
						</form>


					</div>
					<!--  end card-body -->

				</div>
				<!--  end card-body -->
			</div>
			<!-- end card -->
		</div>
		<!-- /.row -->
		<div class="row mt-3">
			<div class="col-lg-12">
				<div class="card shadow">
					<div class="card-header">
						<h3>
							Attatched Files
							<div class="uploadBadge float-right">
								<span class="badge badge-info mx-1 float-right"></span>
							</div>
						</h3>
					</div>
					<!-- /.card-header -->
					<div class="card-body">
						<div class="form-group uploadDiv">
							<input id="uploadFile" type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult overflow-auto">
							<ul class="list-group list-group-horizontal">
							</ul>
						</div>
					</div>
					<!-- /.card-body -->
				</div>
				<!-- /.card -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>

</body>

</html>
