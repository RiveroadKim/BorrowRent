<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, notice.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />

    <section class="noticeboard">
        <div class="noticeboard-title">
            <div class="noticeboard-container">
                <h3>공지사항</h3>
            </div>
        </div>

        <!-- board search area -->
        <div id="board-search">
            <div class="noticeboard-container">
                <div class="search-window">
                    <form action="noticeboard.jsp" method="get">
                        <div class="search-wrap">
                            <label for="search" class="noticeboard-blind">공지사항 내용 검색</label>
                            <input id="search" type="search" name="search" placeholder="검색어를 입력해주세요." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                            <button type="submit" class="noticeboard-btn noticeboard-btn-dark">검색</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 작성 버튼 -->
        <%
            String userEmail = (String) session.getAttribute("userEmail");
            if (userEmail != null && userEmail.startsWith("admin")) {
		        %>
		        <div class="noticeboard-container" style="text-align: right; margin-bottom: 10px;">
		            <button type="button" class="noticeboard-btn noticeboard-btn-dark" onclick="location.href='notice_write.jsp'">작성</button>
		        </div>
		        <%
            }
        %>

        <!-- board list area -->
        <div id="board-list">
            <div class="noticeboard-container">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-userName">작성자</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-date">등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String searchKeyword = request.getParameter("search");
                            NoticeDao noticeDao = new NoticeDao();
                            List<Notice> notices;
                            if (searchKeyword != null && !searchKeyword.isEmpty()) {
                                notices = noticeDao.getNoticesByTitle(searchKeyword);
                            } else {
                                notices = noticeDao.getAllNotices();
                            }
                            int number = 1;
                            for (Notice notice : notices) {
                                String email = notice.getUserEmail();
                                String shortEmail = email.length() > 5 ? email.substring(0, 5) : email;
                        %>
                        <tr>
                            <td><%= number++ %></td>
                            <td><%= shortEmail %></td>
                            <td><a href="notice_detail.jsp?title=<%= java.net.URLEncoder.encode(notice.getTitle(), "UTF-8") %>"><%= notice.getTitle() %></a></td>
                            <td><%= notice.getDate() %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</body>
</html>
