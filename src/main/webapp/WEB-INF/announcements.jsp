<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/announcements.css">
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
<div class="mainContent">
		<h1 id="win"><i class="fa fa-trophy" aria-hidden="true"></i> The Winning Picture Is  </h1>	
	<div class="left">
		<h2><a href="events/${picture.event.id}"><img src="${picture.url}"></a></h2>
	</div>
	
	<div class="right">	
		<h2 class="title"><c:out value="${picture.title}"/></h2>
		<h3>Posted By <c:out value="${picture.user.firstName}"/> <c:out value="${picture.user.lastName}"/></h3>
		<h3>Total likes ${picture.likes} </h3>
		<h3>Event Name is <a href="events/${picture.event.id}"><c:out value="${picture.event.name}"/></a></h3>
	<br>
	<p>*The winner will receive a copy of the winning picture with a frame. </p>
	<p>*Please contact our admins to receive a copy of the picture.</p>
	<p>*Come back next week to participate again. We're looking forward to see your awesome photos!</p>
	</div>
</div>
	<!-- <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> -->
	<hr>
	<br>
	<p>*If you have any questions or concerns, feel free to contact us at: </p>

		<h3><button><a id="but" href="mailTo:cherry2ney@gmail.com">Contact Narae</a></button><button><a id="but" href="mailTo:elliezhao14@gmail.com"> Contact Ellie</a></button><button><a id="but" href="mailTo:jeffhendricks00@gmail.com"> Contact Jeff</a></button></h3>
</body>
</html>