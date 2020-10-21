<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>Insert title here</title>
<link href="/resources/css/menu_h.css" rel="stylesheet" type="text/css">
<link href="/resources/css/picture_view.css" rel="stylesheet"
	type="text/css">
<link href="/resources/css/circle.css" rel="stylesheet" type="text/css">
<script src="/resources/js/uploadajax.js" type="text/javascript"></script>
<script src="/resources/js/animation.js" type="text/javascript"></script>

</head>
<body>
	<h1>Upload Files using Ajax</h1>
	
	<div class="uploadDiv" id="uploadDiv">
		<input type='file' name='uploadFile' id='uploadFile' multiple />
	</div>

	<div class="uploadResult horizon-panel">
		<ul class="horizon-menu">
		</ul>
	</div>

	<button id='uploadBtn'>Upload</button>

	<div class='bigPictureWrapper'>
		<div class='bigPicture'></div>
	</div>

</body>
</html>