<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Buat Password Baru - Portal Pemda DIY</title>
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
            <div class="carousel-container" style="margin-top: 120px;">
                <div class="carousel-slide active">
                    <span class="slide-tag">Keamanan Akun</span>
                    <h2 class="slide-title">Buat Password Baru</h2>
                    <p class="slide-desc">Pilih password yang kuat untuk melindungi akun Anda.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Buat Password Baru</h2>
                    <p>
                        <#if username??>
                            Password baru untuk: <strong>${username}</strong>
                        <#else>
                            Masukkan password baru Anda
                        </#if>
                    </p>
                </div>

                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <#if message.type = 'success'><i class="ph ph-check-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <form action="${url.loginAction}" method="post" id="update-password-form" autocomplete="off">
                    
                    <#-- NEW PASSWORD -->
                    <div class="form-group">
                        <label class="form-label">Password Baru</label>
                        <div class="input-wrapper">
                            <input type="password" 
                                   id="password-new" 
                                   name="password-new" 
                                   class="form-input" 
                                   placeholder="Minimal 8 karakter"
                                   required
                                   autofocus
                                   autocomplete="new-password" />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('password-new')"></i>
                        </div>
                    </div>

                    <#-- PASSWORD STRENGTH INDICATOR -->
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

                    <#-- CONFIRM PASSWORD -->
                    <div class="form-group">
                        <label class="form-label">Konfirmasi Password Baru</label>
                        <div class="input-wrapper">
                            <input type="password" 
                                   id="password-confirm" 
                                   name="password-confirm" 
                                   class="form-input" 
                                   placeholder="Ulangi password"
                                   required
                                   autocomplete="new-password" />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('password-confirm')"></i>
                        </div>
                        <div class="password-match-indicator" id="match-indicator" style="display: none;">
                            <i class="ph ph-x-circle"></i>
                            <span>Password tidak cocok</span>
                        </div>
                    </div>

                    <#-- INFO BOX -->
                    <div style="background: #fffbeb; border-left: 4px solid #f59e0b; padding: 15px; border-radius: 10px; margin: 20px 0;">
                        <p style="font-size: 0.85rem; color: #92400e; line-height: 1.6; margin: 0;">
                            <strong>⚠️ Penting:</strong> Setelah password diubah, Anda akan diminta login kembali 
                            dengan password baru. Pastikan Anda mengingatnya atau simpan di password manager.
                        </p>
                    </div>

                    <button type="submit" class="main-btn" id="submit-btn" disabled>
                        <i class="ph ph-check-circle"></i>
                        Simpan Password Baru
                    </button>
                </form>

                <#-- PASSWORD TIPS -->
                <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin: 20px 0;">
                    <h4 style="font-size: 0.9rem; font-weight: 700; color: #0f172a; margin-bottom: 12px;">
                        Tips Password Aman
                    </h4>
                    <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                        <li><strong>Jangan</strong> gunakan password yang sama dengan akun lain</li>
                        <li><strong>Jangan</strong> gunakan informasi pribadi (nama, tanggal lahir)</li>
                        <li><strong>Gunakan</strong> kombinasi huruf besar, kecil, angka, dan simbol</li>
                        <li><strong>Gunakan</strong> password manager untuk menyimpan password</li>
                        <li><strong>Aktifkan</strong> 2FA untuk keamanan tambahan</li>
                    </ul>
                </div>

                <#-- CANCEL OPTION -->
                <div class="bottom-text" style="margin-top: 20px;">
                    <a href="${url.loginUrl}" style="color: #64748b; text-decoration: none; font-size: 0.85rem;">
                        <i class="ph ph-x"></i>
                        Batalkan & Kembali ke Login
                    </a>
                </div>

                <#-- FOOTER LINKS -->
                <div class="footer-links" style="margin-top: 25px;">
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
    
    <script>
        // Password validation and matching
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password-new');
            const confirmInput = document.getElementById('password-confirm');
            const matchIndicator = document.getElementById('match-indicator');
            const submitBtn = document.getElementById('submit-btn');
            const passwordStrength = document.querySelector('.password-strength');
            
            let passwordRules = {
                length: false,
                upper: false,
                number: false,
                symbol: false
            };
            
            // Clear default values
            if (passwordInput) passwordInput.value = '';
            if (confirmInput) confirmInput.value = '';
            
            // Password validation
            if (passwordInput) {
                passwordInput.addEventListener('input', function() {
                    const val = this.value;
                    
                    // Check rules
                    passwordRules.length = val.length >= 8;
                    passwordRules.upper = /[A-Z]/.test(val);
                    passwordRules.number = /[0-9]/.test(val);
                    passwordRules.symbol = /[!@#$%^&*(),.?":{}|<>]/.test(val);
                    
                    // Update UI
                    updateRule('rule-length', passwordRules.length);
                    updateRule('rule-upper', passwordRules.upper);
                    updateRule('rule-number', passwordRules.number);
                    updateRule('rule-symbol', passwordRules.symbol);
                    
                    // Check if all valid
                    const allValid = Object.values(passwordRules).every(rule => rule === true);
                    
                    // Update password field visual
                    if (val.length > 0) {
                        if (allValid) {
                            passwordInput.classList.remove('invalid');
                            passwordInput.classList.add('valid');
                            if (passwordStrength) passwordStrength.classList.remove('has-errors');
                        } else {
                            passwordInput.classList.add('invalid');
                            passwordInput.classList.remove('valid');
                            if (passwordStrength) passwordStrength.classList.add('has-errors');
                        }
                    } else {
                        passwordInput.classList.remove('invalid', 'valid');
                        if (passwordStrength) passwordStrength.classList.remove('has-errors');
                    }
                    
                    // Check password match
                    if (confirmInput && confirmInput.value.length > 0) {
                        checkPasswordMatch();
                    }
                    
                    updateSubmitButton();
                });
            }
            
            // Confirm password validation
            if (confirmInput) {
                confirmInput.addEventListener('input', function() {
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
                if (!passwordInput || !confirmInput || !matchIndicator) return;
                
                const password = passwordInput.value;
                const confirmPassword = confirmInput.value;
                
                if (confirmPassword.length > 0) {
                    if (password === confirmPassword) {
                        confirmInput.classList.remove('invalid');
                        confirmInput.classList.add('valid');
                        matchIndicator.style.display = 'none';
                    } else {
                        confirmInput.classList.add('invalid');
                        confirmInput.classList.remove('valid');
                        matchIndicator.style.display = 'flex';
                    }
                } else {
                    confirmInput.classList.remove('invalid', 'valid');
                    matchIndicator.style.display = 'none';
                }
            }
            
            function updateSubmitButton() {
                if (!submitBtn || !passwordInput || !confirmInput) return;
                
                const allValid = Object.values(passwordRules).every(rule => rule === true);
                const passwordsMatch = passwordInput.value === confirmInput.value && confirmInput.value.length > 0;
                
                if (allValid && passwordsMatch) {
                    submitBtn.disabled = false;
                } else {
                    submitBtn.disabled = true;
                }
            }
            
            // Prevent form submit if validation fails
            const form = document.getElementById('update-password-form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const allValid = Object.values(passwordRules).every(rule => rule === true);
                    const passwordsMatch = passwordInput.value === confirmInput.value;
                    
                    if (!allValid || !passwordsMatch) {
                        e.preventDefault();
                        alert('Pastikan password memenuhi semua kriteria dan konfirmasi password cocok');
                        return false;
                    }
                    
                    // Disable button and show loading
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="ph ph-spinner" style="animation: spin 1s linear infinite;"></i> Menyimpan...';
                });
            }
        });
    </script>
    
    <style>
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>
