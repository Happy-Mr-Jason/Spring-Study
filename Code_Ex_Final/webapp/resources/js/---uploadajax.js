
document.addEventListener("DOMContentLoaded", function(e) {
	var wrapper = document.querySelector(".bigPictureWrapper");
	wrapper.onclick = function() {
		var image = document.querySelector(".bigPicture img");
		animation(image, 'zoomOut');
		setTimeout(function() {
			wrapper.style.display = "none";
		}, 500)
	}
});

function showUploadedFile(uploadResultArr) {
	var uploadResult = document.querySelector(".uploadResult ul");

	while (uploadResult.hasChildNodes()) {
		uploadResult.removeChild(uploadResult.firstChild);
	}

	var str = "";
	for (var i = 0; i < uploadResultArr.length; i++) {
		var obj = uploadResultArr[i];
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
		if (!obj.image) {
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
		buttonClose.appendChild(spanDelete);
		div.appendChild(spanFilename);
		div.appendChild(buttonClose);
		div.appendChild(link);
		node.appendChild(div);
		spanDelete.addEventListener('click', onClickDeleteFile);
		uploadResult.appendChild(node);
	}
	//console.log(str);
}

function showImage(fileCallPath) {
	//alert(fileCallPath);
	var picture = document.querySelector(".bigPicture");
	var image = document.createElement("img");

	while (picture.hasChildNodes()) {
		picture.removeChild(picture.firstChild);
	}

	image.setAttribute("src", "/display?fileName=" + encodeURI(fileCallPath));
	picture.appendChild(image);
	var wrapper = document.querySelector(".bigPictureWrapper");
	wrapper.style.display = "flex";
	animation(image, 'zoomIn');
}

function onClickDeleteFile() {
	var targetFile = this.dataset.file;
	var type = this.dataset.type;
	var data = { fileName: targetFile, type: type };
	var parentLi = this.closest("li");

	//console.log(parentLi);
	//console.log("deleteFile : " + data.fileName);

	//fetch('/deleteFile?' + 'fileName=' + targetFile + '&type=' + type, {
	fetch('/deleteFile?' + new URLSearchParams(data), {
		method: 'POST',
	}).then(response => response.text())
		.then(response => {
			alert(response);
			parentLi.remove();
		});
}
