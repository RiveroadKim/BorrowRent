<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, payment.*, java.sql.Timestamp" %>
<%@ page import="alarm.*, alarm.AlarmDao, alarm.Alarm" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알림 내역</title>
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

        <div class="notifications-container">
            <h2>알림 확인</h2>
            <table class="notifications-table">
                <%
                    String userEmail = (String) session.getAttribute("userEmail");
                    if (userEmail != null) {
                        // 알람 DAO 인스턴스 생성 및 공지사항과 가격 설정 알림 가져오기
                        AlarmDao alarmDao = new AlarmDao();
                        List<Alarm> alarms = alarmDao.getAlarmsByUserEmail(userEmail);
                        
                        for (Alarm alarm : alarms) {
                            out.println("<tr><td>" + alarm.getTitle().replace("${pageContext.request.contextPath}", request.getContextPath()) + "</td></tr>");
                        }
                        
                        // 주문 DAO 인스턴스 생성 및 대여 내역 알림 가져오기
                        Order_form_Dao orderDao = new Order_form_Dao();
                        List<Order_form_lap> laptopOrders = orderDao.getAllLaptopOrdersByUserEmail(userEmail);
                        List<Order_form_tp> tpOrders = orderDao.getAllTpOrdersByUserEmail(userEmail);

                        for (Order_form_lap order : laptopOrders) {
                            String lapName = order.getLapName();
                            Timestamp orderReturn = Timestamp.valueOf(order.getOrderReturn());
                            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                            long diff = orderReturn.getTime() - currentTime.getTime();
                            long diffDays = diff / (1000 * 60 * 60 * 24);

                            out.println("<tr><td>기기 '" + lapName + "' 의 반납일자가 " + diffDays + " 일 남았습니다.</td></tr>");
                        }

                        for (Order_form_tp order : tpOrders) {
                            String tpName = order.getTpName();
                            Timestamp orderReturn = Timestamp.valueOf(order.getOrderReturn());
                            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                            long diff = orderReturn.getTime() - currentTime.getTime();
                            long diffDays = diff / (1000 * 60 * 60 * 24);

                            out.println("<tr><td>기기 '" + tpName + "' 의 반납일자가 " + diffDays + " 일 남았습니다.</td></tr>");
                        }
                    } else {
                        out.println("<tr><td>로그인이 필요합니다.</td></tr>");
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
