<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="payment.Order_form_Dao" %>
<%@ page import="payment.Order_form_lap" %>
<%@ page import="payment.Order_form_tp" %>
<%@ page import="items.Items_laptop_Dao" %>
<%@ page import="items.Items_tp_Dao" %>

<%
    String orderID = request.getParameter("orderID");

    if (orderID == null || orderID.isEmpty()) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    Order_form_Dao orderDao = new Order_form_Dao();
    Order_form_lap orderLap = orderDao.getLaptopOrderById(orderID);
    Order_form_tp orderTp = orderDao.getTpOrderById(orderID);
    String itemName = "";
    String orderNow = "";
    String orderAdd1 = "";
    String orderAdd2 = "";
    int orderTotal = 0;

    if (orderLap != null) {
        Items_laptop_Dao laptopDao = new Items_laptop_Dao();
        itemName = laptopDao.getItemById(orderLap.getLapID()).getLapName();
        orderNow = orderLap.getOrderNow();
        orderAdd1 = orderLap.getOrderAdd1();
        orderAdd2 = orderLap.getOrderAdd2();
        orderTotal = orderLap.getOrderTotal();
    } else if (orderTp != null) {
        Items_tp_Dao tpDao = new Items_tp_Dao();
        itemName = tpDao.getItemById(orderTp.getTpID()).getTpName();
        orderNow = orderTp.getOrderNow();
        orderAdd1 = orderTp.getOrderAdd1();
        orderAdd2 = orderTp.getOrderAdd2();
        orderTotal = orderTp.getOrderTotal();
    } else {
        out.println("<script>alert('주문 정보를 찾을 수 없습니다.'); history.back();</script>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 완료</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after?after">
</head>
<body class="payment-complete-body">
	<button class="home-button" onclick="window.location.href='${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/template/mainpage.jsp'">홈페이지로 돌아가기</button>
    <div class="payment-complete-container">
        <div class="payment-complete-header">
            <img src="${pageContext.request.contextPath}/static/img/complete.png" alt="완료 아이콘" class="payment-complete-icon">
            <h1>결제가 정상적으로 이루어졌습니다.</h1>
        </div>
        <div class="payment-complete-details">
            <div class="payment-complete-row">
                <span>일시</span>
                <span><%= orderNow %></span>
            </div>
            <div class="payment-complete-row">
                <span>제품명</span>
                <span><%= itemName %></span>
            </div>
            <div class="payment-complete-row">
                <span>결제번호</span>
                <span><%= orderID %></span>
            </div>
            <div class="payment-complete-row">
                <span>배송지</span>
                <span><%= orderAdd1 %> <%= orderAdd2 %></span>
            </div>
            <div class="payment-complete-details-box">
                <div class="payment-complete-subrow">
                    <span>최종결제금액</span>
                    <span><%= orderTotal %>원</span>
                </div>
            </div>
            <div class="payment-complete-footer">
                <span>현금 영수증 발행</span>
            </div>
        </div>
    </div>
</body>
</html>
