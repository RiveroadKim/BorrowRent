<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.User" %>
<%@ page import="user.UserDao" %>
<%@ page import="items.Items_laptop" %>
<%@ page import="items.Items_laptop_Dao" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="items.Laptop_img" %>
<%@ page import="items.Laptop_img_Dao" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userEmail" />

<jsp:useBean id="items" class="items.Items_laptop" scope="page" />
<jsp:setProperty name="items" property="lapID" />
<jsp:setProperty name="items" property="lapName" />
<jsp:setProperty name="items" property="lapQuan" />
<jsp:setProperty name="items" property="lapYear" />
<jsp:setProperty name="items" property="lapPrice" />
<jsp:setProperty name="items" property="lapBrand" />
<jsp:setProperty name="items" property="lapModel" />
<jsp:setProperty name="items" property="lapColor" />
<jsp:setProperty name="items" property="lapMemory" />
<jsp:setProperty name="items" property="lapGraphic" />
<jsp:setProperty name="items" property="lapOS" />
<jsp:setProperty name="items" property="lapCPU" />
<jsp:setProperty name="items" property="lapAvailable" />
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
            String savePath = getServletContext().getRealPath("/") + "uploads_laptop";
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
            String lapName = multi.getParameter("lapName");
            int lapQuan = Integer.parseInt(multi.getParameter("lapQuan"));
            int lapYear = Integer.parseInt(multi.getParameter("lapYear"));
            int lapPrice = Integer.parseInt(multi.getParameter("lapPrice"));
            String lapBrand = multi.getParameter("lapBrand");
            String lapModel = multi.getParameter("lapModel");
            String lapColor = multi.getParameter("lapColor");
            String lapMemory = multi.getParameter("lapMemory");
            String lapGraphic = multi.getParameter("lapGraphic");
            String lapOS = multi.getParameter("lapOS");
            String lapCPU = multi.getParameter("lapCPU");

            items.setLapName(lapName);
            items.setLapQuan(lapQuan);
            items.setLapYear(lapYear);
            items.setLapPrice(lapPrice);
            items.setLapBrand(lapBrand);
            items.setLapModel(lapModel);
            items.setLapColor(lapColor);
            items.setLapMemory(lapMemory);
            items.setLapGraphic(lapGraphic);
            items.setLapOS(lapOS);
            items.setLapCPU(lapCPU);

            // 파일 업로드 처리
            String fileName = multi.getFilesystemName("laptopImage");

            if (lapName == null || lapQuan <= 0 || lapYear <= 0 || lapPrice <= 0 ||
                lapBrand == null || lapModel == null || lapColor == null || lapMemory == null ||
                lapGraphic == null || lapOS == null || lapCPU == null) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안 된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
            } else {
                Items_laptop_Dao lapDAO = new Items_laptop_Dao();
                int result = lapDAO.write(lapName, lapQuan, lapYear, lapPrice, lapBrand, lapModel, lapColor, lapMemory, lapGraphic, lapOS, lapCPU, items.getUserName(), items.getUserEmail());
                if (result == -1) {
                    PrintWriter script = response.getWriter();
                    script.println("<script>");
                    script.println("alert('노트북 등록 요청 실패')");
                    script.println("history.back()");
                    script.println("</script>");
                } else {
                    // 새로 생성된 lapID를 가져오기
                    int lapID = lapDAO.getLastInsertedID();

                    // 이미지 정보 저장
                    if (fileName != null) {
                        Laptop_img_Dao imgDao = new Laptop_img_Dao();
                        int imgResult = imgDao.upload(fileName, lapID, savePath + File.separator + fileName);
                        if (imgResult == -1) {
                            PrintWriter script = response.getWriter();
                            script.println("<script>");
                            script.println("alert('이미지 업로드 실패')");
                            script.println("history.back()");
                            script.println("</script>");
                        } else {
                            PrintWriter script = response.getWriter();
                            script.println("<script>");
                            script.println("alert('노트북 등록 요청 성공')");
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
