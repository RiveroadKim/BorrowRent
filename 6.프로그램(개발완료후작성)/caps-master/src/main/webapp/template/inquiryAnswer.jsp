<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="inquiry.InquiryDao" %>
<%
    String adminEmail = (String) session.getAttribute("userEmail");
    if (adminEmail == null || !adminEmail.contains("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
	
    request.setCharacterEncoding("UTF-8");
    String userEmail = request.getParameter("userEmail");
    String title = request.getParameter("title");
    String responseContent = request.getParameter("response");

    if (responseContent != null) {
        InquiryDao inquiryDao = new InquiryDao();
        boolean success = inquiryDao.updateInquiryResponse(userEmail, title, responseContent);

        if (success) {
            out.println("<script>alert('답변이 성공적으로 등록되었습니다.'); location.href='mypages/myinquiry.jsp';</script>");
        } else {
            out.println("<script>alert('답변 등록에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>답변하기</title>
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
        <h2>답변하기</h2>
        <form action="inquiryAnswer.jsp" method="post">
            <input type="hidden" name="userEmail" value="<%= request.getParameter("userEmail") %>">
            <input type="hidden" name="title" value="<%= request.getParameter("title") %>">
            <div class="input-group">
                <label for="response">답변:</label>
                <textarea id="response" name="response" required></textarea>
            </div>
            <button type="submit" class="btn">답변 완료</button>
        </form>
    </div>
</body>
</html>
