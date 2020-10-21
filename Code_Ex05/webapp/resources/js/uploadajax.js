
document.addEventListener("DOMContentLoaded", function(e) {

	console.log("DOMContentLoaded....");

	var uploadBtn = document.getElementById("uploadBtn");

	uploadBtn.onclick = function() {

		var uploadFile = document.getElementById("uploadFile");
		var initUploadFile = document.createElement("input");
		initUploadFile.type = "file";
		initUploadFile.name = "uploadFile";
		initUploadFile.id = "uploadFile";
		initUploadFile.multiple = true;

		var formData = new FormData();
		var inputFile = document.querySelector("input[name='uploadFile']");
		var files = inputFile.files;
		/*console.log("This is the fileList : ", files);*/

		for (var i = 0; i < files.length; i++) {

			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}

			formData.append('uploadFile', files[i]);
		}

		/*formData.forEach((value,name) => console.log("Name : ",name,"Value : ",value));*/

		fetch('/uploadAjaxAction', {
			method: 'POST',
			body: formData
		}).then(response => response.json())
			.then(response => {
				console.log('Success:', response);
				showUploadedFile(response);
				uploadFile.replaceWith(initUploadFile);

				/*alert('Files are Uploaded Successfully~!!');*/
			})
			.catch(error => console.error('Error:', error));
	};

	var wrapper = document.querySelector(".bigPictureWrapper");
	wrapper.onclick = function() {
		var image = document.querySelector(".bigPicture img");
		animation(image, 'zoomOut');
		setTimeout(function() {
			wrapper.style.display = "none";
		}, 500)
	}
});

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
var maxSize = 5242880;

function checkExtension(fileName, fileSize) {
	console.log("checkExtension.....");
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

function showUploadedFile(uploadResultArr) {
	var uploadResult = document.querySelector(".uploadResult ul");

	while (uploadResult.hasChildNodes()) {
		uploadResult.removeChild(uploadResult.firstChild);
	}

	var str = "";
	for (var i = 0; i < uploadResultArr.length; i++) {
		str = uploadResultArr[i].fileName;
		var node = document.createElement("li");
		var div = document.createElement("div");
		var link = document.createElement("a");
		var imageIcon = document.createElement("img");
		var textnode = document.createTextNode(str);
		var textnode2 = document.createTextNode("×");
		var span = document.createElement("span");
		var fileCallPath = null;
		node.setAttribute("class", "horizon-item");
		span.appendChild(textnode2);
		if (!uploadResultArr[i].image) {
			fileCallPath = encodeURIComponent(uploadResultArr[i].uploadPath + "/" + uploadResultArr[i].uuid + "_" + uploadResultArr[i].fileName)
			link.setAttribute("href", "/download?fileName=" + fileCallPath);
			imageIcon.setAttribute("src", "/resources/img/attach-file.png");
			link.appendChild(imageIcon);
			link.appendChild(textnode);
			span.setAttribute("data-file", fileCallPath);
			span.setAttribute("data-type", 'file');
		} else {
			fileCallPath = encodeURIComponent(uploadResultArr[i].uploadPath + "/s_" + uploadResultArr[i].uuid + "_" + uploadResultArr[i].fileName)
			var originPath = uploadResultArr[i].uploadPath + "\\" + uploadResultArr[i].uuid + "_" + uploadResultArr[i].fileName;
			originPath = originPath.replace(new RegExp(/\\/g), "/");
			link.setAttribute("href", "javascript:showImage('" + originPath + "')");
			imageIcon.setAttribute("src", "/display?fileName=" + fileCallPath);
			imageIcon.classList.add("imagefile");
			link.appendChild(imageIcon);
			span.setAttribute("data-file", fileCallPath);
			span.setAttribute("data-type", 'image');
		}

		div.appendChild(link);
		div.appendChild(span);
		node.appendChild(div);
		span.addEventListener('click', onClickDeleteFile);
		uploadResult.appendChild(node);
	}
	console.log(str);
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

	console.log(data);

	//fetch('/deleteFile?' + 'fileName=' + targetFile + '&type=' + type, {
	fetch('/deleteFile?' + new URLSearchParams(data), {
		method: 'POST',
	}).then(response => response.text())
		.then(response => alert(response));
}
