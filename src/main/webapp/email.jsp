<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
	html,body {
		width: 300px;
		height: 200px;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	인증 메일이 발송되었습니다.
	<br>
	인증 번호 4자리 입력
	<br>
	<input type="text" size="4" />
	<button id = "confirm">인증</button>
	<script>
		$("#confirm").click(function () {
			var confirmNum = opener.document.getElementById("confirmNum");
			console.log(confirmNum.value);
			if (parseInt(confirmNum.value) == $("input[type='text']").val()) {
				alert("인증에 성공했습니다.");
				var completeEmail = opener.document.getElementById("completeEmail");
				var eBtn = opener.document.getElementById("submitEmail");
				var eId = opener.document.getElementById("inputEmail");
				var selectEmail = opener.document.getElementById("email");
				var completeEmail = opener.document.getElementById("completeEmail");
				eId.readOnly = true;
				selectEmail.disabled = true;
				eBtn.style.display = "none";
				completeEmail.style.display = "inline-block";
				completeEmail.value = 1;
				self.close();
			} else {
				alert("인증번호를 다시 확인해주세요.");
				$("input[type='text']").val("");
				$("input[type='text']").focus();
				return false;
			}
		});
	</script>
</body>
</html>