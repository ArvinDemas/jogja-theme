document.addEventListener('DOMContentLoaded', () => {
    
    // --- 1. CAROUSEL & PROGRESS BAR ---
    const slides = document.querySelectorAll('.carousel-slide');
    const progressBar = document.querySelector('.progress-bar');
    
    if (slides.length > 0 && progressBar) {
        let currentSlide = 0;
        const slideDuration = 5000;

        function startProgress() {
            progressBar.style.transition = 'none';
            progressBar.style.width = '0%';
            void progressBar.offsetWidth; // Force Reflow
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

    // --- 2. TAB LOGIN (Kredensial / Passkey) ---
    const tabPass = document.getElementById('tab-pass');
    const tabQr = document.getElementById('tab-passkey');
    const formPass = document.getElementById('form-credential');
    const formQr = document.getElementById('form-qr');

    if (tabPass && tabQr) {
        tabPass.addEventListener('click', () => {
            tabPass.classList.add('active');
            tabQr.classList.remove('active');
            formPass.classList.remove('hidden');
            formQr.classList.add('hidden');
        });

        tabQr.addEventListener('click', () => {
            tabQr.classList.add('active');
            tabPass.classList.remove('active');
            formQr.classList.remove('hidden');
            formPass.classList.add('hidden');
        });
    }

    // --- 3. PASSWORD TOGGLE (Show/Hide) ---
    window.togglePassword = function(id) {
        const input = document.getElementById(id);
        const icon = document.querySelector(`[onclick="togglePassword('${id}')"]`);
        if (input && icon) {
            if (input.type === "password") {
                input.type = "text";
                icon.classList.replace('ph-eye', 'ph-eye-slash');
                icon.style.color = "#0ea5e9";
            } else {
                input.type = "password";
                icon.classList.replace('ph-eye-slash', 'ph-eye');
                icon.style.color = "#94a3b8";
            }
        }
    }

    // --- 4. PASSWORD VALIDATION WITH VISUAL FEEDBACK (Register) ---
    const regPass = document.getElementById('reg-pass');
    const regConfirm = document.getElementById('reg-confirm');
    const matchIndicator = document.getElementById('match-indicator');
    const passwordStrength = document.querySelector('.password-strength');
    const submitBtn = document.getElementById('submit-btn');
    const privacyCheckbox = document.getElementById('privacy-accept');
    
    let passwordRules = {
        length: false,
        upper: false,
        number: false,
        symbol: false
    };

    if (regPass) {
        // Clear default values on page load
        regPass.value = '';
        
        regPass.addEventListener('input', function() {
            const val = this.value;
            
            // Validasi 4 Aturan
            passwordRules.length = val.length >= 8;
            passwordRules.upper = /[A-Z]/.test(val);
            passwordRules.number = /[0-9]/.test(val);
            passwordRules.symbol = /[!@#$%^&*(),.?":{}|<>]/.test(val);
            
            updateRule('rule-length', passwordRules.length);
            updateRule('rule-upper', passwordRules.upper);
            updateRule('rule-number', passwordRules.number);
            updateRule('rule-symbol', passwordRules.symbol);
            
            // Check if all rules are valid
            const allValid = Object.values(passwordRules).every(rule => rule === true);
            
            // Update password field visual state
            if (val.length > 0) {
                if (allValid) {
                    regPass.classList.remove('invalid');
                    regPass.classList.add('valid');
                    if (passwordStrength) {
                        passwordStrength.classList.remove('has-errors');
                    }
                } else {
                    regPass.classList.add('invalid');
                    regPass.classList.remove('valid');
                    if (passwordStrength) {
                        passwordStrength.classList.add('has-errors');
                    }
                }
            } else {
                regPass.classList.remove('invalid', 'valid');
                if (passwordStrength) {
                    passwordStrength.classList.remove('has-errors');
                }
            }
            
            // Check password match if confirm field has value
            if (regConfirm && regConfirm.value.length > 0) {
                checkPasswordMatch();
            }
            
            updateSubmitButton();
        });
    }

    if (regConfirm) {
        regConfirm.value = '';
        
        regConfirm.addEventListener('input', function() {
            checkPasswordMatch();
            updateSubmitButton();
        });
    }

    // Privacy checkbox listener
    if (privacyCheckbox) {
        privacyCheckbox.addEventListener('change', function() {
            updateSubmitButton();
        });
    }

    function updateRule(id, isValid) {
        const el = document.getElementById(id);
        if (!el) return;
        
        const icon = el.querySelector('i');
        
        if (isValid) {
            el.classList.add('valid');
            if (icon) {
                icon.classList.remove('ph-circle');
                icon.classList.add('ph-check-circle');
                icon.setAttribute('weight', 'fill');
            }
        } else {
            el.classList.remove('valid');
            if (icon) {
                icon.classList.remove('ph-check-circle');
                icon.classList.add('ph-circle');
                icon.setAttribute('weight', 'regular');
            }
        }
    }

    function checkPasswordMatch() {
        if (!regPass || !regConfirm || !matchIndicator) return;
        
        const password = regPass.value;
        const confirmPassword = regConfirm.value;
        
        if (confirmPassword.length > 0) {
            if (password === confirmPassword) {
                // Passwords match
                regConfirm.classList.remove('invalid');
                regConfirm.classList.add('valid');
                matchIndicator.style.display = 'none';
            } else {
                // Passwords don't match
                regConfirm.classList.add('invalid');
                regConfirm.classList.remove('valid');
                matchIndicator.style.display = 'flex';
                matchIndicator.classList.remove('success');
            }
        } else {
            regConfirm.classList.remove('invalid', 'valid');
            matchIndicator.style.display = 'none';
        }
    }

    function updateSubmitButton() {
        if (!submitBtn || !regPass || !regConfirm) return;
        
        const allValid = Object.values(passwordRules).every(rule => rule === true);
        const passwordsMatch = regPass.value === regConfirm.value && regConfirm.value.length > 0;
        const privacyAccepted = privacyCheckbox ? privacyCheckbox.checked : true;
        
        if (allValid && passwordsMatch && privacyAccepted) {
            submitBtn.disabled = false;
        } else {
            submitBtn.disabled = true;
        }
    }

    // --- 5. CLEAR AUTOCOMPLETE ON LOAD ---
    const allInputs = document.querySelectorAll('input[type="text"], input[type="email"], input[type="password"]');
    allInputs.forEach(input => {
        // Clear value on page load
        if (input.getAttribute('autocomplete') === 'off') {
            input.value = '';
        }
        
        // Disable autocomplete
        input.setAttribute('autocomplete', 'new-password');
        
        // Clear on focus for password fields
        if (input.type === 'password') {
            input.addEventListener('focus', function() {
                if (this.value === '') {
                    this.value = '';
                }
            });
        }
    });

    // Additional method: Use readonly trick to prevent autofill
    setTimeout(() => {
        allInputs.forEach(input => {
            input.removeAttribute('readonly');
        });
    }, 100);

    // --- 6. CLEAR USERNAME AND EMAIL ---
    const usernameInput = document.getElementById('username');
    if (usernameInput) {
        usernameInput.value = '';
    }

    const emailInputs = document.querySelectorAll('input[type="email"]');
    emailInputs.forEach(input => {
        input.value = '';
    });

    // Initialize submit button state
    if (submitBtn) {
        submitBtn.disabled = true;
    }
});
