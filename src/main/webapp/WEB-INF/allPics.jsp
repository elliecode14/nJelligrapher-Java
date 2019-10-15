<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Satisfy&display=swap" rel="stylesheet">
	<script src="/js/script.js"></script>
	<link rel="stylesheet" href="/css/all-pics.css"/>
	<title>nJelligrapher</title>
</head>
<body>
	<div class="header">Welcome To Our Photograph Section <i class="fa fa-camera" aria-hidden="true"></i></div>
	<div class="images">
		<c:forEach var="picture" items="${pictures}">
			<div class="image">
				<div class="vote_bar">
					<div id="progress" class="vote_fill_${picture.id}" style="width:${picture.likes}%"></div>
				</div>
				<div class="pic_div">
					<img src="${picture.url}">
				</div>
					<div class="wrapper">
							<a href="javascript:void(0);" data-photo-id="${picture.id}" class="like_button neutral">
						    <i class="fa fa-heart-o not-liked" aria-hidden="true" style="color:teal"></i>
							</a>
					</div>
				<p class="photo_name">${picture.title}</p>
			</div>
		</c:forEach>
	</div>
	<span class="navbar"><a href="/events">Back To Dashboard</a></span>
</body>
</html>