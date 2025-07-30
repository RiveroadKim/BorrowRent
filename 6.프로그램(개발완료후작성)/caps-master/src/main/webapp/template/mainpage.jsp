<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="items.Items_laptop_Dao" %>
<%@ page import="items.Items_tp_Dao" %>
<%@ page import="items.Items_laptop" %>
<%@ page import="items.Items_tp" %>
<%@ page import="notice.NoticeDao, notice.Notice" %>
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
    
    <div class="main-container">
        <div class="main-section">
            <a href="${pageContext.request.contextPath}/template/laptop.jsp">
                <img src="${pageContext.request.contextPath}/static/img/laptop.jpg" alt="노트북 대여">
                <p>노트북 대여</p>
            </a>
        </div>
        <div class="main-section">
            <a href="${pageContext.request.contextPath}/template/tablet.jsp">
                <img src="${pageContext.request.contextPath}/static/img/tablet.jpg" alt="패드/탭 대여">
                <p>패드/탭 대여</p>
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="left">
            <table class="common-table">
                <thead>
                    <tr>
                        <th>대여 UP! 리스트</th>
                        <th>월간 대여비</th>
                        <th>판매자</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Items_laptop_Dao laptopDao = new Items_laptop_Dao();
                        Items_tp_Dao tpDao = new Items_tp_Dao();
                        List<Items_laptop> laptopList = laptopDao.getRecentItems(5);
                        List<Items_tp> tpList = tpDao.getRecentItems(5);

                        List<Object> combinedList = new ArrayList<>();
                        combinedList.addAll(laptopList);
                        combinedList.addAll(tpList);
                        combinedList.sort((o1, o2) -> {
                            if (o1 instanceof Items_laptop && o2 instanceof Items_laptop) {
                                return ((Items_laptop) o2).getLapID() - ((Items_laptop) o1).getLapID();
                            } else if (o1 instanceof Items_tp && o2 instanceof Items_tp) {
                                return ((Items_tp) o2).getTpID() - ((Items_tp) o1).getTpID();
                            } else if (o1 instanceof Items_laptop && o2 instanceof Items_tp) {
                                return ((Items_tp) o2).getTpID() - ((Items_laptop) o1).getLapID();
                            } else {
                                return ((Items_laptop) o2).getLapID() - ((Items_tp) o1).getTpID();
                            }
                        });

                        // 수량이 0인 아이템 제거
                        combinedList.removeIf(item -> {
                            if (item instanceof Items_laptop) {
                                return ((Items_laptop) item).getLapQuan() == 0;
                            } else if (item instanceof Items_tp) {
                                return ((Items_tp) item).getTpQuan() == 0;
                            }
                            return false;
                        });

                        for (int i = 0; i < 5 && i < combinedList.size(); i++) {
                            Object item = combinedList.get(i);
                            String name = "", url = "", price = "", seller = "";
                            if (item instanceof Items_laptop) {
                                Items_laptop laptop = (Items_laptop) item;
                                name = laptop.getLapName();
                                url = request.getContextPath() + "/template/itempage.jsp?type=laptop&id=" + laptop.getLapID();
                                price = laptop.getLapPrice() + "원";
                                seller = laptop.getUserName();
                            } else if (item instanceof Items_tp) {
                                Items_tp tp = (Items_tp) item;
                                name = tp.getTpName();
                                url = request.getContextPath() + "/template/itempage.jsp?type=pad&id=" + tp.getTpID();
                                price = tp.getTpPrice() + "원";
                                seller = tp.getUserName();
                            }
                    %>
                    <tr>
                        <td><a href="<%= url %>"><%= name %></a></td>
                        <td><%= price %></td>
                        <td><%= seller %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="right">
            <table class="common-table">
                <thead>
                    <tr>
                        <th colspan="2">공지사항 
                            <button class="more-btn" onclick="location.href='${pageContext.request.contextPath}/template/noticeboard.jsp'">더보기</button>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        NoticeDao noticeDao = new NoticeDao();
                        List<Notice> notices = noticeDao.getAllNotices(); // 날짜 순서로 정렬된 공지사항 목록
                        int count = 0;
                        for (Notice notice : notices) {
                            if (count >= 5) {
                                break;
                            }
                    %>
                    <tr>
                        <td><a href="notice_detail.jsp?title=<%= java.net.URLEncoder.encode(notice.getTitle(), "UTF-8") %>"><%= notice.getTitle() %></a></td>
                        <td><%= notice.getDate() %></td>
                    </tr>
                    <%
                            count++;
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
