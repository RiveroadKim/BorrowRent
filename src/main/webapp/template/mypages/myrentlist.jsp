<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="items.Items_laptop_Dao" %>
<%@ page import="items.Items_tp_Dao" %>
<%@ page import="items.Laptop_img_Dao" %>
<%@ page import="items.Tp_img_Dao" %>
<%@ page import="items.Items_laptop" %>
<%@ page import="items.Items_tp" %>
<%@ page import="items.Laptop_img" %>
<%@ page import="items.Tp_img" %>
<%@ page import="payment.Order_form_Dao" %>
<%@ page import="payment.Order_form_lap" %>
<%@ page import="payment.Order_form_tp" %>

<%
    Items_laptop_Dao laptopDao = new Items_laptop_Dao();
    Items_tp_Dao tpDao = new Items_tp_Dao();
    Laptop_img_Dao laptopImgDao = new Laptop_img_Dao();
    Tp_img_Dao tpImgDao = new Tp_img_Dao();
    Order_form_Dao orderDao = new Order_form_Dao();

    String userEmail = (String) session.getAttribute("userEmail");

    List<Items_laptop> laptopList = laptopDao.getItemsByUserEmail(userEmail);
    List<Items_tp> tpList = tpDao.getItemsByUserEmail(userEmail);
    List<Order_form_lap> borrowedLaptopOrders = orderDao.getBorrowedLaptopOrdersByUserEmail(userEmail);
    List<Order_form_tp> borrowedTpOrders = orderDao.getBorrowedTpOrdersByUserEmail(userEmail);
    List<Order_form_lap> lentLaptopOrders = orderDao.getLentLaptopOrdersByUserEmail(userEmail);
    List<Order_form_tp> lentTpOrders = orderDao.getLentTpOrdersByUserEmail(userEmail);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발로렌트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
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

        <div class="rental-container">
            <h2>대여한 물품</h2>
            <table class="rental-table">
                <thead>
                    <tr>
                        <th>사진</th>
                        <th>이름</th>
                        <th>아이템 주인의 이메일</th>
                        <th>반납일</th>
                    </tr>
                </thead>
                <tbody>
    <%
        for (Order_form_lap order : borrowedLaptopOrders) {
            Items_laptop laptop = laptopDao.getItemById(order.getLapID());
            Laptop_img laptopImg = laptopImgDao.getImageByLapID(laptop.getLapID());
    %>
        <tr>
            <td><img src="<%= request.getContextPath() + "/uploads_laptop/" + laptopImg.getLap_img_Name() %>" alt="<%= laptop.getLapName() %>"></td>
            <td><%= laptop.getLapName() %></td>
            <td><%= laptop.getUserEmail() %></td> <!-- 주인의 이메일 -->
            <td><%= order.getOrderReturn() %></td>
        </tr>
    <%
        }

        for (Order_form_tp order : borrowedTpOrders) {
            Items_tp tp = tpDao.getItemById(order.getTpID());
            Tp_img tpImg = tpImgDao.getImageByTpID(tp.getTpID());
    %>
        <tr>
            <td><img src="<%= request.getContextPath() + "/uploads_tp/" + tpImg.getTp_img_Name() %>" alt="<%= tp.getTpName() %>"></td>
            <td><%= tp.getTpName() %></td>
            <td><%= tp.getUserEmail() %></td> <!-- 주인의 이메일 -->
            <td><%= order.getOrderReturn() %></td>
        </tr>
    <%
        }
    %>
</tbody>

            </table>

            <h2>내 물품을 빌려준 리스트</h2>
            <table class="rental-table">
                <thead>
                    <tr>
                        <th>사진</th>
                        <th>이름</th>
                        <th>사용자 이메일</th>
                        <th>반납일</th>
                    </tr>
                </thead>
                <tbody>
    <%
        for (Order_form_lap order : lentLaptopOrders) {
            Items_laptop laptop = laptopDao.getItemById(order.getLapID());
            Laptop_img laptopImg = laptopImgDao.getImageByLapID(laptop.getLapID());
    %>
        <tr>
            <td><img src="<%= request.getContextPath() + "/uploads_laptop/" + laptopImg.getLap_img_Name() %>" alt="<%= laptop.getLapName() %>"></td>
            <td><%= laptop.getLapName() %></td>
            <td><%= order.getOrderEmail() %></td>
            <td><%= order.getOrderReturn() %></td>
        </tr>
    <%
        }

        for (Order_form_tp order : lentTpOrders) {
            Items_tp tp = tpDao.getItemById(order.getTpID());
            Tp_img tpImg = tpImgDao.getImageByTpID(tp.getTpID());
    %>
        <tr>
            <td><img src="<%= request.getContextPath() + "/uploads_tp/" + tpImg.getTp_img_Name() %>" alt="<%= tp.getTpName() %>"></td>
            <td><%= tp.getTpName() %></td>
            <td><%= order.getOrderEmail() %></td>
            <td><%= order.getOrderReturn() %></td>
        </tr>
    <%
        }
    %>
</tbody>

            </table>

            <h2>대여등록 리스트</h2>
            <div class="register-button-container">
                <a href="${pageContext.request.contextPath}/template/registerRent.jsp">
                    <button class="register-button">물품 등록</button>
                </a>
            </div>
            <table class="rental-table">
                <%
                    for (Items_laptop laptop : laptopList) {
                        Laptop_img laptopImg = laptopImgDao.getImageByLapID(laptop.getLapID());
                %>
                    <tr>
                        <td><img src="<%= request.getContextPath() + "/uploads_laptop/" + laptopImg.getLap_img_Name() %>" alt="<%= laptop.getLapName() %>"></td>
                        <td><a href="${pageContext.request.contextPath}/template/itempage.jsp?type=laptop&id=<%= laptop.getLapID() %>"><%= laptop.getLapName() %></a></td>
                    </tr>
                <%
                    }

                    for (Items_tp tp : tpList) {
                        Tp_img tpImg = tpImgDao.getImageByTpID(tp.getTpID());
                %>
                    <tr>
                        <td><img src="<%= request.getContextPath() + "/uploads_tp/" + tpImg.getTp_img_Name() %>" alt="<%= tp.getTpName() %>"></td>
                        <td><a href="${pageContext.request.contextPath}/template/itempage.jsp?type=pad&id=<%= tp.getTpID() %>"><%= tp.getTpName() %></a></td>
                    </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
