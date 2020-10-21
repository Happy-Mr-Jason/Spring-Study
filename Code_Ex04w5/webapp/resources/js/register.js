document.addEventListener("DOMContentLoaded", function() {

	//var submitBtn = document.getElementById("testBtn");
	var submitBtn = document.querySelector("button[type='submit']");
	submitBtn.addEventListener("click", submitBtnClick);

	var fileSelector = document.querySelector("input[type='file']");
	fileSelector.addEventListener("change", fileselector_change);
	
	var buttonBack = document.querySelector("button[data-oper='list']");
	buttonBack.addEventListener("click", goBack);
	
	closeImage();
});

function goBack(){
	console.log("goBack.........");
	window.history.back();
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

function submitBtnClick() {
	var formObj = document.querySelector("form[role='form']");
	//console.log("submit clicked");

	var str = "";
	var tempElem = document.createElement("div");
	var listObj = document.querySelectorAll(".uploadResult ul li");
	listObj.forEach(function(elem, key) {
		var jobj = elem;

		console.dir(jobj);
		
		str += "<input type='hidden' name='attachList[" + key + "].fileName' value='" + jobj.dataset.filename + "'>";
		str += "<input type='hidden' name='attachList[" + key + "].uuid' value='" + jobj.dataset.uuid + "'>";
		str += "<input type='hidden' name='attachList[" + key + "].uploadPath' value='" + jobj.dataset.path + "'>";
		str += "<input type='hidden' name='attachList[" + key + "].fileType' value='" + jobj.dataset.type + "'>";
	});
		tempElem.innerHTML=str;
		formObj.appendChild(tempElem);
		formObj.submit();
};

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
		node.dataset.type = obj.image;

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

function fileselector_change() {

	//console.log("file change!");

	var formData = new FormData();
	var inputFile = document.querySelector("input[name='uploadFile']");
	var files = inputFile.files;
	//console.log("This is the fileList : ", files);

	for (var i = 0; i < files.length; i++) {

		if (!checkExtension(files[i].name, files[i].size)) {
			return false;
		}

		formData.append('uploadFile', files[i]);
	}

	//formData.forEach((value,name) => console.log("Name : ",name,"Value : ",value));

	fetch('/uploadAjaxAction', {
		method: 'POST',
		body: formData
	}).then(response => response.json())
		.then(response => {
			//console.log('Success:', response);
			showUploadedFile(response);
			/*alert('Files are Uploaded Successfully~!!');*/
		})
		.catch(error => console.error('Error:', error));
};

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;

function checkExtension(fileName, fileSize) {
	//console.log("checkExtension.....");
	if (fileSize >= maxSize) {
		alert("파일 사이즈 초과");
		return false;
	}

	if (regex.test(fileName)) {
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}

