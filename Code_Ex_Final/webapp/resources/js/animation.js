function animation(element, type) {
	var width;
	var id;
	
	if (type == 'zoomIn') {
		width = 0;
		id = setInterval(zoomIn, 5);
	}else if (type == 'zoomOut'){
		width = 100;
		id = setInterval(zoomOut, 5); 
	}

	function zoomIn() {
		if (width == 100) {
			clearInterval(id);
		} else {
			width++;
			element.style.width = width + '%';
		}
	}
	
	function zoomOut() {
		if (width == 0) {
			clearInterval(id);
		} else {
			width--;
			element.style.width = width + '%';
		}
	}
}