<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="items.Items_tp_Dao" %>
<%@ page import="items.Items_tp" %>
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

    <%
        Items_tp_Dao dao = new Items_tp_Dao();
        List<String> brands = dao.getUniqueBrands();
        String selectedBrand = request.getParameter("brand");
        String searchQuery = request.getParameter("search");
        List<Items_tp> items;

        if (searchQuery != null && !searchQuery.isEmpty()) {
            items = dao.searchItemsByName(searchQuery);
        } else if (selectedBrand != null) {
            items = dao.getItemsByBrand(selectedBrand);
        } else {
            items = dao.getAllItems();
        }
    %>

    <main class="tablet-main-content">
        <div class="tablet-keywords">
            <h2>브랜드 키워드</h2>
            <div class="tablet-keyword-box">
                <a href="?"><span>전체 보기</span></a> <!-- 전체 보기 버튼 추가 -->
                <%
                    for (String brand : brands) {
                        out.print("<a href='?brand=" + brand + "'><span>" + brand + "</span></a>");
                    }
                %>
            </div>
            <div class="tablet-search">
                <form action="tablet.jsp" method="get">
                    <input type="text" name="search" placeholder="제품 검색" value="<%= searchQuery != null ? searchQuery : "" %>">
                    <button type="submit">🔍</button>
                </form>
            </div>
        </div>
        <div class="tablet-item-list">
            <%
                for (Items_tp item : items) {
                    if (item.getTpQuan() > 0) { // 수량이 0이 아닌 경우에만 표시
                        String imgPath = dao.getImagePathByTpID(item.getTpID());
                        if (imgPath == null) {
                            imgPath = "https://via.placeholder.com/150";
                        } else {
                            imgPath = request.getContextPath() + imgPath;
                        }
            %>
            <div class="tablet-item">
                <a href="${pageContext.request.contextPath}/template/itempage.jsp?type=pad&id=<%= item.getTpID() %>">
                    <img src="<%= imgPath %>" alt="<%= item.getTpName() %>">
                </a>
                <p><%= item.getTpName() %></p>
                <p>수량: <%= item.getTpQuan() %></p>
                <p>월 렌탈료: <%= item.getTpPrice() %>원</p>
                <p>판매자: <%= item.getUserName() %></p>
                <p>브랜드: <%= item.getTpBrand() %></p>
            </div>
            <%
                    }
                }
            %>
        </div>
    </main>
</body>
</html>
