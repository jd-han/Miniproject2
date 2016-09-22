<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<div id="menu-Bar">
	
</div>
<div id="top">
	<c:choose>
			<c:when test="${empty user}">
				<a href="#1" id="login">로그인</a>	
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${user.faceBook != 'n'}">
						<div id ="menu-div" class="collapse navbar-collapse bs-example-js-navbar-collapse">
								<ul class="nav navbar-nav navbar-right">
									<li class="dropdown">
									<a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false">
												${user.name}
									<span class="caret"></span>
									</a>
										<ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
											<li role="presentation"><a role="menuitem" tabindex="-1" href="#1" onclick='changeInfo()'>정보 수정</a></li>
											<li role="presentation"><a role="menuitem" tabindex="-1" href="#1" onclick='mlecLogout()'>로그 아웃</a></li>
										</ul>
									</li>
								</ul>
							</div>
							<c:choose>
								<c:when test="${user.faceBook == 'y' }">
									<img id="asdasd" src='${user.profile}' />										
								</c:when>
								<c:when test="${user.profile =='y'}">
									<img id="asdasd" src="${pageContext.request.contextPath}${file.filepath}${file.realpath}/thumbnail_${file.realname}" width="53px" height="53px"/>
								</c:when>
								<c:otherwise>
									
								</c:otherwise>
							</c:choose>
					</c:when>
					<c:otherwise>
						<a href='#1' id='memberInfoText' onclick='mlecLogout()' >로그 아웃</a>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
	</c:choose>
</div>

<div id="loginTextBox">
      	<form>
		<div class="form-group">
			<label for="exampleInputEmail1">Id</label> <input
				type="email" class="form-control" name="id" id="exampleInputEmail1"
				placeholder="id">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Password</label> <input
				type="password" class="form-control" name="pass" id="exampleInputPassword1"
				placeholder="Password">
		</div>
		<button type="button" class="btn btn-default">Join</button>
		<button type="button" class="btn btn-default">Login</button>
	</form>
</div>