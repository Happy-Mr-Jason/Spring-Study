<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Read Page</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<div class="form-group">
					<label>Bno</label> <input class="form-control" name='bno'
						value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Title</label> <input class="form-control" name='title'
						value='<c:out value="${board.title }"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name='content'
						readonly="readonly"><c:out value="${board.content}" /></textarea>
				</div>

				<div class="form-group">
					<label>Writer</label> <input class="form-control" name='writer'
						value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>

				<%-- 		<button data-oper='modify' class="btn btn-default">
        <a href="/board/modify?bno=<c:out value="${board.bno}"/>">Modify</a></button>
        <button data-oper='list' class="btn btn-info">
        <a href="/board/list">List</a></button> --%>


				<button data-oper='modify' class="btn btn-default">Modify</button>
				<button data-oper='list' class="btn btn-info">List</button>

				<%-- <form id='operForm' action="/boad/modify" method="get">
  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
</form> --%>

				<%-- <%= request.getParameter("pageNum") %>
<%= request.getParameter("amount") %>
<c:set var="cri" value="${param }"/> --%>
				<%-- <c:out value="${cri.pageNum}"/>
<c:out value="${cri.amount}"/>
 --%>
				<form id='operForm' action="/boad/modify" method="get">
					<input type='hidden' id='bno' name='bno'
						value='<c:out value="${board.bno}"/>'> <input
						type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum}"/>'> <input
						type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type='hidden' name='keyword'
						value='<c:out value="${cri.keyword}"/>'> <input
						type='hidden' name='type' value='<c:out value="${cri.type}"/>'>

				</form>



			</div>
			<!--  end panel-body -->

		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
				<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New
					Reply</button>
			</div>

			<!-- /.panel-heading -->
			<div class="panel-body">
				<ul class="chat">
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<samll class="pull-right text-muted">2020-09-01 14:00</samll>
							</div>
							<p>Good job!</p>
						</div>
					</li>
				</ul>
			</div>
			<div class="panel-footer"></div>
		</div>
	</div>
</div>

<!-- Modal -->

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
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
				<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");

	var modalModifyBtn = $("#modalModifyBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalCloseBtn = $("#modalCloseBtn");

	var bnoValue = '<c:out value = "${board.bno}"/>';

	function showNewReplyModal() {
		modal.find("input").val("").removeAttr("readonly");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalRegisterBtn.show();
		modal.modal("show");
	};

	modalRegisterBtn.on("click", function() {
		var reply = {
			reply : modalInputReply.val(),
			replyer : modalInputReplyer.val(),
			bno : bnoValue
		};
		addReply(reply);
		modal.find("input").val("");
		modal.modal("hide");
		pageNum = endNum;
		showReplyList(pageNum);
	});

	function addReply(reply) {
		replyService.add(reply, function(result) {
			alert("Result : " + result);
		});
	}
</script>

<script>

	var pageNum = 1;
	var endNum = 1;
	var startNum = 1;
	var replyPageFooter = $(".panel-footer");

	function showReplyList(page) {

		var bnoValue = '<c:out value = "${board.bno}"/>';
		var replyUL = $('.chat');

		replyService.getList({
			bno : bnoValue,
			page : page || 1
		}, function(replyCount, list) {
			if (page == -1) {
				pagenum = Math.ceil(replyCount / 10.0);
				showReplyList(pagenum);
				return;
			}

			var str = "";

			if (list == null || list.length == 0) {
				replyUL.html("");
				return;
			}
			for (var i = 0, len = list.length || 0; i < len; i++) {
				str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str += "<div>";
				str += "<div class='header'>";
				str += "<strong class='primary-font'>" + list[i].replyer
						+ "</strong>";
				str += "<samll class='pull-right text-muted'>"
						+ replyService.displayTime(list[i].replyDate)
						+ "</samll>";
				str += "</div>";
				str += "<p>" + list[i].reply + "</p>";
				str += "</div>";
				str += "</li>";

			}
			replyUL.html(str);
			console.log("replycount : " , replyCount);
			showReplyPage(replyCount);
		});
	}
</script>


<script>
	function showReplyModal(reply) {
		modalInputReply.val(reply.reply);
		modalInputReplyer.val(reply.replyer).attr("readonly", "readonly");
		modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
				.attr("readonly", "readonly");

		modal.data("rno", reply.rno);
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalModifyBtn.show();
		modalRemoveBtn.show();
		modal.modal("show");
	}

	modalModifyBtn.on("click", function(e) {
		var bnoValue = '<c:out value="${board.bno}"/>';
		var reply = {
			rno : modal.data("rno"),
			reply : modalInputReply.val(),
		};

		replyService.update(reply, function(result) {
			alert(result);
			modal.modal("hide");
			showReplyList(pageNum);
		});
	});

	modalRemoveBtn.on("click", function(e) {
		var rno = modal.data("rno");
		replyService.remove(rno, function(result) {
			if (result === "success") {
				alert("REMOVED");
			}
		}, function(err) {
			alert("ERROR...");
		});
		modal.modal("hide");
		showReplyList(pageNum);
	});

	modalCloseBtn.on("click", function(e) {

		modal.modal("hide");
	});
</script>

<script type="text/javascript">
	$(document).ready(function() {

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {

			operForm.attr("action", "/board/modify").submit();

		});

		$("button[data-oper='list']").on("click", function(e) {

			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();

		});

		showReplyList(pageNum);

		$('#addReplyBtn').on("click", function(e) {
			showNewReplyModal();
		});

		$(".chat").on("click", "li", function(e) {
			var rno = $(this).data("rno");
			replyService.get(rno, function(reply) {
				showReplyModal(reply);
			});
		});

	});
</script>

<script>

	function showReplyPage(replyCount) {
		endNum = Math.ceil(pageNum / 10.0) * 10;
		startNum = endNum - 9;

		var prev = startNum != 1;
		var next = false;

		if (endNum * 10 >= replyCount) {
			endNum = Math.ceil(replyCount / 10.0);
		}

		if (endNum * 10 < replyCount) {
			next = true;
		}

		var str = "<ul class='pagination pull-right'>";

		if (prev) {
			str += "<li class='page-item'><a class='page-link' href='"
					+ (startNum - 1) + "'>Previous</a></li>";
		}

		for (var i = startNum; i <= endNum; i++) {
			
			var active = (pageNum == i ? "active" : "");

			str += "<li class='page-item " + active + "'>";
			str += "<a class='page-link' href='" + i + "'>" + i + "</a>";
			str += "</li>";
		}

		if (next) {
			str += "<li class='page-item'><a class='page-link' href='"
					+ (endNum + 1) + "'>Next</a></li>";
		}

		str += "</ul></div>";

		replyPageFooter.html(str);
	}

	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		var targetPageNum = $(this).attr("href");

		console.log("targetPageNum : " + targetPageNum);
		pageNum = targetPageNum;
		showReplyList(pageNum);
		});
</script>


<%@include file="../includes/footer.jsp"%>
