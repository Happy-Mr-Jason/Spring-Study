<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<script type="text/javascript" src="/resources/js/animation.js"></script>
<script type="text/javascript" src="/resources/js/get.js"></script>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Board Read</h1>
				<div class="card shadow">
					<div class="card-header">
						<h3>Board Read Page</h3>
					</div>
					<!-- /.card-heading -->
					<div class="card-body">

						<div class="form-group">
							<label>Bno</label> <input class="form-control" name='bno'
								value='<c:out value="${board.bno }"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>Title</label> <input class="form-control" name='title'
								value='<c:out value="${board.title }"/>' readonly="readonly">
						</div>

						<div class="form-group">
							<label>Content</label>
							<textarea class="form-control" rows="3" name='content'
								readonly="readonly"><c:out value="${board.content}" /></textarea>
						</div>

						<div class="form-group">
							<label>Writer</label> <input class="form-control" name='writer'
								value='<c:out value="${board.writer }"/>' readonly="readonly">
						</div>

						<button data-oper='modify' class="btn btn-outline-primary">Modify</button>
						<button data-oper='list' class="btn btn-outline-info">List</button>

						<form id='operForm' action="/boad/modify" method="get">
							<input type='hidden' id='bno' name='bno'
								value='<c:out value="${board.bno}"/>'> <input
								type='hidden' name='pageNum'
								value='<c:out value="${cri.pageNum}"/>'> <input
								type='hidden' name='amount'
								value='<c:out value="${cri.amount}"/>'> <input
								type='hidden' name='keyword'
								value='<c:out value="${cri.keyword}"/>'> <input
								type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
						</form>
					</div>
					<!--  end card-body -->
				</div>
				<!--  /.card -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.row -->
		<div class="row mt-3">
			<div class="col-lg-12">
				<div class="card shadow">
					<div class="card-header">
						<h3>
							Attatched Files
							<div class="uploadBadge float-right">
    						<span class="badge badge-info mx-1 float-right"></span></div>
						</h3>
					</div>
					<!-- /.card-header -->
					<div class="card-body">
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
		<div class="row mt-3">
			<div class="col-lg-12">
				<div class="card shadow">
					<div class="card-header">
						<h3>
							Reply
							<div class="float-right">
								<button id='addReplyBtn' type="button"
									class='btn btn-outline-primary btn-xs'>New Reply</button>
							</div>
						</h3>
					</div>
					<!-- /.card-header -->
					<div class="card-body">
						<ul class="chat list-group">
							<li class="list-group-item" data-rno='12'>
								<div>
									<div class="header">
										<strong class="primary-font">user00</strong> <small
											class="float-right text-muted">2020-09-01 14:00</small>
									</div>
									<p>Good job!</p>
								</div>
							</li>
						</ul>
					</div>
					<!-- /.card-body -->
					<div class="card-footer" id="reply-footer"></div>
					<!-- /.card-footer  -->
				</div>
				<!-- /.card -->
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!--/.row -->
	</div>
	<!-- /.container -->
	
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label> <input class="form-control" name='reply'
							value='New Reply!!!!'>
					</div>
					<div class="form-group">
						<label>Replyer</label> <input class="form-control" name='replyer'
							value='Replyer'>
					</div>
					<div class="form-group">
						<label>Reply Date</label> <input class="form-control"
							name='replyDate' value=''>
					</div>
				</div>
				<div class="modal-footer">
					<button id='modalModifyBtn' type="button" class="btn btn-warning">Modify</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
					<button id='modalCloseBtn' type="button"
						class="btn btn-outline-primary">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- /.modal -->
</body>

</html>



