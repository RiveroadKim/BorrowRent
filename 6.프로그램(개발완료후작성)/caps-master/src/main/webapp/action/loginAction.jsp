<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPassword" />
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
        UserDao userDAO = new UserDao();
        int result = userDAO.login(user.getUserEmail(), user.getUserPassword());
        if (result == 1) {
        	session.setAttribute("userEmail", user.getUserEmail());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = '" + request.getContextPath() + "/template/mainpage.jsp';");
            script.println("</script>");
        } else if (result == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀립니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('존재하지 않는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else if (result == -2) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데베오류.')");
            script.println("history.back()");
            script.println("</script>");
        }
    %>
</body>
</html>
