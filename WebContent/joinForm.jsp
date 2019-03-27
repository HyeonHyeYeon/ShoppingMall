<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<style>
table {
	width: 470px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<h1 align="center">회원 등록</h1>
	<form name="joinForm" action="memberInsert" method="post"
		onsubmit="return formCheck();">
		<table border="1" align="center">
			<tr>
				<td align="center">회원번호</td>
				<!-- Dao에서 값을 받아 띄워준다, readonly(페이지에서 변수값을 바꾸지 못하게 한다.) -->
				<td><input type="text" id="회원번호" name="custno"
					value="${custno}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td align="center">가입날짜</td>
				<td><input type="text" id="가입날짜" name="joindate"
					value="${date}" /></td>
			</tr>
			<tr>
				<td align="center">ID</td>
				<td>* 4~12자의 영문 대소문자와 숫자로만 입력 <input type="text" id="ID"
					name="id" maxlength="12" /> <!-- 아이디 유효성 검사 --> <input
					type="button" value="확인" onclick="return idChek();" /><br>
					<div id="idOk"></div></td>
			</tr>
			<tr>
				<td align="center">Password</td>
				<td>* 4~12자의 영문 대소문자, 숫자, 특수문자 로만 입력<input type="password"
					id="Password" name="pw" maxlength="12" /><br> <input
					type="password" id="pwChk" name="password" maxlength="12"
					onchange="pw_check();" />
					<div id="pwOk"></div>
					<div id="pwNo"></div></td>
			</tr>
			<tr>
				<td align="center">성명</td>
				<td><input type="text" id="성명" name="name" /></td>
			</tr>
			<tr>
				<td align="center">회원주소</td>
				<td><input type="text" id="주소" name="addr" /></td>
			</tr>
			<tr>
				<td align="center">생일</td>
				<td><input type="date" id="생일" name="birth" class="datepicker" /></td>
			</tr>
			<tr>
				<td align="center">이메일</td>
				<td><input type="email" id="email" name="email" /> &nbsp; <input
					type="button" value="확인" onclick="return emailChek();" />
					<div id="emailOk"></div>
					<div id="emailNo"></div></td>
			</tr>
		</table>
		<br>
		<div align="center">
			<input type="button" id="formok" value="가입하기" onclick="forward(this)" />
			&nbsp;<input type="reset" value="리셋" />
		</div>
	</form>
	${success}
</body>
<script>
	//아이디 유효성 체크
	function idChek() {
		var id = $("#ID").val();
		var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;

		if (check.test(id)) {
			$("#idOk").html("한글이 포함되어 있습니다.");
			$("#ID").val("").focus();
			return false;
		} else {
			$.ajax({
				url : "idChek",
				data : {
					"id" : id
				},
				type : "post",
				success : function(result) {
					if (result.count == 0) {
						$("#idOk").html("사용가능한 아이디 입니다.");
					} else {
						$("#idOk").html("아이디가 이미 존재합니다.");
						$("#ID").val("").focus();
					}
				},
				error : function(error) {
					console.log(error);
				}
			});
		}
	}

	//pw유호성 체크
	function pw_check() {
		var pw = $("#Password").val();
		var pwchk = $("#pwChk").val();
		$("#pwOk").hide();
		$("#pwNo").hide();

		if (pw == pwchk) {
			$("#pwOk").html("비밀번호가 일치합니다.");
			$("#pwOk").show();
		} else {
			$("#pwNo").html("비밀번호가 일치하지 않습니다.");
			$("#pwNo").show();
			$("#pwChk").val("").focus();
		}
	}

	//이메일 유효성 체크
	function emailChek() {
		var email = $("#email").val();
		var check = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9_\.\-]+\.[A-Za-z0-9_\.\-]+/;
		$("#emailOk").hide();
		$("#emailNo").hide();

		if (check.test(email) == false) {
			$("#emailNo").html("이메일 형식이 올바르지 않습니다.");
			$("#emailNo").show();
			$("#email").val("").focus();
		} else {
			$("#emailOk").html("이메일 형식확인.");
			$("#emailOk").show();
		}
	}

	function fromCheck() {
		/* form의 마지막 두개의 태그 빼고 */
		var len = document.joinForm.length - 2;
		var form = document.joinForm;
		/* 반복문으로 len을 돌려 검사한다. */
		for (var i = 0; i < len; i++) {
			/* 각 태그의 value값이 없거나 비어있으면 alert을 띄운다. */
			if (form[i].value == "" || form[i].value == null) {
				alert(form[i].id + "을(를) 입력하세요.");
				/* 포커스를 비어있는 태그로 옮긴다. */
				form[i].focus();
			}
		}
	}

	function forward(button) {
		var frm = document.joinForm;

		frm.action = "memberJoin";
		frm.submit(); /* 컨트롤러에게 요청 */
	}
</script>
</html>