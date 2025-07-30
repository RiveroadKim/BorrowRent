<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발로렌트</title>
    <!-- css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
</head>

<body>
	<button class="home-button" onclick="window.location.href='${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/template/mainpage.jsp'">홈페이지로 돌아가기</button>
    <form method="post" action="${pageContext.request.contextPath}/action/signupAction.jsp">
        <div class="signup-container-wrapper">
            <div class="signup-container">
                <h1 class="title">회원가입</h1>
                <div class="input-group">
                    <label for="username" class="input-label">이메일</label>
                    <input type="text" id="username" placeholder="이메일" onkeyup="checkUsername()" name="userEmail">
                    <small id="username-message"></small>
                </div>
                <div class="input-group">
                    <label for="password" class="input-label">비밀번호</label>
                    <input type="password" id="password" placeholder="비밀번호" onkeyup="checkPassword()" name="userPassword">
                </div>
                <div class="input-group">
                    <label for="confirm-password" class="input-label">비밀번호 확인</label>
                    <input type="password" id="confirm-password" placeholder="비밀번호 확인" onkeyup="checkPassword()">
                    <small id="password-message"></small>
                </div>
                <div class="input-group">
                    <label for="name" class="input-label">이름</label>
                    <input type="text" placeholder="이름" name="userName">
                </div>
                <div class="input-group">
                    <label for="gender" class="input-label">성별</label>
                    <select name="userGender">
                        <option value="">성별</option>
                        <option value="남성">남성</option>
                        <option value="여성">여성</option>
                    </select>
                </div>
                <div class="input-group">
                    <label for="birthdate" class="input-label">생년월일</label>
                    <input type="text" placeholder="생년월일(년4자)" name="userBirth">
                </div>
                <div class="input-group">
                    <label for="phone" class="input-label">핸드폰번호</label>
                    <input type="text" placeholder="핸드폰번호" name="userPnum">
                </div>
                <div class="input-group">
                    <label for="address" class="input-label">주소</label>
                    <input type="text" placeholder="주소" name="userAddress">
                </div>
                <div class="input-group">
                    <label for="student-proof" class="input-label">대학생 증명(ex: 학생증사진)</label>
                    <input type="file" id="student-proof" placeholder="대학생 증명" name="userStudent">
                </div>
                <button type="submit" class="btn btn-primary form-control" id="signup-button">가입하기</button>
            </div>
        </div>
    </form>
</body>
<!-- javascript -->
<script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</html>
