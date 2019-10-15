<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- <link rel="stylesheet" href="/css/dashboard.css"> -->
	<link rel="stylesheet" href="/css/dash-board.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Quicksand&display=swap" >
	<title>nJelligrapher</title>
</head>

<body>

	<div class="header">
		
		<h1>Welcome, <c:out value="${user.firstName}"/> <i class="fa fa-heart" aria-hidden="true"></i></h1>
		
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

	<div class="navbar">
		<a href="/announcements" id="amt"><i class="fa fa-bullhorn" aria-hidden="true"></i> Announcements</a>
		<a href="/events/pictures"><i class="fa fa-picture-o" aria-hidden="true"></i> View All Pictures</a>
		<a href="#add_event"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add An Event</a>
	</div>

<!-- 	<h3>Events near you </h3> -->

	<table>
		<thead>
			<tr>
				<th> <h2>Events Near You</h2> </th>
			<!-- 	<th> Date </th>
				<th> Location </th>
				<th> Host </th>
				<th> Action </th> -->
			</tr>
		</thead>	
		<tbody>
			<c:forEach items="${eventsInState}" var ="e">
		<tr>
			<td>
			<h3><a href="/events/${e.id}"><c:out value="${e.name}"/></a></h3>
			<p><i class="fa fa-user-o" aria-hidden="true"></i> <c:out value="${e.host.firstName}"/> <c:out value="${e.host.lastName}"/></p>
			<p><i class="fa fa-map-marker" aria-hidden="true"></i> <c:out value="${e.city}"/>, <c:out value="${e.state}"/></p>
			<p><i class="fa fa-calendar-o" aria-hidden="true"></i> <fmt:formatDate value="${e.date}" pattern="MMMM dd, yyyy"/></p>
			</td>
			<td class="join_button">
			
				<c:set var="attending" value="null" />
			
				<c:forEach items="${e.users}" var="u">
					<c:if test="${u.id == user.id}">
						<c:set var="attending" value="true" />
					</c:if>
				</c:forEach>
				
				<c:if test="${attending.contains('null')}">	
			
					<form:form action="/events/join" method="POST" modelAttribute="middleTable">
						<form:hidden path="user" value="${user.id}"></form:hidden>
						<form:hidden path="event" value="${e.id}"></form:hidden>
						<button>Join Event</button>
					</form:form>
				</c:if>
				
				<c:if test="${attending == true }">
					<form action="/events/cancel" method="post">
					    <input type="hidden" name="_method" value="delete">
					    
						<input type="hidden"  name="user" value="${user.id}">
						<input type="hidden"  name="event" value="${e.id}">
					    <p>Going <button>Cancel</button></p>
					</form>
					
				</c:if>

			</td>
		</tr>
	</c:forEach> 
		</tbody>
	</table>
	
