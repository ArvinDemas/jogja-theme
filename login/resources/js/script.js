document.addEventListener('DOMContentLoaded', () => {

    // ==========================================
    // 1. CAROUSEL & VISUAL (Slide Gambar)
    // ==========================================
    const slides = document.querySelectorAll('.carousel-slide');
    const progressBar = document.querySelector('.progress-bar');

    if (slides.length > 0 && progressBar) {
        let currentSlide = 0;
        const slideDuration = 5000;

        function startProgress() {
            progressBar.style.transition = 'none';
            progressBar.style.width = '0%';
            void progressBar.offsetWidth;
            progressBar.style.transition = `width ${slideDuration}ms linear`;
            progressBar.style.width = '100%';
        }

        function showNextSlide() {
            slides[currentSlide].classList.remove('active');
            currentSlide = (currentSlide + 1) % slides.length;
            slides[currentSlide].classList.add('active');
            startProgress();
        }

        startProgress();
        setInterval(showNextSlide, slideDuration);
    }

    // ==========================================
    // 2. TOGGLE PASSWORD
    // ==========================================
    window.togglePassword = function (id) {
        const input = document.getElementById(id);
        const icon = document.querySelector(`[onclick="togglePassword('${id}')"]`);
        if (input && icon) {
            const isPass = input.type === "password";
            input.type = isPass ? "text" : "password";
            icon.classList.toggle('ph-eye', !isPass);
            icon.classList.toggle('ph-eye-slash', isPass);
        }
    }

    // ==========================================
    // 3. VALIDASI REGISTER
    // ==========================================
    const regPass = document.getElementById('reg-pass');
    const regConfirm = document.getElementById('reg-confirm');
    const matchIndicator = document.getElementById('match-indicator');
    const passwordStrength = document.querySelector('.password-strength');
    const submitBtn = document.getElementById('submit-btn');
    const privacyCheckbox = document.getElementById('privacy-accept');
    let passwordRules = { length: false, upper: false, number: false, symbol: false };

    if (regPass) {
        regPass.addEventListener('input', function () {
            const val = this.value;
            passwordRules.length = val.length >= 8;
            passwordRules.upper = /[A-Z]/.test(val);
            passwordRules.number = /[0-9]/.test(val);
            passwordRules.symbol = /[!@#$%^&*(),.?":{}|<>]/.test(val);

            updateRule('rule-length', passwordRules.length);
            updateRule('rule-upper', passwordRules.upper);
            updateRule('rule-number', passwordRules.number);
            updateRule('rule-symbol', passwordRules.symbol);

            const allValid = Object.values(passwordRules).every(r => r === true);
            if (val.length > 0) {
                regPass.classList.toggle('valid', allValid);
                regPass.classList.toggle('invalid', !allValid);
                if (passwordStrength) passwordStrength.classList.toggle('has-errors', !allValid);
            } else {
                regPass.classList.remove('valid', 'invalid');
            }
            if (regConfirm && regConfirm.value.length > 0) checkPasswordMatch();
            updateSubmitButton();
        });
    }

    if (regConfirm) {
        regConfirm.addEventListener('input', function () {
            checkPasswordMatch();
            updateSubmitButton();
        });
    }

    if (privacyCheckbox) {
        privacyCheckbox.addEventListener('change', updateSubmitButton);
    }

    function updateRule(id, isValid) {
        const el = document.getElementById(id);
        if (!el) return;
        const icon = el.querySelector('i');
        if (isValid) {
            el.classList.add('valid');
            if (icon) { icon.className = 'ph ph-check-circle'; icon.setAttribute('weight', 'fill'); }
        } else {
            el.classList.remove('valid');
            if (icon) { icon.className = 'ph ph-circle'; icon.setAttribute('weight', 'regular'); }
        }
    }

    function checkPasswordMatch() {
        if (!regPass || !regConfirm) return;
        const isMatch = regPass.value === regConfirm.value;
        if (regConfirm.value.length > 0) {
            regConfirm.classList.toggle('valid', isMatch);
            regConfirm.classList.toggle('invalid', !isMatch);
            if (matchIndicator) matchIndicator.style.display = isMatch ? 'none' : 'flex';
        }
    }

    function updateSubmitButton() {
        if (!submitBtn) return;
        const allValid = Object.values(passwordRules).every(r => r === true);
        const isMatch = regPass && regConfirm && (regPass.value === regConfirm.value) && regConfirm.value.length > 0;
        const isPrivacy = privacyCheckbox ? privacyCheckbox.checked : true;
        submitBtn.disabled = !(allValid && isMatch && isPrivacy);
    }

    if (submitBtn) submitBtn.disabled = true;

    // ==========================================
    // 4. CLEANUP INPUT
    // ==========================================
    document.querySelectorAll('input').forEach(input => {
        input.setAttribute('autocomplete', 'off');
        if (input.type === 'password') {
            input.addEventListener('focus', function () {
                if (this.value === '') this.value = '';
            });
        }
    });
});