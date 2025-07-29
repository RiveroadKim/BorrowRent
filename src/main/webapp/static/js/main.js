function checkUsername() {
    const usernameInput = document.getElementById("username");
    const message = document.getElementById("username-message");
    const username = usernameInput.value.trim();

    // 이메일 형식인지 확인하는 정규식
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (username.length < 5) {
        message.textContent = "사용 불가능한 아이디입니다.";
        message.classList.remove("available");
        return false;

    } else if (!regex.test(username)) {
        message.textContent = "사용 불가능한 아이디입니다.";
        message.classList.remove("available");
        return false;
    
    } else {
        message.textContent = "사용 가능한 아이디입니다.";
        message.classList.add("available");
        return true;
    }
}

function checkPassword() {
    const passwordInput = document.getElementById("password");
    const confirmPasswordInput = document.getElementById("confirm-password");
    const message = document.getElementById("password-message");

    if (passwordInput.value.length < 8) {
        message.textContent = "비밀번호는 최소 8자 이상이어야 합니다.";
        message.classList.add("unavailable");
        message.classList.remove("available");
        return false;

    } else if (passwordInput.value === confirmPasswordInput.value) {
        message.textContent = "비밀번호가 일치합니다.";
        message.classList.add("available");
        message.classList.remove("unavailable");
        return true;
    } else {
        message.textContent = "비밀번호가 일치하지 않습니다.";
        message.classList.add("unavailable");
        message.classList.remove("available");
        return false;
    }
}

function validateForm() {
    const isUsernameValid = checkUsername();
    const isPasswordValid = checkPassword();
    
    return isUsernameValid && isPasswordValid;
}

document.addEventListener('DOMContentLoaded', (event) => {
    const signupButton = document.getElementById('signup-button');

    signupButton.addEventListener('click', (event) => {
        if (!validateForm()) {
            event.preventDefault(); // 폼 제출 막기
            alert('폼을 올바르게 작성해 주세요.');
        } else {
            alert('회원가입이 정상적으로 완료되었습니다.');
            window.location.href = "${pageContext.request.contextPath}/template/login.jsp";
        }
    });
});