<!-- 	<h3>Events in other locations </h3> -->
	<table>
		<thead>
			<tr>
				<th> <h2>Other Events </h2></th>
			<!-- 	<th> Date </th>
				<th> Location </th>
				<th> Host </th>
				<th> Action </th> -->
			</tr>
		</thead>	
		<tbody>
			<c:forEach items="${eventsOutState}" var ="e">
		<tr>
			<td>
			<h3><a href="/events/${e.id}"><c:out value="${e.name}"/></a></h3>
			<p><i class="fa fa-user-o" aria-hidden="true"></i> <c:out value="${e.host.firstName}"/> <c:out value="${e.host.lastName}"/></p>
			<p><i class="fa fa-map-marker" aria-hidden="true"></i> <c:out value="${e.city}"/>, <c:out value="${e.state}"/></p>
			<p><i class="fa fa-calendar-o" aria-hidden="true"></i> <fmt:formatDate value="${e.date}" pattern="MMMM dd, yyyy"/></p>
			<td class="join_button">

				<c:set var="attending" value="null" />
			
				<c:forEach items="${e.users}" var="u">
					<c:if test="${u.id == user.id}">
						<c:set var="attending" value="true" />
					</c:if>
				</c:forEach>
				
				<c:if test="${attending.contains('null')}">	
			
				<form:form action="/events/join" method="POST" modelAttribute="middleTable">
					<form:hidden path="user" value="${user.id}"></form:hidden>
					<form:hidden path="event" value="${e.id}"></form:hidden>
					<button>Join Event</button>
				</form:form>
				</c:if>
				
				<c:if test="${attending == true }">
				<form action="/events/cancel" method="post">
				    <input type="hidden" name="_method" value="delete">
					<input type="hidden"  name="user" value="${user.id}">
					<input type="hidden"  name="event" value="${e.id}">
				    <p>Going <button>Cancel</button></p>
				</form>
				</c:if>
			</td>
		</tr>
	</c:forEach> 
		</tbody>
	</table>
	
	
   <div class="add">
      <div id="add_event" class="overlay">
                <div class="popup">
                    <h2 id="color">ADD AN EVENT: </h2>
                    <hr>
                    <br>
                    <a class="close" href="#">&times;</a>
                    <div class="content">
			<p><form:errors path="event.*"/></p>
			<form:form action="/events" method="POST" modelAttribute="event">
				<p>
					<form:label path="name">Name </form:label>
					<form:input type="text" placeholder="Event Name" path="name"/>
				</p>
				<p>
					<form:label path="date">Date </form:label>
					<form:input type="date" path="date"/>
				</p>
				<p>
					<form:label path="description">Description </form:label>
					<form:textarea type="text" rows="4" cols="50" placeholder="Tell us about the event!" path="description"/>
				</p>
				<p>
					<form:label path="city">Location </form:label>
				</p>
				<p>
					<form:input id="city4" type="text" placeholder="City of event" path="city"/>
					
					<form:select id="state4" path="state">
							<form:option value="AL">AL</form:option>
							<form:option value="AK">AK</form:option>
							<form:option value="AZ">AZ</form:option>
							<form:option value="AR">AR</form:option>
							<form:option value="CA">CA</form:option>
							<form:option value="CO">CO</form:option>
							<form:option value="CT">CT</form:option>
							<form:option value="DE">DE</form:option>
							<form:option value="DC">DC</form:option>
							<form:option value="FL">FL</form:option>
							<form:option value="GA">GA</form:option>
							<form:option value="HI">HI</form:option>
							<form:option value="ID">ID</form:option>
							<form:option value="IL">IL</form:option>
							<form:option value="IN">IN</form:option>
							<form:option value="IA">IA</form:option>
							<form:option value="KS">KS</form:option>
							<form:option value="KY">KY</form:option>
							<form:option value="LA">LA</form:option>
							<form:option value="ME">ME</form:option>
							<form:option value="MD">MD</form:option>
							<form:option value="MA">MA</form:option>
							<form:option value="MI">MI</form:option>
							<form:option value="MN">MN</form:option>
							<form:option value="MS">MS</form:option>
							<form:option value="MO">MO</form:option>
							<form:option value="MT">MT</form:option>
							<form:option value="NE">NE</form:option>
							<form:option value="NV">NV</form:option>
							<form:option value="NH">NH</form:option>
							<form:option value="NJ">NJ</form:option>
							<form:option value="NM">NM</form:option>
							<form:option value="NY">NY</form:option>
							<form:option value="NC">NC</form:option>
							<form:option value="ND">ND</form:option>
							<form:option value="OH">OH</form:option>
							<form:option value="OK">OK</form:option>
							<form:option value="OR">OR</form:option>
							<form:option value="PA">PA</form:option>
							<form:option value="RI">RI</form:option>
							<form:option value="SC">SC</form:option>
							<form:option value="SD">SD</form:option>
							<form:option value="TN">TN</form:option>
							<form:option value="TX">TX</form:option>
							<form:option value="UT">UT</form:option>
							<form:option value="VT">VT</form:option>
							<form:option value="VA">VA</form:option>
							<form:option value="WA">WA</form:option>
							<form:option value="WV">WV</form:option>
							<form:option value="WI">WI</form:option>
							<form:option value="WY">WY</form:option>
						</form:select>				
				</p>
				<form:hidden path="host" value="${user.id}"></form:hidden>
				<br>
				<hr>
				<br>
				<button id="add">Add</button>
        		<a href="#" id="color"><button type="button" id="cancel" data-dismiss="modal">Later</button></a>
			</form:form>
      </div>
       </div>
    </div>
            

  </div>
  <br><br>
<!--   <div class="footer">

	<p>*If you have any questions or concerns, feel free to contact us: </p>

	<h3><a href="mailTo:cherry2ney@gmail.com">Contact Narae</a> |
	<a href="mailTo:elliezhao14@gmail.com"> Contact Ellie</a> |
	<a href="mailTo:jeffhendricks00@gmail.com"> Contact Jeff</a></h3>
	</div> -->

<br>

</body>
</html>