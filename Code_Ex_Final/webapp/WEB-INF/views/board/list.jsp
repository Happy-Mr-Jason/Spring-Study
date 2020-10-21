<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<body>
	<div class="container">
		<div class="row mt-3">
			<div class="col-lg-12">
				<h1 class="page-header">Tables</h1>
				<div class="card shadow">
					<div class="card-header">
						<h3>
							Board List Page
							<div class="float-right">
								<button id='regBtn' type="button"
									class="btn btn-outline-primary btn-sm">Register New
									Board</button>
							</div>
						</h3>
					</div>
					<!-- /.card-header -->
					<div class="card-body">
						<div class="table-responsive">
							<table
								class="table table-striped table-bordered table-hover text-nowrap">
								<thead class="thead-light">
									<tr class="text-center">
										<th>#번호</th>
										<th>제목 <span class="badge badge-info mx-1 float-right">attach</span>
											<span class="badge badge-primary mx-1 float-right"> reply</span>
										</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>수정일</th>
									</tr>
								</thead>

								<c:forEach items="${list}" var="board">
									<tr>
										<td><c:out value="${board.bno}" /></td>
										<td><a class='move'
											data-bno='<c:out value="${board.bno}"/>'> <c:out
													value="${board.title}" />
										</a> <c:if test="${board.attachCnt > 0}">
												<span class="badge badge-info mx-1 float-right"> <c:out
														value="${board.attachCnt }" /></span>
											</c:if> <c:if test="${board.replyCnt > 0}">
												<span class="badge badge-primary mx-1 float-right"> <c:out
														value="${board.replyCnt }" /></span>
											</c:if></td>

										<td><c:out value="${board.writer}" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd"
												value="${board.regdate}" /></td>
										<td><fmt:formatDate pattern="yyyy-MM-dd"
												value="${board.updateDate}" /></td>
									</tr>
								</c:forEach>
							</table>
						</div>

						<div class='row mt-3'>
							<div class="col-lg-5">
								<form id='searchForm' action="/board/list" method='get'>
									<div class="input-group">
										<select class="custom-select" name='type'>
											<option value=""
												<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
											<option value="T"
												<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
											<option value="C"
												<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
											<option value="W"
												<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
											<option value="TC"
												<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목
												or 내용</option>
											<option value="TW"
												<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목
												or 작성자</option>
											<option value="TWC"
												<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목
												or 내용 or 작성자</option>
										</select>
										<div class="input-group-append">
											<input type='text' name='keyword'
												value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
												type='hidden' name='pageNum'
												value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
												type='hidden' name='amount'
												value='<c:out value="${pageMaker.cri.amount}"/>' />
											<button class='btn btn-outline-primary btn-sm float-right'
												type="button">Search</button>
										</div>
									</div>
								</form>
							</div>
						</div>

						<nav class="mt-3">
							<ul
								class="pagination pagination-sm d-flex flex-wrap justify-content-center">

								<c:if test="${pageMaker.prev}">
									<li class="page-item"><a class="page-link" href="#"
										data-page="${pageMaker.startPage -1}">Previous</a></li>
								</c:if>

								<c:forEach var="num" begin="${pageMaker.startPage}"
									end="${pageMaker.endPage}">
									<li class="page-item ${pageMaker.cri.pageNum == num ? "active":""} ">
										<a class="page-link" href="#" data-page="${num}">${num}</a>
									</li>
								</c:forEach>

								<c:if test="${pageMaker.next}">
									<li class="page-item"><a class="page-link" href="#"
										data-page="${pageMaker.endPage +1 }">Next</a></li>
								</c:if>

							</ul>
						</nav>
						<!--  end Pagination -->
						<form id='actionForm' action="/board/list" method='get'>
							<input type='hidden' name='pageNum'
								value='${pageMaker.cri.pageNum}'> <input type='hidden'
								name='amount' value='${pageMaker.cri.amount}'> <input
								type='hidden' name='type'
								value='<c:out value="${ pageMaker.cri.type }"/>'> <input
								type='hidden' name='keyword'
								value='<c:out value="${ pageMaker.cri.keyword }"/>'>
						</form>
					</div>
					<!--  end card-body -->
				</div>
				<!-- end card -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container -->
	<!-- Modal 에 전달될 내용 -->
	<div id="result" data-result="<c:out value="${result}"/>"></div>

	<!-- Modal  추가 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">Register Result</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-primary"
						data-dismiss="modal">Close</button>
					<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
</body>

</html>
<script src="/resources/js/list.js" type="text/javascript"></script>
