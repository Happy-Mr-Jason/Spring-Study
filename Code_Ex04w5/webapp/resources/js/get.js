$(document).ready(function() {

	var bnoNumber = document.querySelector("input[name='bno']");
	var bnoValue = bnoNumber.value;
	//console.log("bnoValue : " + bnoValue);

	var operForm = $("#operForm");

	$("button[data-oper='modify']").on("click", function() {

		operForm.attr("action", "/board/modify").submit();

	});

	$("button[data-oper='list']").on("click", function() {

		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();

	});

	showReplyList(pageNum);

	$('#addReplyBtn').on("click", function() {
		showNewReplyModal();
	});

	$(".chat").on("click", "li", function() {
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply) {
			console.log("Reply list clicked......", reply);
			showReplyModal(reply);
		});
	});

	getAttach(bnoValue);

	var modal = document.getElementById("myModal");
	var modalInputReply = modal.querySelector("input[name='reply']");
	var modalInputReplyer = modal.querySelector("input[name='replyer']");
	var modalInputReplyDate = modal.querySelector("input[name='replyDate']");

	var modalModifyBtn = document.querySelector("#modalModifyBtn");
	var modalRemoveBtn = document.querySelector("#modalRemoveBtn");
	var modalRegisterBtn = document.querySelector("#modalRegisterBtn");
	var modalCloseBtn = document.querySelector("#modalCloseBtn");

	window.onclick = function(event) {
		if (event.target == modal) {
			modalToggle();
		}
	};

	function modalToggle() {
		if (modal.style.display == "none" || modal.style.display == "") {
			modal.style.display = "block";
			setTimeout(function() {
				modal.classList.add("show");
				var modalBackdrop = document.createElement("div");
				modalBackdrop.classList.add("modal-backdrop", "fade", "show");
				document.body.appendChild(modalBackdrop);
			}, 500);
			document.body.classList.add("modal-open");
			//document.body.style // padding-right = "17px";
		} else {
			modal.classList.remove("show");
			setTimeout(function() {
				modal.style.display = "none";
				document.body.classList.remove("modal-open");
				document.body.style.removeProperty("padding-right");
				var modalBackdrop = document.querySelector(".modal-backdrop");
				console.dir("modalBackdrop", modalBackdrop);
				document.body.removeChild(modalBackdrop);
			}, 500);
		}
	};

	function getAttach(bnoValue) {
		fetch("/board/getAttachList?bno=" + bnoValue, {
			method: 'GET'
		}).then(response => response.json())
			.then(response => {
				//console.log(response);
				showAttachList(response);
			});
	};

	function showAttachList(attachList) {
		var uploadResult = document.querySelector(".uploadResult ul");
		var uploadBadge = document.querySelector(".uploadBadge");
		var uploadCnt = uploadBadge.querySelector("span");
		
		if (attachList == null || attachList.length == 0) {
			uploadBadge.style.display = "none";
			return;
		}
			//console.log(uploadCnt);
			uploadCnt.innerHTML = attachList.length;
		var str = "";
		for (var i = 0; i < attachList.length; i++) {
			var obj = attachList[i];
			str = obj.fileName;
			var node = document.createElement("li");
			var div = document.createElement("div");
			var link = document.createElement("a");
			var imageIcon = document.createElement("img");
			var textnode = document.createTextNode(str);
			var textnode2 = document.createTextNode("×");
			var spanDelete = document.createElement("span");
			var spanFilename = document.createElement("span");
			var fileCallPath = null;
			var buttonClose = document.createElement("button");
			buttonClose.classList.add("border-0", "rounded-circle", "bg-danger", "position-absolute");
			buttonClose.attributes = {
				'type': "button",
				'aria-label': "Close",
				'style': "top: 0; right: 0;"
			};
			buttonClose.style.top = 0;
			buttonClose.style.right = 0;
			spanDelete.setAttribute('aria-hidden', "true");

			node.classList.add("list-group-item", "text-center");
			node.dataset.path = obj.uploadPath;
			node.dataset.uuid = obj.uuid;
			node.dataset.filename = obj.fileName;
			node.dataset.type = obj.fileType;

			spanDelete.appendChild(textnode2);
			if (!obj.fileType) {
				fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName)
				link.setAttribute("href", "/download?fileName=" + fileCallPath);
				imageIcon.setAttribute("src", "/resources/img/attach.png");
				link.appendChild(imageIcon);
				spanDelete.setAttribute("data-file", fileCallPath);
				spanDelete.setAttribute("data-type", 'file');
			} else {
				fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName)
				var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				originPath = originPath.replace(new RegExp(/\\/g), "/");
				link.setAttribute("href", "javascript:showImage('" + originPath + "')");
				imageIcon.setAttribute("src", "/display?fileName=" + fileCallPath);
				imageIcon.classList.add("imagefile");
				link.appendChild(imageIcon);
				spanDelete.setAttribute("data-file", fileCallPath);
				spanDelete.setAttribute("data-type", 'image');
			}
			spanFilename.appendChild(textnode);
			buttonClose.style.display = "none";
			buttonClose.appendChild(spanDelete);
			div.appendChild(spanFilename);
			div.appendChild(buttonClose);
			div.appendChild(link);
			node.appendChild(div);
			uploadResult.appendChild(node);
		}
	}

	closeImage();

	function replyModalInputInit() {
		var modalInputs = modal.getElementsByTagName("input");
		if (modalInputs != null) {
			for (var i = 0; i < modalInputs.length; i++) {
				modalInputs[i].value = "";
				modalInputs[i].removeAttribute("readonly");
			}
		}
	};

	function showNewReplyModal() {
		console.log("showNewReplyModal......");

		replyModalInputInit();

		modalInputReplyDate.closest("div").style.display = "none";
		var modalButtons = modal.querySelectorAll(".modal-footer button:not(#modalCloseBtn)");
		if (modalButtons != null) {
			for (var i = 0; i < modalButtons.length; i++) {
				modalButtons[i].style.display = "none";
			}
		}

		modalRegisterBtn.style.display = "inline-block";
		console.dir(modal);
		modalToggle();
	};

	modalRegisterBtn.onclick = function() {
		var reply = {
			reply: modalInputReply.value,
			replyer: modalInputReplyer.value,
			bno: bnoValue
		};
		addReply(reply);
		replyModalInputInit();
		modalToggle();
		pageNum = endNum;
		showReplyList(pageNum);
	};

	function addReply(reply) {
		replyService.add(reply, function(result) {
			alert("Result : " + result);
		});
		showReplyList(pageNum);
	};

	var pageNum = 1;
	var endNum = 1;
	var startNum = 1;

	function showReplyList(page) {

		var replyUL = $('.chat');

		replyService.getList({
			bno: bnoValue,
			page: page || 1
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
				str += "<li class='list-group-item clearfix' data-rno='" + list[i].rno + "'>";
				str += "<div>";
				str += "<div class='header'>";
				str += "<strong class='primary-font'>" + list[i].replyer +
					"</strong>";
				str += "<samll class='float-right text-muted'>" +
					replyService.displayTime(list[i].replyDate) +
					"</samll>";
				str += "</div>";
				str += "<p>" + list[i].reply + "</p>";
				str += "</div>";
				str += "</li>";

			}
			replyUL.html(str);
			//console.log("replycount : ", replyCount);
			showReplyPage(replyCount);
		});
	};

	function showReplyModal(reply) {
		modalInputReply.value = reply.reply;
		modalInputReplyer.value = reply.replyer
		modalInputReplyer.setAttribute("readonly", "readonly");
		modalInputReplyDate.value = replyService.displayTime(reply.replyDate);
		modalInputReplyDate.setAttribute("readonly", "readonly");
		modal.dataset.rno = reply.rno;
		var modalButtons = modal.querySelectorAll(".modal-footer button:not(#modalCloseBtn)");
		if (modalButtons != null) {
			for (var i = 0; i < modalButtons.length; i++) {
				modalButtons[i].style.display = "none";
			}
		}
		modalModifyBtn.style.display = "inline-block";
		modalRemoveBtn.style.display = "inline-block";
		modalToggle();
	};

	modalModifyBtn.onclick = function() {
		var reply = {
			rno: modal.dataset.rno,
			reply: modalInputReply.value
		};

		replyService.update(reply, function(result) {
			alert(result);
			modalToggle();
			showReplyList(pageNum);
		});
	};

	modalRemoveBtn.onclick = function() {
		var rno = modal.dataset.rno;
		replyService.remove(rno, function(result) {
			if (result === "success") {
				alert("REMOVED");
			}
		}, function() {
			alert("ERROR...");
		});

		modalToggle();
		showReplyList(pageNum);
	};

	modalCloseBtn.onclick = function() {
		modalToggle();
	};

	var modalCloseXBtn = document.querySelector("button.close");

	modalCloseXBtn.onclick = function() {
		modalToggle();
	};

	function showReplyPage(replyCount) {

		var replyPageFooter = document.getElementById("reply-footer");

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

		var str = "<nav><ul class='pagination pagination-sm d-flex flex-wrap justify-content-center'>";

		if (prev) {
			str += "<li class='page-item'><button class='page-link' href='" +
				(startNum - 1) + "'>Previous</button></li>";
		}

		for (var i = startNum; i <= endNum; i++) {

			var active = (pageNum == i ? "active" : "");

			str += "<li class='page-item " + active + "'>";
			str += "<button class='page-link' href='" + i + "'>" + i + "</button>";
			str += "</li>";
		}

		if (next) {
			str += "<li class='page-item'><button class='page-link' href='" +
				(endNum + 1) + "'>Next</button></li>";
		}

		str += "</ul></nav></div>";

		//console.log(str);

		replyPageFooter.innerHTML = "";
		replyPageFooter.appendChild(stringToHTML(str));

		var listLinks = replyPageFooter.querySelectorAll("li button"); //li a 가 여러개 이므로 ...
		//console.log(listLinks);

		if (listLinks != null) {
			for (var i = 0; i < listLinks.length; i++) {
				listLinks[i].addEventListener("click", linkClick);
			}
		}
	};

	function linkClick() {
		console.log("page click");
		pageNum = this.getAttribute("href");
		console.log("targetPageNum : " + pageNum);
		showReplyList(pageNum);
	};

});

function showImage(fileCallPath) {
	//alert(fileCallPath);
	var picture = document.querySelector(".bigPicture");
	var image = document.createElement("img");

	elementEmpty(picture);

	image.setAttribute("src", "/display?fileName=" + encodeURI(fileCallPath));
	picture.appendChild(image);
	var wrapper = document.querySelector(".bigPictureWrapper");
	wrapper.style.display = "flex";
	animation(image, 'zoomIn');
}

function closeImage(){
	var wrapper = document.querySelector(".bigPictureWrapper");
	wrapper.onclick = function() {
		var image = document.querySelector(".bigPicture img");
		animation(image, 'zoomOut');
		setTimeout(function() {
			wrapper.style.display = "none";
		}, 500)
	}
}