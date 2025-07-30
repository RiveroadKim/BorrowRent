<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="inquiry.InquiryDao, inquiry.Inquiry" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발로렌트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
    <style>
        .inquiry-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .inquiry-header h2 {
            margin: 0;
        }
        .inquiry-btn {
            background-color: black;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }
        .inquiry-btn:hover {
            background-color: #333;
        }
        .inquiry-table a {
            color: inherit;
            text-decoration: none;
        }
        .inquiry-table a:hover {
            text-decoration: underline;
        }
    </style>
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

        <div class="inquiry-container">
            <div class="inquiry-header">
                <h2>문의 내역확인</h2>
                <button onclick="location.href='${pageContext.request.contextPath}/template/inquiry_write.jsp'" class="inquiry-btn">문의하기</button>
            </div>
            <table class="inquiry-table">
                <tr>
                    <th>제목</th>
                    <th>날짜</th>
                    <th>상태</th>
                </tr>
                <%
                    String userEmail = (String) session.getAttribute("userEmail");
                    if (userEmail != null) {
                        InquiryDao inquiryDao = new InquiryDao();
                        List<Inquiry> inquiries;

                        if (userEmail.contains("admin")) {
                            inquiries = inquiryDao.getAllInquiries();
                        } else {
                            inquiries = inquiryDao.getInquiriesByUserEmail(userEmail);
                        }

                        for (Inquiry inquiry : inquiries) {
                            String inquiryUserEmail = inquiry.getUserEmail() != null ? inquiry.getUserEmail() : "";
                %>
                <tr>
                    <td><a href="${pageContext.request.contextPath}/template/inquiry_detail.jsp?title=<%= java.net.URLEncoder.encode(inquiry.getTitle(), "UTF-8") %>&userEmail=<%= java.net.URLEncoder.encode(inquiryUserEmail, "UTF-8") %>"><%= inquiry.getTitle() %></a></td>
                    <td><%= inquiry.getDate() %></td>
                    <td><%= inquiry.getAnswer() %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3">로그인이 필요합니다.</td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
