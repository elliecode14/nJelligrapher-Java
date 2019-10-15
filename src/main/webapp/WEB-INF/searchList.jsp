<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/tag-results.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>nJelligrapher</title>
</head>
<body>
<div class="header">
	<h4><a href="/events"><i class="fa fa-angle-double-left" aria-hidden="true"></i> Back to Dashboard</a></h4>
	<div class="search">
		<form action="/events/search" method="post" >
			<p><input id="search" type="search" name="name" placeholder="Search tags here..">
			<button><i class="fa fa-search" aria-hidden="true"></i> Search </button>
			<p>
		</form>
	</div> 
	<div class="logout">
		<a href="/logout">Log Out</a>
	</div>	
</div>
	<h1>Pictures with tags searched:</h1>
	
		<c:forEach var="picture" items="${pictures}">
	<div class="content">
			<h2> <c:out value="${picture.title}"/> </h2>
			<img src="${picture.url}">
	</div>
		</c:forEach>
</body>
</html>