<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="/resources/js/animation.js"></script>
<script type="text/javascript" src="/resources/js/register.js"></script>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board Register</h1>
				<div class="card shadow">
					<div class="card-header">
						<h3>Board Register</h3>
					</div>
					<!-- /.card-header -->
					<div class="card-body">
						<form role="form" action="/board/register" method="post">
							<div class="form-group">
								<label>Title</label> <input class="form-control" name='title'>
							</div>
							<div class="form-group">
								<label>Content</label>
								<textarea class="form-control" rows="3" name='content'></textarea>
							</div>
							<div class="form-group">
								<label>Writer</label> <input class="form-control" name='writer'>
							</div>
							<button type="submit" class="btn btn-outline-primary btn-xs">Submit</button>
							<button type="reset" class="btn btn-outline-primary btn-xs">Reset</button>
							<button type="button" data-oper='list' class="btn btn-outline-info">List</button>
						</form>
					</div>
					<!--  end card-body -->
				</div>
				<!--  end card -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row mt-3">
			<div class="col-lg-12">
				<div class="card shadow">
					<div class="card-header">
						<h3>File Attach</h3>
					</div>
					<!--  end card-header -->
					<div class="card-body">
						<div class="form-group uploadDiv">
							<input id="uploadFile" type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult overflow-auto">
							<ul class="list-group list-group-horizontal">
							</ul>
						</div>
					</div>
					<!--  end card-body -->
				</div>
				<!--  end card -->
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
