<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userBirth" />
<jsp:setProperty name="user" property="userPnum" />
<jsp:setProperty name="user" property="userAddress" />
<jsp:setProperty name="user" property="userStudent" />

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>발로렌트</title>
    </head>
<body>
    <%
		String userEmail = null;
		if(session.getAttribute("userEmail") != null){
			userEmail = (String) session.getAttribute("userEmail");
		}
		
		if (userEmail != null) {
	        PrintWriter script = response.getWriter();
	        script.println("<script>");
	        script.println("alert('이미 로그인이 되어있습니다.')");
	        script.println("location.href = '" + request.getContextPath() + "/template/mainpage.jsp';");
	        script.println("</script>");
		}
		
        if (user.getUserEmail() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null ||
            user.getUserBirth() == null || user.getUserPnum() == null || user.getUserAddress() == null || user.getUserStudent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            UserDao userDAO = new UserDao();
            int result = userDAO.join(user);
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 존재하는 계정입니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = '" + request.getContextPath() + "/template/login.jsp';");
                script.println("</script>");
            }
        }
    %>
</body>
</html>
