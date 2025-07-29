<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발로렌트</title>
</head>
<body>
    <%	
       session.invalidate();
    %>
    
    <script>
        // 로그아웃 완료 메시지를 alert로 표시합니다.
        alert("로그아웃이 성공적으로 완료되었습니다.");
        
        // login.jsp 페이지로 이동합니다.
        window.location.href = "<%= request.getContextPath() %>/template/mainpage.jsp";
    </script>
</body>
</html>
