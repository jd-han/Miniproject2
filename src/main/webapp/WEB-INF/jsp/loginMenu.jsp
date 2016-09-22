<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="faceBookLogin">
		<h2>페이스북 연동 또는 추가 정보를 입력하세요.</h2>
		<button>추가 정보 입력</button><p><p>
		<fb:login-button id="facebook" scope="public_profile,email" data-size="xlarge" onlogin="checkLoginState();" >페이스북 연동하기
		</fb:login-button>
	</div>
	<div id="loginForm">
		<div id="memberJoin">
			<h3>회원가입</h3>
			<span>*는 필수 사항입니다.</span>
		</div>
		<div id="memberUpdate">
			<h3>회원 정보 수정</h3>
		</div>
		<hr>
		<br>
		<table>
			<tr>
				<td>*아이디</td>
				<td><input type="text" size="30" id="inputId"/><span id = "checkId"></span></td>
			</tr>
			<tr>
				<td>*비밀번호</td>
				<td><input type="password" size="30" id="pass"/></td>
			</tr>
			<tr>
				<td>*비밀번호 확인</td>
				<td><input type="password" size="30" id="checkPass"/><span></span></td>
			</tr>
			<tr>
				<td>*우편번호</td>
				<td>
					<input type="text" size="6" readonly="readonly" placeholder="우편번호" id="postCode"/>
					<button id="searchAddress">우편번호 찾기</button>				
				</td>
			</tr>
			<tr>
				<td>*주소</td>
				<td><input type="text" size="40" id="address" readonly="readonly" placeholder="주소"/></td>
			</tr>
			<tr>
				<td>*상세 주소</td>
				<td><input type="text" size="40" id="detailAddress" placeholder="상세 주소"/></td>
			</tr>
			<tr>
				<td>*전공 여부</td>
				<td>
					<input type="checkbox" id="major" value="1"/> 전공 
					<input type="checkbox" id="notMajor" value="2"/> 비전공 
				</td>
			</tr>
		</table>
		<hr>
		<div id="memberJoinBtn">
			<button id="resetBtn">초기화</button>
			<button id= "submitJoin">가입</button>
		</div>
		<div id="memberUpdateBtn">
			<button id="submitUpdate">수정완료</button>
			<button id= "cancelUpdate">취소</button>
		</div>
	</div>
		<div id="moreInfo">
			<h3>추가 입력</h3>
		<hr>
		<br>
		<table>
			<tr>
				<td>*이름</td>
				<td><input type="text" size="30" id="inputName"/></td>
			</tr>
			<tr>
				<td>*email</td>
				<td><input type="text" size="10" id="inputEmail"/> @
					<select id="email">
						<option value="notEmail">선택</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="nate.com">nate.com</option>
					</select>
					<span id="completeEmail">인증 완료</span>
					<button id="submitEmail">인증</button>
					<input type="hidden" id="completeEmail" value="0" />
				</td>
			</tr>
			<tr>
				<td>사진</td>
				<td><input type="file" size="30" id="imgUpload" name="imgUpload"/></td>
			</tr>
		</table>
		<div id = "pLeft"></div>
		<div id = "pTop"></div>
		<div id="MoreInfoDiv">
			<br>
			<hr>
				<button id="submitMoreInfo">등록</button>
		</div>
	</div>
	<input type="hidden" id="userMajor" value="${user.major}" />
	<input type="hidden" id="face" value="${user.faceBook }" />
	<input type="hidden" id="confirmNum" />



	<script>
		var loginform = false;
		var equalId = false;
		var userNo;
		$("#login").click(function() {
			if (loginform == false) {
				$("#loginTextBox").slideDown(1000);
				loginform = true;
				return false;
			}
			if (loginform == true) {
				$("#loginTextBox").slideUp(1000);
				loginform = false;
				return false;
			}
		});
		$("#loginTextBox > form > button:eq(0)").click(function() {
			$("#loginTextBox").slideUp(1000);
			$("input[name='id']").val("");
			$("input[name='pass']").val("");
			loginform = false;
			$("#loginForm").css("display", "inherit");
			return false;
		});
		$("#loginTextBox > form > button:eq(1)")
				.click(function() {
						var id = $("input[name='id']").val();
						var pass = $("input[name='pass']").val();
						$.ajax({
							 url : "${pageContext.request.contextPath}/login/login.json",
							type : "POST",
							data : {"id" : id,"pass" : pass},
		                dataType : "json"
						})
						.done(function(result) {
							    console.log(result);
								if (result.login == "fail") {
										alert("아이디 또는 비밀번호를 확인하세요.");
									} else {
										$("#loginTextBox").slideUp(1000);
										$("input[name='id']").val("");
										$("input[name='pass']").val("");
										if (result.faceBook == "n") {
												userNo = result.memberNo;
												console.log(result);
												$("#faceBookLogin").css("display","inherit");
												$("#top").html("<a href='#1' onclick='mlecLogout()'>로그아웃</a>");
										} else {
											location.reload();
											return false;
											   }
										}
							});
						});
		function mlecLogout() {
			$.ajax({
				url : "${pageContext.request.contextPath}/login/logout.json",
				dataType : "html"
			}).done(function() {
				alert("로그아웃");
				$("#faceBookLogin").css("display", "none");
				$("#moreInfo").css("display", "none");
				location.reload();
			});
		}
		$("#inputId").keyup(function() {
			if ($("#inputId").val().length == 0) {
				$("#checkId").html("");
				return false;
			}
			if ($("#inputId").val().length <= 4) {
				$("#checkId").html(" id는 4글자 이상");
				return false;
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/login/checkId.json",
				data : {
					"id" : $("#inputId").val()
				},
				dataType : "html"
			}).done(function(result) {
				console.log(result.length);
				console.log(result)
				if (result.length != 6) {
					$("#checkId").html(" 사용 가능");
					equalId = false;
					return false;
				} else if (result.length == 6) {
					$("#checkId").html(" 중복");
					equalId = true;
					return false;
				}
			});
		});
		$("#checkPass").keyup(function() {
			if ($("#pass").val().length == 0) {
				alert("패스워드를 먼저 입력하세요.");
				$("#checkPass").val("");
				$("#pass").focus();
				return false;
			} else if ($("#pass").val().length > 0) {
				var getPass = $("#pass").val();
				if (getPass == $("#checkPass").val()) {
					$("#checkPass ~ span").html(" 일치");
				} else {
					$("#checkPass ~ span").html(" 불일치");
				}
			}
		});
		$("#searchAddress")
				.click(
						function() {
							new daum.Postcode(
									{
										oncomplete : function(data) {
											$("#postCode").val(data.zonecode);

											var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
											var extraRoadAddr = ''; // 도로명 조합형 주소 변수

											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraRoadAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraRoadAddr += (extraRoadAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraRoadAddr !== '') {
												extraRoadAddr = ' ('
														+ extraRoadAddr + ')';
											}
											// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
											if (fullRoadAddr !== '') {
												fullRoadAddr += extraRoadAddr;
											}
											$("#address").val(fullRoadAddr);
										}
									}).open();
						});
		$("#major").change(function() {
			if ($("#major").is(":checked")) {
				$("#notMajor").prop('checked', false);
			}
		});
		$("#notMajor").change(function() {
			if ($("#notMajor").is(":checked")) {
				$("#major").prop('checked', false);
			}
		});
		$("#resetBtn").click(function() {
			$("#postCode").val("");
			$("#address").val("");
			$("#pass").val("");
			$("#checkPass").val("");
			$("#checkPass ~ span").html("");
			$("#inputId").val("");
			$("#checkId").html("");
			$("#detailAddress").val("");
			$("#major").prop('checked', false);
			$("#notMajor").prop('checked', false);
		});

		function checkInputInfo(isUpdate) {
			var id = $("#inputId").val();
			var pass = $("#pass").val();
			var postalCode = $("#postCode").val();
			var address = $("#address").val();
			var detailAddress = $("#detailAddress").val();
			console.log(detailAddress);
			var major = 0;

			if ($("#major").is(":checked")) {
				major = 1;
			}

			var userData = {
				"id" : id,
				"pass" : pass,
				"postalCode" : postalCode,
				"address" : address,
				"detailAddress" : detailAddress,
				"major" : major
			};

			if (isUpdate == false) {
				if ($("#checkId").html() != " 사용 가능") {
					alert("아이디 다시 입력");
					$("#inputId").focus();
					$("#inputId").select();
					return false;
				}
			}
			if ($("#pass").val() == "") {
				alert("패스워드를 입력하세요");
				$("#pass").focus();
				$("#pass").select();
				return false;
			}
			if ($("#checkPass").val() == ""
					|| $("#checkPass ~ span").html() == " 불일치") {
				alert("패스워드를 확인하세요");
				$("#checkPass").focus();
				$("#checkPass").select();
				return false;
			}
			if ($("#postCode").val() == "") {
				alert("주소를 입력하세요.");
				$("#email ~ button").focus();
				return false;
			}
			if ($("#detailAddress").val() == "") {
				alert("상세 주소를 입력하세요.");
				$("#detailAddress").focus();
				return false;
			}
			if (!$("#major").is(":checked") && !$("#notMajor").is(":checked")) {
				alert("전공 여부를 선택해주세요.");
				return false;
			}
			return userData;
		}
		$("#submitJoin").click(function() {
			var isUpdate = false;
			var userData = checkInputInfo(isUpdate);
			if (userData == false) {
				return false;
			}
			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/login/joinMember.json",
				data : userData,
				dataType : "html"
			}).done(function(result) {
				$("#resetBtn").trigger("click");
				$("#loginForm").css("display", "none");
				alert("회원가입에 성공했습니다.");
			});
		});

		function statusChangeCallback(response) {
			if (response.status === 'connected') {
				joinFaceBook();
			} else if (response.status === 'not_authorized') {

			} else {
			}
		}

		function checkLoginState() {
			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});
		}

		window.fbAsyncInit = function() {
			FB.init({
				appId : 557447234456046,
				cookie : true, // enable cookies to allow the server to access 
				// the session
				xfbml : true, // parse social plugins on this page
				version : 'v2.5' // use graph api version 2.5
			});

			FB.getLoginStatus(function(response) {
			});

		};

		// Load the SDK asynchronously
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_KR/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));

		function joinFaceBook() {
			FB.api('/me?fields=id,name,email,picture', function(response) {
						$.ajax({
						    url : "${pageContext.request.contextPath}/login/facebookJoin.json",
						   data : {"name" : response.name,
								   "email" : response.email,
								   "id" : response.id,
								   "profile" : response.picture.data.url},
						   type : "POST",
					   dataType : "json"
						})
						.done( function (result) {
							console.log(result);
							$("#faceBookLogin").css("display", "none");
							alert("회원가입 성공");
							location.reload();
						});
			});
		}
		function changeInfo() {
			$.ajax({
				url : "${pageContext.request.contextPath}/login/getInfo.json",
				data : {
					"id" : "${user.id}"
				},
				dataType : "json"
			}).done(function(result) {
				$("#memberJoin").css("display", "none");
				$("#memberUpdate").css("display", "inherit");
				$("#memberJoinBtn").css("display", "none");
				$("#memberUpdateBtn").css("display", "inherit");
				$("#loginForm").css("display", "inherit");
				$("#inputId").attr("readonly", "readonly");
				$("#inputId").val(result.id);
				$("#postCode").val(result.postalCode);
				$("#address").val(result.address);
				$("#detailAddress").val(result.detailAddress);
				if (result.major == 1) {
					$("#major").prop('checked', true);
				} else {
					$("#notMajor").prop('checked', true);
				}
			});
		}
		function resetUpdateText() {
			$("#memberJoin").css("display", "inherit");
			$("#memberUpdate").css("display", "none");
			$("#memberJoinBtn").css("display", "inherit");
			$("#memberUpdateBtn").css("display", "none");
			$("#loginForm").css("display", "none");
			$("#inputId").removeAttr("readonly");
			$("#inputId").val("");
			$("#pass").val();
			$("#postCode").val("");
			$("#address").val("");
			$("#detailAddress").val("");
			$("#major").prop('checked', false);
			$("#notMajor").prop('checked', false);

		}
		$("#cancelUpdate").click(function() {
			alert("수정을 취소하였습니다.");
			resetUpdateText();
		});
		$("#submitUpdate").click(function() {
			var isUpdate = true;
			var userData = checkInputInfo(isUpdate);
			if (userData == false) {
				return false;
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/login/updateInfo.json",
				type : "POST",
				data : userData,
				dataType : "html"
			}).done(function() {
				location.reload();
				alert("회원정보를 수정하였습니다.");
			});
		});
		var userMoreMenu = false;
		$("a[name='userName']").click(function() {
			if (userMoreMenu == false) {
				$("#top > ul > li > ul > li").css("display", "block");
				userMoreMenu = true;
				return false;
			}
			if (userMoreMenu == true) {
				$("#top > ul > li > ul > li").css("display", "none");
				userMoreMenu = false;
				return false;
			}
		});
		var count = 0;
		$("body").click(function() {
			count++;
			$("#loginTextBox").click(function() {
				return false;
			});
			if (loginform == true && count > 1) {
				$("#loginTextBox").slideUp(1000);
				loginform = false;
				return false;
			}

			if (userMoreMenu == true) {
				$("#top > ul > li > ul > li").css("display", "none");
				userMoreMenu = false;
				return false;
			}
		});

		var userEmail = "";
		$("#submitEmail").click(function() {
			if ($("#inputEmail").val() == "") {
				alert("이메일을 입력하세요.");
				$("#inputEmail").select();
				$("#inputEmail").focus();
				return false;
			}
			var emailId = $("#inputEmail").val();
			if ($("#email").val() == "notEmail") {
				alert("이메일을 선택해주세요");
				$("#email").select();
				$("#email").focus();
				return false;
			}
			var emailType = $("#email").val();
			userEmail = emailId + "@" + emailType;
			$.ajax({
				url : "${pageContext.request.contextPath}/login/sendEmail.json",
				data : {
					"email" : userEmail
				},
				dataType : "html"
			}).done(function(result) {
				console.log(result);
				if (result.indexOf('fail') > -1) {
					alert("중복된 이메일 입니다.");
					return false;
				}
				$("#confirmNum").val(result.replace("\"",""));
				window.open("email.jsp", "pop", "width=300px, height=200px;");
			});
		});
		var fileJson = "";
		var isImg = false;
		$("#imgUpload").change( function() {
				var fd = new FormData();
				fd.append("id", "${user.id}");
				fd.append("img", $("#imgUpload")[0].files[0]);
				$.ajax({
					url : "${pageContext.request.contextPath}/login/imgUpload.json",
				   type : "POST",
				   data : fd,
			processData : false,
			contentType : false,
			   dataType : "json",
			    success : function(result) {
					fileJson = result;
					isImg = true;
					$("#pTop").html("<img src='${pageContext.request.contextPath}" + result.filepath + result.realpath + "/thumbnail_" + result.realname + "' id='picture'/>");
				}
			});
		});
		$("#submitMoreInfo").click( function() {
			console.log(userNo);
			if ($("#inputName").val() == "") {
					alert("이름을 입력하세요.");
					$("#inputName").focus();
					return false;
			}
			if ($("#completeEmail").val() == 0) {
					alert("메일 인증을 완료하세요.");
					return false;
			}
			$.ajax({
				url : "${pageContext.request.contextPath}/login/moreInfoUpdate.json",
			   type : "POST",
			   data : {"memberNo" : userNo,
					   "filepath" : fileJson.filepath,
					   "realpath" : fileJson.realpath,
					   "realname" : fileJson.realname,
					   "oriname" : fileJson.oriname,
					   "name" : $("#inputName").val(),
					   "email" : userEmail},
		   dataType : "html"
		   }).done(function(result) {
				alert("추가 정보 입력 성공");
				location.reload();
			});
		});
		$("#faceBookLogin > button").click(function() {
			$("#moreInfo").css("display", "block");
			$("#faceBookLogin").css("display", "none");
			return false;
		});
	</script>