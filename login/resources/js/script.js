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

    // --- 2. TAB LOGIN (Kredensial / QR) ---
    const tabPass = document.getElementById('tab-pass');
    const tabQr = document.getElementById('tab-qr');
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

    // --- 3. PASSWORD TOGGLE (Mata Show/Hide) ---
    window.togglePassword = function(id) {
        const input = document.getElementById(id);
        const icon = document.querySelector(`[onclick="togglePassword('${id}')"]`);
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

    // --- 4. PASSWORD VALIDATION CHECKLIST (Register) ---
    const regPass = document.getElementById('reg-pass');
    
    if (regPass) {
        regPass.addEventListener('keyup', function() {
            const val = this.value;
            // Validasi 4 Aturan
            updateRule('rule-length', val.length >= 8);
            updateRule('rule-upper', /[A-Z]/.test(val));
            updateRule('rule-number', /[0-9]/.test(val));
            updateRule('rule-symbol', /[!@#$%^&*(),.?":{}|<>]/.test(val));
        });
    }

    function updateRule(id, isValid) {
        const el = document.getElementById(id);
        const icon = el.querySelector('i');
        
        if (isValid) {
            el.classList.add('valid');
            // Ganti icon jadi centang penuh
            icon.classList.replace('ph-circle', 'ph-check-circle');
            icon.setAttribute('weight', 'fill');
        } else {
            el.classList.remove('valid');
            // Ganti icon jadi lingkaran kosong
            icon.classList.replace('ph-check-circle', 'ph-circle');
            icon.setAttribute('weight', 'regular');
        }
    }
});