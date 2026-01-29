<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Password - Portal Pemda DIY</title>
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
    <div class="container">
        
        <#-- VISUAL SECTION (KIRI) -->
        <div class="visual-section">
            <div class="particle"></div><div class="particle"></div>
            
            <div class="brand-wrapper">
                <div class="logo-box">
                    <img src="https://jogjaprov.go.id/storage/files/shares/page/1518066730_2d84b769e3cc9d6f06f8c91a6c3e285c.jpg" alt="Logo DIY">
                </div>
                <div class="brand-text"><h1>PEMDA DIY</h1><p>YOGYAKARTA</p></div>
            </div>

            <div class="carousel-container">
                <div class="security-tips-section">
                    <h2 class="tips-main-title">Perbarui Password<br/>Anda</h2>
                    <div class="tips-badge">Keamanan Akun</div>
                    
                    <div class="tips-list">
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-clock-clockwise" weight="fill"></i>
                            </div>
                            <p>Perbarui password Anda secara berkala untuk menjaga keamanan akun</p>
                        </div>
                        
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-shield-star" weight="fill"></i>
                            </div>
                            <p>Gunakan password yang unik dan berbeda dari password lama Anda</p>
                        </div>
                        
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-lock-key" weight="fill"></i>
                            </div>
                            <p>Password yang kuat melindungi data dan informasi penting Anda</p>
                        </div>
                        
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-user-check" weight="fill"></i>
                            </div>
                            <p>Setelah update, Anda akan tetap login di perangkat ini</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>
            
            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Update Password</h2>
                    <p>Masukkan password lama dan buat password baru</p>
                </div>

                <#-- Alert Error/Success -->
                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <#if message.type = 'success'><i class="ph ph-check-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <form action="${url.loginAction}" method="post" autocomplete="off" id="update-pass-form">
                    
                    <#-- PASSWORD LAMA -->
                    <div class="form-group">
                        <label class="form-label">Password Lama</label>
                        <div class="input-wrapper">
                            <input type="password" name="password" id="password-old" class="form-input" placeholder="Masukkan password lama" autocomplete="current-password" required autofocus />
                            <i class="ph ph-lock-open input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('password-old')"></i>
                        </div>
                    </div>

                    <div class="divider-line"></div>

                    <#-- PASSWORD BARU -->
                    <div class="form-group">
                        <label class="form-label">Password Baru</label>
                        <div class="input-wrapper">
                            <input type="password" name="password-new" id="password-new" class="form-input" placeholder="Minimal 8 karakter" autocomplete="new-password" required />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('password-new')"></i>
                        </div>
                    </div>

                    <#-- INDIKATOR KEKUATAN PASSWORD -->
                    <div class="password-strength">
                        <div class="strength-title">Keamanan Password:</div>
                        <div class="strength-indicators">
                            <div class="strength-item" id="rule-length">
                                <i class="ph ph-circle"></i>
                                <span>Min 8 Karakter</span>
                            </div>
                            <div class="strength-item" id="rule-upper">
                                <i class="ph ph-circle"></i>
                                <span>Huruf Besar</span>
                            </div>
                            <div class="strength-item" id="rule-number">
                                <i class="ph ph-circle"></i>
                                <span>Angka</span>
                            </div>
                            <div class="strength-item" id="rule-symbol">
                                <i class="ph ph-circle"></i>
                                <span>Simbol (!@#)</span>
                            </div>
                        </div>
                    </div>

                    <#-- KONFIRMASI PASSWORD -->
                    <div class="form-group">
                        <label class="form-label">Konfirmasi Password Baru</label>
                        <div class="input-wrapper">
                            <input type="password" name="password-confirm" id="password-confirm" class="form-input" placeholder="Ulangi password baru" autocomplete="new-password" required />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('password-confirm')"></i>
                        </div>
                        <div class="password-match-indicator" id="match-indicator" style="display: none;">
                            <i class="ph ph-x-circle"></i>
                            <span>Password tidak cocok</span>
                        </div>
                    </div>

                    <#-- LOGOUT ALL SESSIONS -->
                    <div class="form-group">
                        <div class="logout-sessions-checkbox">
                            <input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" />
                            <label for="logout-sessions">
                                <i class="ph ph-sign-out"></i>
                                Logout dari semua perangkat lain setelah update password
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="main-btn" id="submit-btn" disabled>
                        <i class="ph ph-check-circle"></i>
                        <span>Update Password</span>
                    </button>
                </form>

                <div class="bottom-text">
                    <a href="${url.loginRestartFlowUrl}">
                        <i class="ph ph-arrow-left"></i>
                        Batalkan
                    </a>
                </div>

                <#-- FOOTER LINKS -->
                <div class="footer-links">
                    <a href="https://wiki.jogjaprov.go.id/diskominfo/panduan/panduan-2fa" target="_blank" class="footer-link">
                        <i class="ph ph-shield-check"></i>
                        <span>Panduan SSO/2FA</span>
                    </a>
                    <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" class="footer-link">
                        <i class="ph ph-chat-circle-dots"></i>
                        <span>Kontak</span>
                    </a>
                    <a href="https://drive.google.com/file/d/1nvLDfcjULstrpKbt-8o3nSY23FgCMxl4/view" target="_blank" class="footer-link">
                        <i class="ph ph-file-text"></i>
                        <span>Kebijakan Privasi</span>
                    </a>
                    <a href="https://diskominfo.notion.site/28e22b0cdb8080e6a777e835aee5cff7" target="_blank" class="footer-link">
                        <i class="ph ph-megaphone"></i>
                        <span>Kritik/Saran</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="${url.resourcesPath}/js/script.js"></script>
    <script>
        // Password validation logic (same as reset password)
        const passNew = document.getElementById('password-new');
        const passConfirm = document.getElementById('password-confirm');
        const matchIndicator = document.getElementById('match-indicator');
        const passwordStrength = document.querySelector('.password-strength');
        const submitBtn = document.getElementById('submit-btn');
        
        let passwordRules = {
            length: false,
            upper: false,
            number: false,
            symbol: false
        };

        if (passNew) {
            passNew.value = '';
            
            passNew.addEventListener('input', function() {
                const val = this.value;
                
                passwordRules.length = val.length >= 8;
                passwordRules.upper = /[A-Z]/.test(val);
                passwordRules.number = /[0-9]/.test(val);
                passwordRules.symbol = /[!@#$%^&*(),.?":{}|<>]/.test(val);
                
                updateRule('rule-length', passwordRules.length);
                updateRule('rule-upper', passwordRules.upper);
                updateRule('rule-number', passwordRules.number);
                updateRule('rule-symbol', passwordRules.symbol);
                
                const allValid = Object.values(passwordRules).every(rule => rule === true);
                
                if (val.length > 0) {
                    if (allValid) {
                        passNew.classList.remove('invalid');
                        passNew.classList.add('valid');
                        passwordStrength.classList.remove('has-errors');
                    } else {
                        passNew.classList.add('invalid');
                        passNew.classList.remove('valid');
                        passwordStrength.classList.add('has-errors');
                    }
                } else {
                    passNew.classList.remove('invalid', 'valid');
                    passwordStrength.classList.remove('has-errors');
                }
                
                if (passConfirm.value.length > 0) {
                    checkPasswordMatch();
                }
                
                updateSubmitButton();
            });
        }

        if (passConfirm) {
            passConfirm.value = '';
            
            passConfirm.addEventListener('input', function() {
                checkPasswordMatch();
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
            if (!passNew || !passConfirm || !matchIndicator) return;
            
            const password = passNew.value;
            const confirmPassword = passConfirm.value;
            
            if (confirmPassword.length > 0) {
                if (password === confirmPassword) {
                    passConfirm.classList.remove('invalid');
                    passConfirm.classList.add('valid');
                    matchIndicator.style.display = 'none';
                } else {
                    passConfirm.classList.add('invalid');
                    passConfirm.classList.remove('valid');
                    matchIndicator.style.display = 'flex';
                    matchIndicator.classList.remove('success');
                }
            } else {
                passConfirm.classList.remove('invalid', 'valid');
                matchIndicator.style.display = 'none';
            }
        }

        function updateSubmitButton() {
            if (!submitBtn || !passNew || !passConfirm) return;
            
            const allValid = Object.values(passwordRules).every(rule => rule === true);
            const passwordsMatch = passNew.value === passConfirm.value && passConfirm.value.length > 0;
            
            if (allValid && passwordsMatch) {
                submitBtn.disabled = false;
            } else {
                submitBtn.disabled = true;
            }
        }

        // Initialize
        if (submitBtn) {
            submitBtn.disabled = true;
        }
    </script>
</body>
</html>
