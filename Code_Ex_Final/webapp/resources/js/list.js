document.addEventListener("DOMContentLoaded", function() {

	var result = document.getElementById('result').getAttribute('data-result');

	checkModal(result);

	history.replaceState({}, null, null);

	function checkModal(result) {
		console.log("result : " + result);

		if (result === '' || history.state) {
			return;
		}

		if (parseInt(result) > 0) {
			$(".modal-body").html(
				"게시글 " + parseInt(result)
				+ " 번이 등록되었습니다.");
		} else if (result === 'modify_success') {
			$(".modal-body").html("게시글이 수정되었습니다.");
		} else if (result === 'del_success') {
			$(".modal-body").html("게시글이 삭제되었습니다.");
		}

		$("#myModal").modal("show");
	}

	$("#regBtn").on("click", function() {

		self.location = "/board/register";

	});

	var actionForm = document.getElementById("actionForm");
	var pageLinks = document.querySelectorAll(".page-link");

	if (pageLinks != null) {
		for (var i = 0; i < pageLinks.length; i++) {
			pageLinks[i].addEventListener("click", function() {
				console.log('click');
				var inputPageNum = actionForm.querySelector("input[name='pageNum']");
				inputPageNum.value = this.dataset.page;
				actionForm.submit();
			});
		}
	}

	var moveLinks = document.querySelectorAll(".move");
	if(moveLinks !=null){
		for(var i = 0; i < moveLinks.length; i++){
			moveLinks[i].addEventListener("click", function(){
				
			var str = "<input type='hidden' name='bno' value='"
				+ this.dataset.bno + "'>";
			actionForm.appendChild(stringToHTML(str))
			actionForm.setAttribute("action", "/board/get");
			actionForm.submit();
			});
		}
	}

	var searchForm = $("#searchForm");

	$("#searchForm button").on(
		"click",
		function(e) {

			if (!searchForm.find("option:selected")
				.val()) {
				alert("검색종류를 선택하세요");
				return false;
			}

			if (!searchForm.find(
				"input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}

			searchForm.find("input[name='pageNum']")
				.val("1");
			e.preventDefault();

			searchForm.submit();

		});

});