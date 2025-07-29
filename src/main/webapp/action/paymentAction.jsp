<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="payment.Order_form_Dao" %>
<%@ page import="items.Items_laptop_Dao" %>
<%@ page import="items.Items_tp_Dao" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
            // 폼 필드 값 가져오기
            String type = request.getParameter("type");
            int id = Integer.parseInt(request.getParameter("id"));
            int orderQuan = Integer.parseInt(request.getParameter("orderQuan"));
            String orderRent = request.getParameter("orderRent");
            String orderName = request.getParameter("orderName");
            String orderEmail = request.getParameter("orderEmail");
            String orderPnum = request.getParameter("orderPnum");
            String orderAdd1 = request.getParameter("orderAdd1");
            String orderAdd2 = request.getParameter("orderAdd2");
            String orderReq = request.getParameter("orderReq");
            int price = Integer.parseInt(request.getParameter("price"));

            Order_form_Dao orderDao = new Order_form_Dao();
            boolean isOrderSuccessful = false;
            int itemQuantity = 0;
            int remainingQuantity = 0;
            String itemName = "";
            String orderID = "";

            if ("laptop".equals(type)) {
                Items_laptop_Dao laptopDao = new Items_laptop_Dao();
                if (laptopDao.isValidLaptopID(id)) {
                    int itemPrice = laptopDao.getItemById(id).getLapPrice();
                    itemQuantity = laptopDao.getItemById(id).getLapQuan();
                    itemName = laptopDao.getItemById(id).getLapName();

                    if (orderQuan > itemQuantity) {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('수량을 초과하였습니다.')");
                        script.println("history.back()");
                        script.println("</script>");
                        return;
                    } else {
                        int result = orderDao.uploadLaptopOrder(orderQuan, orderRent, orderName, orderEmail, orderPnum, orderAdd1, orderAdd2, orderReq, itemPrice, userEmail, id);
                        if (result != -1) {
                            isOrderSuccessful = true;
                            remainingQuantity = itemQuantity - orderQuan;
                            laptopDao.updateQuantity(id, remainingQuantity);
                            orderID = orderDao.getLastInsertedLaptopOrderID();
                        }
                    }
                }
            } else if ("pad".equals(type)) {
                Items_tp_Dao tpDao = new Items_tp_Dao();
                if (tpDao.isValidTpID(id)) {
                    int itemPrice = tpDao.getItemById(id).getTpPrice();
                    itemQuantity = tpDao.getItemById(id).getTpQuan();
                    itemName = tpDao.getItemById(id).getTpName();

                    if (orderQuan > itemQuantity) {
                        PrintWriter script = response.getWriter();
                        script.println("<script>");
                        script.println("alert('수량을 초과하였습니다.')");
                        script.println("history.back()");
                        script.println("</script>");
                        return;
                    } else {
                        int result = orderDao.uploadTpOrder(orderQuan, orderRent, orderName, orderEmail, orderPnum, orderAdd1, orderAdd2, orderReq, itemPrice, userEmail, id);
                        if (result != -1) {
                            isOrderSuccessful = true;
                            remainingQuantity = itemQuantity - orderQuan;
                            tpDao.updateQuantity(id, remainingQuantity);
                            orderID = orderDao.getLastInsertedTpOrderID();
                        }
                    }
                }
            }

            if (isOrderSuccessful) {
            	PrintWriter script = response.getWriter();
                Timestamp orderNow = new Timestamp(System.currentTimeMillis());
			
                // 세션에 필요한 데이터 저장
                session.setAttribute("orderNow", orderNow);
                session.setAttribute("itemName", itemName);
                session.setAttribute("orderID", orderID);
                session.setAttribute("orderAdd1", orderAdd1);
                session.setAttribute("orderAdd2", orderAdd2);
                session.setAttribute("orderTotal", orderQuan * Integer.parseInt(orderRent) * price);

                // 결제 완료 페이지로 리디렉션
               
                script.println("<script>");
                script.println("alert('결제가 성공적으로 이루어졌습니다.')");
                script.println("location.href = '" + request.getContextPath() + "/template/payment-complete.jsp?orderID=" + orderID + "';");
                script.println("</script>");
                
            } else {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('주문 요청 실패')");
                script.println("history.back()");
                script.println("</script>");
            }
        }
    %>
</body>
</html>
