<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="inquiry.InquiryDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
	
    request.setCharacterEncoding("UTF-8");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

    if (title != null && content != null) {
        InquiryDao inquiryDao = new InquiryDao();
        boolean success = inquiryDao.insertInquiry(userEmail, title, content, date);
        
        if (success) {
            out.println("<script>alert('문의가 성공적으로 등록되었습니다.'); location.href='mypages/myinquiry.jsp';</script>");
        } else {
            out.println("<script>alert('문의 등록에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의하기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
    <style>
        .form-container {
            width: 50%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .form-container h2 {
            font-size: 24px;
            color: #333333;
            border-bottom: 2px solid #333333;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .form-container .input-group {
            margin-bottom: 15px;
        }
        .form-container label {
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
            color: #333;
        }
        .form-container input[type="text"],
        .form-container textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .form-container textarea {
            height: 150px;
        }
        .form-container .btn {
            width: 100%;
            padding: 10px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
        }
        .form-container .btn:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />

    <div class="form-container">
        <h2>문의하기</h2>
        <form action="inquiry_write.jsp" method="post">
            <div class="input-group">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="input-group">
                <label for="content">내용:</label>
                <textarea id="content" name="content" required></textarea>
            </div>
            <button type="submit" class="btn">작성 완료</button>
        </form>
    </div>
</body>
</html>
