<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");

 	// 로그인된 사용자 정보 가져오기
    String userEmail = (String) session.getAttribute("userEmail");
    UserDao userDao = new UserDao();
    User user = userDao.getUserByEmail(userEmail);

    // 폼 제출 처리
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String newName = request.getParameter("newName");
    String newBirth = request.getParameter("newBirth");
    String newPnum = request.getParameter("newPnum");
    String newAddress = request.getParameter("newAddress");

    if (currentPassword != null && !currentPassword.isEmpty()) {
        boolean updateSuccess = userDao.updateUserInfo(userEmail, currentPassword, newPassword, newName, newBirth, newPnum, newAddress);

        if (updateSuccess) {
            out.println("<script>alert('정상적으로 수정되었습니다.'); location.href='myinfo.jsp';</script>");
        } else {
            out.println("<script>alert('정보 수정에 실패했습니다.'); history.back();</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발로렌트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />
    
    <div class="mypage-container">
        <div class="mypage-sidebar">
            <a href="myinfo.jsp"><button>개인정보확인/수정</button></a>
            <a href="myrentlist.jsp"><button>대여내역</button></a>
            <a href="myalarm.jsp"><button>알림내역</button></a>
            <a href="myinquiry.jsp"><button>문의하기/내역확인</button></a>
        </div>

        <div class="container myinfo">
            <h2>개인정보확인/수정</h2>
            <form method="post">
                <table class="info-table">
                    <tr>
                        <td>아이디(이메일)</td>
                        <td><input type="email" value="<%= user.getUserEmail() %>" readonly></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>비밀번호</td>
                        <td><input type="password" name="currentPassword" placeholder="현재 비밀번호 입력"></td>
                        <td><input type="password" name="newPassword" placeholder="새 비밀번호 입력"></td>
                    </tr>
                    <tr>
                        <td>이름</td>
                        <td><input type="text" value="<%= user.getUserName() %>" readonly></td>
                        <td><input type="text" name="newName" placeholder="변경할 이름 입력"></td>
                    </tr>
                    <tr>
                        <td>생년월일</td>
                        <td><input type="text" value="<%= user.getUserBirth() %>" readonly></td>
                        <td><input type="text" name="newBirth" placeholder="변경할 생년월일 입력"></td>
                    </tr>
                    <tr>
                        <td>핸드폰번호</td>
                        <td><input type="text" value="<%= user.getUserPnum() %>" readonly></td>
                        <td><input type="text" name="newPnum" placeholder="변경할 전화번호 입력"></td>
                    </tr>
                    <tr>
                        <td>주소</td>
                        <td><input type="text" value="<%= user.getUserAddress() %>" readonly></td>
                        <td><input type="text" name="newAddress" placeholder="변경할 주소 입력"></td>
                    </tr>
                </table>
                <div class="buttons">
                    <button type="submit">수정</button>
                    <button type="button" onclick="window.location.href='회원탈퇴.jsp'">회원탈퇴</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
