<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대여물품등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/design.css?after">
    <script>
        function updateForm() {
            var category = document.getElementById("registerRent-category").value;
            var laptopForm = document.getElementById("laptop-form");
            var padForm = document.getElementById("pad-form");

            if (category === "노트북") {
                laptopForm.style.display = "block";
                padForm.style.display = "none";
            } else if (category === "패드/탭") {
                laptopForm.style.display = "none";
                padForm.style.display = "block";
            } else {
                laptopForm.style.display = "none";
                padForm.style.display = "none";
            }
        }
    </script>
</head>

<body>
    <button class="home-button" onclick="window.location.href='${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/template/mainpage.jsp'">홈페이지로 돌아가기</button>

    <div class="registerRent-container">
        <div class="registerRent-header">
            <h1 class="registerRent-title">대여물품등록</h1>
        </div>
        <div class="registerRent-form">
            <div class="registerRent-row">
                <label for="registerRent-category">등록 할 상품의 분류를 선택하시오.</label>
                <select name="category" id="registerRent-category" class="registerRent-input" onchange="updateForm()">
                    <option value="">분류 선택</option>
                    <option value="패드/탭">패드/탭</option>
                    <option value="노트북">노트북</option>
                </select>
            </div>
        </div>

        <form id="laptop-form" class="registerRent-form" method="post" action="${pageContext.request.contextPath}/action/laptopAction.jsp" enctype="multipart/form-data" style="display:none;">
            <label for="registerRent-device-name">기기 명 (제품명을 정확하게 입력하십시오)</label>
            <input type="text" name="lapName" id="registerRent-device-name" class="registerRent-input" required>

            <div class="registerRent-row">
                <div class="registerRent-column">
                    <label for="registerRent-quantity">수량</label>
                    <input type="number" name="lapQuan" id="registerRent-quantity" class="registerRent-input" required>
                </div>
                <div class="registerRent-column">
                    <label for="registerRent-purchase-year">구입년도</label>
                    <input type="text" name="lapYear" id="registerRent-purchase-year" class="registerRent-input">
                </div>
            </div>

            <div class="registerRent-row">
                <div class="registerRent-column">
                    <label for="registerRent-monthly-rent">월 렌탈료 지정</label>
                    <input type="text" name="lapPrice" id="registerRent-monthly-rent" class="registerRent-input">
                </div>
            </div>

            <h2 class="registerRent-subtitle">스펙 입력</h2>
            <div id="registerRent-spec-section" class="registerRent-spec-section">
                <div class="registerRent-row">
                    <label for="registerRent-brand" class="registerRent-label">브랜드 명</label>
                    <input type="text" name="lapBrand" id="registerRent-brand" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-model" class="registerRent-label">모델명</label>
                    <input type="text" name="lapModel" id="registerRent-model" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-color" class="registerRent-label">컬러</label>
                    <input type="text" name="lapColor" id="registerRent-color" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-gpu">그래픽카드</label>
                    <input type="text" name="lapGraphic" id="registerRent-gpu" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-os">OS</label>
                    <input type="text" name="lapOS" id="registerRent-os" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-cpu">CPU</label>
                    <input type="text" name="lapCPU" id="registerRent-cpu" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-memory" class="registerRent-label">메모리</label>
                    <input type="text" name="lapMemory" id="registerRent-memory" class="registerRent-input">
                </div>
            </div>

            <h2 class="registerRent-subtitle">기기 사진 첨부</h2>
            <input type="file" name="laptopImage" class="registerRent-upload-button">
            <button type="submit" class="registerRent-submit-button">물품 등록 요청</button>
        </form>

        <form id="pad-form" class="registerRent-form" method="post" action="${pageContext.request.contextPath}/action/padAction.jsp" style="display:none;" encType = "multipart/form-data">
            <label for="registerRent-device-name-pad">기기 명 (제품명을 정확하게 입력하십시오)</label>
            <input type="text" name="tpName" id="registerRent-device-name-pad" class="registerRent-input" required>

            <div class="registerRent-row">
                <div class="registerRent-column">
                    <label for="registerRent-quantity-pad">수량</label>
                    <input type="number" name="tpQuan" id="registerRent-quantity-pad" class="registerRent-input" required>
                </div>
                <div class="registerRent-column">
                    <label for="registerRent-purchase-year-pad">구입년도</label>
                    <input type="text" name="tpYear" id="registerRent-purchase-year-pad" class="registerRent-input">
                </div>
            </div>

            <div class="registerRent-row">
                <div class="registerRent-column">
                    <label for="registerRent-monthly-rent-pad">월 렌탈료 지정</label>
                    <input type="text" name="tpPrice" id="registerRent-monthly-rent-pad" class="registerRent-input">
                </div>
            </div>

            <h2 class="registerRent-subtitle">스펙 입력</h2>
            <div id="registerRent-spec-section-pad" class="registerRent-spec-section">
                <div class="registerRent-row">
                    <label for="registerRent-brand-pad" class="registerRent-label">브랜드 명</label>
                    <input type="text" name="tpBrand" id="registerRent-brand-pad" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-model-pad" class="registerRent-label">모델명</label>
                    <input type="text" name="tpModel" id="registerRent-model-pad" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-color-pad" class="registerRent-label">컬러</label>
                    <input type="text" name="tpColor" id="registerRent-color-pad" class="registerRent-input">
                </div>
                <div class="registerRent-row">
                    <label for="registerRent-memory-pad" class="registerRent-label">메모리</label>
                    <input type="text" name="tpMemory" id="registerRent-memory-pad" class="registerRent-input">
                </div>
            </div>

            <h2 class="registerRent-subtitle">기기 사진 첨부</h2>
            <input type="file" name="tpImage" class="registerRent-upload-button">
            <button type="submit" class="registerRent-submit-button">물품 등록 요청</button>
        </form>
    </div>
</body>

</html>
