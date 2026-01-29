<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lupa Password - Portal Pemda DIY</title>
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
                <div class="carousel-slide active">
                    <span class="slide-tag">Keamanan Akun</span>
                    <h2 class="slide-title">Reset Password</h2>
                    <p class="slide-desc">Kami akan mengirimkan link reset password ke email Anda yang terdaftar.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Lupa Password?</h2>
                    <p>Masukkan username atau email Anda untuk reset password</p>
                </div>

                <#-- SUCCESS MESSAGE (if email sent) -->
                <#if message?has_content && message.type = 'success'>
                    <div class="alert alert-success" style="margin-bottom: 20px;">
                        <i class="ph ph-check-circle"></i>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                    
                    <div style="background: #f0fdf4; border-left: 4px solid #10b981; padding: 20px; border-radius: 10px; margin-bottom: 25px;">
                        <h4 style="font-size: 0.95rem; font-weight: 700; color: #065f46; margin-bottom: 12px;">
                            ✅ Email Terkirim!
                        </h4>
                        <p style="font-size: 0.85rem; color: #047857; line-height: 1.6; margin: 0 0 12px 0;">
                            Kami telah mengirimkan link reset password ke email Anda. Silakan:
                        </p>
                        <ul style="margin: 0 0 0 20px; color: #047857; line-height: 1.8; font-size: 0.85rem;">
                            <li>Cek inbox email Anda</li>
                            <li>Jika tidak ada, periksa folder <strong>Spam</strong> atau <strong>Junk</strong></li>
                            <li>Klik link yang ada di email (valid selama <strong>5 menit</strong>)</li>
                            <li>Ikuti instruksi untuk membuat password baru</li>
                        </ul>
                    </div>

                    <a href="${url.loginUrl}" class="main-btn">
                        <i class="ph ph-arrow-left"></i>
                        Kembali ke Login
                    </a>
                
                <#-- ERROR MESSAGE -->
                <#elseif message?has_content && message.type = 'error'>
                    <div class="alert alert-error" style="margin-bottom: 20px;">
                        <i class="ph ph-x-circle"></i>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                    
                    <#-- Show form again after error -->
                    <#include "reset-password-form-content.ftl">
                
                <#-- DEFAULT: Show form -->
                <#else>
                    <form action="${url.loginAction}" method="post" id="reset-password-form">
                        <div class="form-group">
                            <label class="form-label">Username atau Email</label>
                            <div class="input-wrapper">
                                <input type="text" 
                                       id="username" 
                                       name="username" 
                                       class="form-input" 
                                       placeholder="username atau email@jogjaprov.go.id"
                                       autofocus 
                                       required
                                       autocomplete="off" />
                                <i class="ph ph-user input-icon"></i>
                            </div>
                            <p style="font-size: 0.75rem; color: #64748b; margin-top: 6px;">
                                Masukkan username atau email yang Anda gunakan saat registrasi
                            </p>
                        </div>

                        <#-- CAPTCHA (if enabled) -->
                        <#if recaptchaRequired??>
                            <div class="form-group">
                                <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}"></div>
                            </div>
                        </#if>

                        <button type="submit" class="main-btn" id="submit-btn">
                            <i class="ph ph-paper-plane-tilt"></i>
                            Kirim Link Reset Password
                        </button>
                    </form>

                    <#-- INFO BOX -->
                    <div style="background: #eff6ff; border-left: 4px solid #0ea5e9; padding: 15px; border-radius: 10px; margin: 20px 0;">
                        <p style="font-size: 0.85rem; color: #1e40af; line-height: 1.6; margin: 0;">
                            <strong>ℹ️ Catatan:</strong> Link reset password akan dikirim ke email yang terdaftar. 
                            Link ini hanya berlaku selama <strong>5 menit</strong> dan hanya bisa digunakan sekali.
                        </p>
                    </div>

                    <#-- SECURITY TIPS -->
                    <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
                        <h4 style="font-size: 0.9rem; font-weight: 700; color: #0f172a; margin-bottom: 12px;">
                            Tips Keamanan
                        </h4>
                        <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                            <li>Jangan bagikan link reset password ke orang lain</li>
                            <li>Pastikan email yang Anda akses adalah milik Anda</li>
                            <li>Gunakan password yang kuat (min. 8 karakter, huruf besar, angka, simbol)</li>
                            <li>Jika tidak merasa meminta reset, abaikan email dan laporkan</li>
                        </ul>
                    </div>

                    <#-- ALTERNATIVE OPTIONS -->
                    <div style="text-align: center; padding: 20px 0; border-top: 1px solid #e2e8f0;">
                        <p style="font-size: 0.85rem; color: #64748b; margin-bottom: 12px;">
                            Tidak bisa mengakses email Anda?
                        </p>
                        <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" 
                           target="_blank" 
                           style="display: inline-flex; align-items: center; gap: 8px; color: #0ea5e9; text-decoration: none; font-size: 0.85rem; font-weight: 600;">
                            <i class="ph ph-chat-circle-dots"></i>
                            Hubungi Support untuk Bantuan
                        </a>
                    </div>
                </#if>

                <#-- BACK TO LOGIN -->
                <#if !(message?has_content && message.type = 'success')>
                    <div class="bottom-text" style="margin-top: 20px;">
                        Ingat password Anda? <a href="${url.loginUrl}">Kembali ke Login</a>
                    </div>
                </#if>

                <#-- FOOTER LINKS -->
                <div class="footer-links" style="margin-top: 25px;">
                    <a href="https://wiki.jogjaprov.go.id/diskominfo/panduan/panduan-2fa" target="_blank" class="footer-link">
                        <i class="ph ph-shield-check"></i>
                        <span>Panduan SSO/2FA</span>
                    </a>
                    <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" class="footer-link">
                        <i class="ph ph-chat-circle-dots"></i>
                        <span>Kontak Support</span>
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
    
    <#-- reCAPTCHA Script (if enabled) -->
    <#if recaptchaRequired??>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </#if>
    
    <script>
        // Prevent multiple submissions
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('reset-password-form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const submitBtn = document.getElementById('submit-btn');
                    const usernameInput = document.getElementById('username');
                    
                    // Validate username/email
                    if (!usernameInput.value.trim()) {
                        e.preventDefault();
                        alert('Silakan masukkan username atau email Anda');
                        usernameInput.focus();
                        return false;
                    }
                    
                    // Disable button and show loading
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<i class="ph ph-spinner" style="animation: spin 1s linear infinite;"></i> Mengirim...';
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
