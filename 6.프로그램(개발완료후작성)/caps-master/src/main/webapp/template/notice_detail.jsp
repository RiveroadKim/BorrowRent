<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="notice.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />

    <%
        String title = request.getParameter("title");
        NoticeDao noticeDao = new NoticeDao();
        Notice notice = noticeDao.getNoticeByTitle(title);
        String shortUserEmail = notice.getUserEmail().length() > 5 ? notice.getUserEmail().substring(0, 5) : notice.getUserEmail();
    %>

    <div class="notice-detail-container">
        <h2><%= notice.getTitle() %></h2>
        <div class="notice-meta">
            <p>작성자: <%= shortUserEmail %></p>
            <p>등록일: <%= notice.getDate() %></p>
        </div>
        <div class="content">
            <%= notice.getContent() %>
        </div>
    </div>
</body>
</html>
