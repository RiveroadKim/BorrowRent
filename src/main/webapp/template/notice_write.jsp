<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, notice.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 작성</title>
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
        <h2>공지사항 작성</h2>
        <form method="post" action="notice_write.jsp">
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
    <%
        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String userEmail = (String) session.getAttribute("userEmail");

        if (title != null && content != null && userEmail != null) {
            NoticeDao noticeDao = new NoticeDao();
            noticeDao.addNotice(title, content, userEmail);
            response.sendRedirect(request.getContextPath() + "/template/noticeboard.jsp");
        }
    %>
</body>
</html>
