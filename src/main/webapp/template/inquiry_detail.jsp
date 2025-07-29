<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="inquiry.InquiryDao, inquiry.Inquiry" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
    <style>
        .inquiry-detail-container {
            width: 80%;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            position: relative;
        }
        .inquiry-detail-container h2 {
            font-size: 24px;
            color: #333333;
            border-bottom: 2px solid #333333;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .inquiry-meta {
            display: flex;
            justify-content: flex-end;
            font-size: 16px;
            color: #666666;
            margin-bottom: 20px;
        }
        .inquiry-meta p {
            margin-left: 20px;
        }
        .answer {
            color: blue;
            font-weight: bold;
        }
        .inquiry-detail-container .content {
            font-size: 16px;
            color: #333333;
            line-height: 1.6;
        }
        .response-content {
            font-size: 16px;
            color: #333333;
            line-height: 1.6;
            background-color: #f9f9f9;
            padding: 10px;
            margin-top: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
        }
        .answer-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #000;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        .answer-btn:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />
    <div class="inquiry-detail-container">
        <%
            String title = request.getParameter("title");
            String userEmail = (String) session.getAttribute("userEmail");
            String inquiryUserEmail = request.getParameter("userEmail");
            Inquiry inquiry = null;

            if (title != null && userEmail != null) {
                InquiryDao inquiryDao = new InquiryDao();

                if (userEmail.contains("admin")) {
                    inquiry = inquiryDao.getInquiryDetailForAdmin(title);
                } else {
                    inquiry = inquiryDao.getInquiryDetail(inquiryUserEmail, title);
                }

                if (inquiry != null) {
        %>
        <h2><%= inquiry.getTitle() %></h2>
        <div class="inquiry-meta">
            <p>작성자: <%= inquiry.getUserEmail() %></p>
            <p>등록일: <%= inquiry.getDate() %></p>
            <p class="answer">상태: <%= inquiry.getAnswer() %></p>
        </div>
        <div class="content">
            <p><%= inquiry.getContent() %></p>
        </div>
        <%
                    if (inquiry.getResponse() != null && !inquiry.getResponse().isEmpty()) {
        %>
        <div class="response-content">
            <h3>답변:</h3>
            <p><%= inquiry.getResponse() %></p>
        </div>
        <%
                    }

                    if (userEmail.contains("admin")) {
        %>
        <button class="answer-btn" onclick="location.href='inquiryAnswer.jsp?userEmail=<%= inquiry.getUserEmail() %>&title=<%= java.net.URLEncoder.encode(inquiry.getTitle(), "UTF-8") %>'">답변 작성</button>
        <%
                    }
                } else {
        %>
        <p>문의 내용을 찾을 수 없습니다.</p>
        <%
                }
            } else {
        %>
        <p>잘못된 접근입니다.</p>
        <%
            }
        %>
    </div>
</body>
</html>
