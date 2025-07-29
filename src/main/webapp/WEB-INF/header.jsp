<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%
    String userEmail = null;
    if (session.getAttribute("userEmail") != null){
        userEmail = (String) session.getAttribute("userEmail");
    }
%>
<div class="header">
    <div class="logo"><a href="${pageContext.request.contextPath}/template/mainpage.jsp">발로렌트</a></div>
    <div class="nav">
        <% if (userEmail == null) { %>
            <div><a href="${pageContext.request.contextPath}/template/signup.jsp"><button class="header-btn">회원가입</button></a></div>
            <div><a href="${pageContext.request.contextPath}/template/login.jsp"><button class="header-btn">로그인</button></a></div>
        <% } else { %>
            <div><a href="${pageContext.request.contextPath}/template/mypages/myinfo.jsp"><button class="header-btn">마이페이지</button></a></div>
            <div><a href="${pageContext.request.contextPath}/action/logoutAction.jsp"><button class="header-btn">로그아웃</button></a></div>
        <% } %>
    </div>
</div>

<div class="footer">
    <a href="${pageContext.request.contextPath}/template/noticeboard.jsp">공지사항</a> |
    <a href="${pageContext.request.contextPath}/template/footers/terms.jsp">이용약관</a> |
    <a href="${pageContext.request.contextPath}/template/footers/privacy.jsp">개인정보 취급방침</a> |
    <a href="${pageContext.request.contextPath}/template/mypages/myinquiry.jsp">문의하기</a>
</div>
