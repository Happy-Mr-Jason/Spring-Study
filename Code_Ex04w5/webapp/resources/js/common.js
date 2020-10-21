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

function stringToHTML(str) {
	var tempElem = document.createElement("temp");
	tempElem.innerHTML = str;
	return tempElem.firstChild;
}

function elementEmpty(element){
	while (element.hasChildNodes()) {
		element.removeChild(element.firstChild);
	}
}