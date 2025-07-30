<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="items.Items_laptop_Dao" %>
<%@ page import="items.Items_laptop" %>
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
        Items_laptop_Dao dao = new Items_laptop_Dao();
        List<String> brands = dao.getUniqueBrands();
        String selectedBrand = request.getParameter("brand");
        String searchQuery = request.getParameter("search");
        List<Items_laptop> items;

        if (searchQuery != null && !searchQuery.isEmpty()) {
            items = dao.searchItemsByName(searchQuery);
        } else if (selectedBrand != null) {
            items = dao.getItemsByBrand(selectedBrand);
        } else {
            items = dao.getAllItems();
        }
    %>

    <main class="laptop-main-content">
        <div class="laptop-keywords">
            <h2>브랜드 키워드</h2>
            <div class="laptop-keyword-box">
                <a href="?"><span>전체 보기</span></a> <!-- 전체 보기 버튼 추가 -->
                <%
                    for (String brand : brands) {
                        out.print("<a href='?brand=" + brand + "'><span>" + brand + "</span></a>");
                    }
                %>
            </div>
            <div class="laptop-search">
                <form action="laptop.jsp" method="get">
                    <input type="text" name="search" placeholder="제품 검색" value="<%= searchQuery != null ? searchQuery : "" %>">
                    <button type="submit">🔍</button>
                </form>
            </div>
        </div>
        <div class="laptop-item-list">
            <%
                for (Items_laptop item : items) {
                    if (item.getLapQuan() > 0) { // 수량이 0이 아닌 경우에만 표시
                        String imgPath = dao.getImagePathByLapID(item.getLapID());
                        if (imgPath == null) {
                            imgPath = "https://via.placeholder.com/150";
                        } else {
                            imgPath = request.getContextPath() + imgPath;
                        }
            %>
            <div class="laptop-item">
                <a href="${pageContext.request.contextPath}/template/itempage.jsp?type=laptop&id=<%= item.getLapID() %>">
                    <img src="<%= imgPath %>" alt="<%= item.getLapName() %>">
                </a>
                <p><%= item.getLapName() %></p>
                <p>수량: <%= item.getLapQuan() %></p>
                <p>월 렌탈료: <%= item.getLapPrice() %>원</p>
                <p>판매자: <%= item.getUserName() %></p>
                <p>브랜드: <%= item.getLapBrand() %></p>
            </div>
            <%
                    }
                }
            %>
        </div>
    </main>
</body>
</html>
