<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.UserDao, user.User" %>
<%@ page import="items.Items_laptop_Dao, items.Items_tp_Dao, items.Items_laptop, items.Items_tp, items.Laptop_img_Dao, items.Tp_img_Dao, items.Laptop_img, items.Tp_img" %>

<%
    String type = request.getParameter("type");
    String idParam = request.getParameter("id");
    String userEmail = (String) session.getAttribute("userEmail"); // 로그인 후 세션에 저장된 이메일을 가져옴

    if (userEmail == null) {
        response.sendRedirect("login.jsp"); // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        return;
    }

    UserDao userDao = new UserDao();
    User user = userDao.getUserByEmail(userEmail);

    int id = 0;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            // 유효하지 않은 숫자 형식일 경우 처리할 코드
            out.println("유효하지 않은 id 형식입니다.");
        }
    } else {
        // id 파라미터가 없을 경우 처리할 코드
        out.println("id 파라미터가 없습니다.");
    }

    Object item = null;
    String imagePath = null;

    if ("laptop".equals(type)) {
        Items_laptop_Dao dao = new Items_laptop_Dao();
        item = dao.getItemById(id);
        if (item != null) {
            Laptop_img_Dao imgDao = new Laptop_img_Dao();
            Laptop_img laptopImg = imgDao.getImageByLapID(id);
            if (laptopImg != null) {
                imagePath = request.getContextPath() + "/uploads_laptop/" + laptopImg.getLap_img_Name();
            }
        }
    } else if ("pad".equals(type)) {
        Items_tp_Dao dao = new Items_tp_Dao();
        item = dao.getItemById(id);
        if (item != null) {
            Tp_img_Dao imgDao = new Tp_img_Dao();
            Tp_img tpImg = imgDao.getImageByTpID(id);
            if (tpImg != null) {
                imagePath = request.getContextPath() + "/uploads_tp/" + tpImg.getTp_img_Name();
            }
        }
    }

    if (item == null) {
        out.println("<script>alert('아이템을 찾을 수 없습니다.'); history.back();</script>");
        return;
    }

    int price = type.equals("laptop") ? ((Items_laptop) item).getLapPrice() : ((Items_tp) item).getTpPrice();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>발로렌트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after?after">
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />
    <div class="payment-container">
        <h1>주문하기</h1>

        <form action="${pageContext.request.contextPath}/action/paymentAction.jsp" method="post">
            <section class="payment-order-summary">
                <h2>주문상품 정보</h2>
                <table class="payment-table">
                    <thead>
                        <tr>
                            <th>제품정보</th>
                            <th>판매가격</th>
                            <th>주문수량</th>
                            <th>렌트기간</th>
                            <th>합계</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <% if (imagePath != null) { %>
                                    <img src="<%= imagePath %>" alt="아이템 이미지" class="payment-product-img">
                                <% } else { %>
                                    <img src="https://via.placeholder.com/150" alt="아이템 이미지" class="payment-product-img">
                                <% } %>
                                <p><%= type.equals("laptop") ? ((Items_laptop) item).getLapName() : ((Items_tp) item).getTpName() %></p>
                                <p>수량: <%= type.equals("laptop") ? ((Items_laptop) item).getLapQuan() : ((Items_tp) item).getTpQuan() %>개</p>
                            </td>
                            <td><%= price %>원</td>
                            <td>
                                <div class="quantity-control">
                                    <button type="button" class="quantity-btn" onclick="decreaseQuantity('quantity1', <%= price %>)">-</button>
                                    <input type="text" id="quantity1" name="orderQuan" value="1" class="quantity-input" readonly>
                                    <button type="button" class="quantity-btn" onclick="increaseQuantity('quantity1', <%= price %>, <%= type.equals("laptop") ? ((Items_laptop) item).getLapQuan() : ((Items_tp) item).getTpQuan() %>)">+</button>
                                </div>
                            </td>
                            <td>
                                <select name="orderRent" id="rental-period" class="rental-select" onchange="updateTotal(<%= price %>)">
                                    <% for (int i = 1; i <= 12; i++) { %>
                                        <option value="<%= i %>"><%= i %>개월</option>
                                    <% } %>
                                </select>
                            </td>
                            <td id="total-price"><%= price %>원</td>
                        </tr>
                    </tbody>
                </table>
            </section>
            
            <section class="payment-shipping-info">
                <h2>배송지 정보</h2>
                
                <label for="name">받는 사람</label>
                <input type="text" id="name" name="orderName" value="<%= user.getUserName() %>" placeholder=" 12자 이내로 입력해주세요 " class="payment-input" required>
                    
                <label for="email">이메일</label>
                <input type="email" id="email" name="orderEmail" value="<%= user.getUserEmail() %>" placeholder=" example@email.com " class="payment-input" required>
                    
                <label for="phone">휴대폰</label>
                <input type="tel" id="phone" name="orderPnum" value="<%= user.getUserPnum() %>" placeholder=" 010-1234-5678 " class="payment-input" required>
                    
                <label for="address">주소</label>
                <div class="address-container">
                    <input type="text" id="address" name="orderAdd1" value="<%= user.getUserAddress() %>" placeholder="주소를 입력해주세요" class="payment-input half-width" required>
                    <input type="text" id="detailed-address" name="orderAdd2" placeholder="상세주소를 입력해주세요" class="payment-input half-width" required>
                </div>
                    
                <label for="message">배송시 요청사항</label>
                <input type="text" id="message" name="orderReq" class="payment-input">               
            
            </section>
            
            <section class="payment-info">
                <h2>결제 정보</h2>
                <div class="payment-methods">
                    <label><input type="radio" name="paymentMethod" value="card" required> 신용카드</label>
                    <label><input type="radio" name="paymentMethod" value="bank" required> 무통장입금</label>
                    <label><input type="radio" name="paymentMethod" value="paypal" required> PayPal</label>
                </div>
            </section>
                
            <section class="payment-total">
                <h2>총 주문금액</h2>
                <div class="total-details">
                    <div class="total-row">
                        <span>주문금액</span>
                        <span id="order-amount"><%= price %>원</span>
                    </div>
                    <div class="total-row">
                        <span>할인금액</span>
                        <span>0원</span>
                    </div>
                    <div class="total-row">
                        <span>배송비</span>
                        <span>0원</span>
                    </div>
                    <div class="total-row">
                        <span>적립예정 포인트</span>
                        <span>0점</span>
                    </div>
                    <p>* 회원 로그인 시 적립되는 포인트입니다.</p>
                    <div class="total-row final-total">
                        <span>최종결제금액</span>
                        <span class="final-amount" id="final-amount"><%= price %>원</span>
                    </div>
                </div>
            </section>
            
            <input type="hidden" name="type" value="<%= type %>">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="price" value="<%= price %>">
            
            <button type="submit" class="payment-button" onclick="location.href='${pageContext.request.contextPath}/template/payment-complete.jsp'">결제하기</button>
            <button type="button" class="payment-cancel-button" onclick="location.href='${pageContext.request.contextPath}/template/mainpage.jsp'">취소하기</button>
        </form>
    </div>

    <script>
        function increaseQuantity(id, price, maxQuantity) {
            var input = document.getElementById(id);
            var newValue = parseInt(input.value) + 1;
            if (newValue > maxQuantity) {
                alert('수량을 초과하였습니다.');
            } else {
                input.value = newValue;
                updateTotal(price);
            }
        }
        
        function decreaseQuantity(id, price) {
            var input = document.getElementById(id);
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
                updateTotal(price);
            }
        }

        function updateTotal(price) {
            var quantity = parseInt(document.getElementById('quantity1').value);
            var period = parseInt(document.getElementById('rental-period').value);
            var total = quantity * period * price;
            document.getElementById('total-price').innerText = total + '원';
            document.getElementById('order-amount').innerText = total + '원';
            document.getElementById('final-amount').innerText = total + '원';
        }
        
        function confirmPayment() {
            if (confirm('결제가 성공적으로 이루어졌습니다!')) {
                document.getElementById('paymentForm').submit();
            }
        }
    </script>
</body>
</html>
