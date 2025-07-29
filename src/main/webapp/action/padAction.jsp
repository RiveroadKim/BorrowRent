<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDao" %>
<%@ page import="items.Items_tp" %>
<%@ page import="items.Items_tp_Dao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="items.Tp_img" %>
<%@ page import="items.Tp_img_Dao" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userEmail" />

<jsp:useBean id="items" class="items.Items_tp" scope="page" />
<jsp:setProperty name="items" property="tpID" />
<jsp:setProperty name="items" property="tpName" />
<jsp:setProperty name="items" property="tpQuan" />
<jsp:setProperty name="items" property="tpYear" />
<jsp:setProperty name="items" property="tpPrice" />
<jsp:setProperty name="items" property="tpBrand" />
<jsp:setProperty name="items" property="tpModel" />
<jsp:setProperty name="items" property="tpColor" />
<jsp:setProperty name="items" property="tpMemory" />
<jsp:setProperty name="items" property="tpAvailable" />
<jsp:setProperty name="items" property="userEmail" />
<jsp:setProperty name="items" property="userName" />

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
        if (session.getAttribute("userEmail") != null) {
            userEmail = (String) session.getAttribute("userEmail");
        }

        if (userEmail == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('로그인을 하세요.')");
            script.println("location.href = '" + request.getContextPath() + "/template/login.jsp';");
            script.println("</script>");
        } else {
            // items 객체에 userEmail 설정
            items.setUserEmail(userEmail);
			
            // userEmail을 통해 userName을 가져오기
            UserDao userDao = new UserDao();
            User currentUser = userDao.getUserByEmail(userEmail);
            if (currentUser != null) {
                items.setUserName(currentUser.getUserName());
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('유저 정보를 가져오지 못했습니다.')");
                script.println("history.back()");
                script.println("</script>");
            }

            // 이미지 업로드 처리
            String savePath = getServletContext().getRealPath("/") + "uploads_tp";
            File uploadDir = new File(savePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            int maxFileSize = 10 * 1024 * 1024; // 10MB
            String encoding = "UTF-8";
            MultipartRequest multi = null;

            try {
                multi = new MultipartRequest(request, savePath, maxFileSize, encoding, new DefaultFileRenamePolicy());
            } catch (Exception e) {
                e.printStackTrace();
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('파일 업로드 실패')");
                script.println("history.back()");
                script.println("</script>");
                return;
            }

            // 폼 필드 값 가져오기
            String tpName = multi.getParameter("tpName");
            int tpQuan = Integer.parseInt(multi.getParameter("tpQuan"));
            int tpYear = Integer.parseInt(multi.getParameter("tpYear"));
            int tpPrice = Integer.parseInt(multi.getParameter("tpPrice"));
            String tpBrand = multi.getParameter("tpBrand");
            String tpModel = multi.getParameter("tpModel");
            String tpColor = multi.getParameter("tpColor");
            String tpMemory = multi.getParameter("tpMemory");

            items.setTpName(tpName);
            items.setTpQuan(tpQuan);
            items.setTpYear(tpYear);
            items.setTpPrice(tpPrice);
            items.setTpBrand(tpBrand);
            items.setTpModel(tpModel);
            items.setTpColor(tpColor);
            items.setTpMemory(tpMemory);

            // 파일 업로드 처리
            String fileName = multi.getFilesystemName("tpImage");

            if (tpName == null || tpQuan <= 0 || tpYear <= 0 || tpPrice <= 0 ||
                tpBrand == null || tpModel == null || tpColor == null || tpMemory == null) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안 된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                Items_tp_Dao tpDAO = new Items_tp_Dao();
                int result = tpDAO.write(tpName, tpQuan, tpYear, tpPrice, tpBrand, tpModel, tpColor, tpMemory, items.getUserName(), items.getUserEmail());
                if (result == -1) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('패드 등록 요청 실패')");
                    script.println("history.back()");
                    script.println("</script>");
                } else {
                    // 새로 생성된 tpID를 가져오기
                    int tpID = tpDAO.getLastInsertedID();

                    // 이미지 정보 저장
                    if (fileName != null) {
                        Tp_img_Dao imgDao = new Tp_img_Dao();
                        int imgResult = imgDao.upload(fileName, tpID, savePath + File.separator + fileName);
                        if (imgResult == -1) {
                            PrintWriter script = response.getWriter();
                            script.println("<script>");
                            script.println("alert('이미지 업로드 실패')");
                            script.println("history.back()");
                            script.println("</script>");
                        } else {
                            PrintWriter script = response.getWriter();
                            script.println("<script>");
                            script.println("alert('패드 등록 요청 성공')");
                            script.println("location.href = '" + request.getContextPath() + "/template/mypages/myrentlist.jsp';");
                            script.println("</script>");
                        }
                    } else {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('이미지 파일이 없습니다.')");
                        script.println("history.back()");
                        script.println("</script>");
                    }
                }
            }
        }
    %>
</body>
</html>
