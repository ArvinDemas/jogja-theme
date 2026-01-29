<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verifikasi Dua Langkah - Portal Pemda DIY</title>
    
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    
    <style>
        /* OTP Verification Styles */
        .otp-boxes-container {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin: 25px 0;
        }
        
        .otp-box {
            width: 50px;
            height: 60px;
            border: 2px solid #cbd5e1;
            border-radius: 12px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: 700;
            font-family: 'Courier New', monospace;
            color: #0f172a;
            background: white;
            transition: all 0.3s ease;
        }
        
        .otp-box:focus {
            border-color: #0ea5e9;
            outline: none;
            box-shadow: 0 0 0 4px rgba(14, 165, 233, 0.1);
        }
        
        .otp-box.filled {
            border-color: #10b981;
            background: #f0fdf4;
        }
        
        .otp-hidden-input {
            position: absolute;
            opacity: 0;
            pointer-events: none;
        }
        
        .otp-info-box {
            background: #eff6ff;
            border-left: 4px solid #0ea5e9;
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        
        .otp-info-box i {
            font-size: 1.3rem;
            color: #0ea5e9;
            flex-shrink: 0;
            margin-top: 2px;
        }
        
        .otp-info-box p {
            font-size: 0.85rem;
            color: #334155;
            line-height: 1.6;
            margin: 0;
        }
        
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }
        
        .btn-secondary {
            flex: 1;
            padding: 14px;
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }
        
        .btn-secondary:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
            color: #475569;
        }
        
        .btn-primary {
            flex: 2;
        }
        
        .alternative-methods {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
            text-align: center;
        }
        
        .alternative-methods p {
            font-size: 0.85rem;
            color: #64748b;
            margin-bottom: 12px;
        }
        
        .alternative-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #0ea5e9;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .alternative-link:hover {
            background: #f0f9ff;
            color: #0284c7;
        }
    </style>
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
                    <h2 class="slide-title">Verifikasi Dua Langkah</h2>
                    <p class="slide-desc">Lapisan keamanan ekstra untuk melindungi akun Anda. Kode OTP memastikan hanya Anda yang dapat mengakses akun ini.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Masukkan Kode OTP</h2>
                    <p>Buka aplikasi authenticator Anda dan masukkan 6 digit kode</p>
                </div>

                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <form action="${url.loginAction}" method="post" id="kc-otp-login-form">
                    <div class="form-group">
                        <label class="form-label" style="text-align: center; display: block; margin-bottom: 10px;">Kode OTP (6 Digit)</label>
                        <div class="otp-boxes-container">
                            <input type="text" class="otp-box" maxlength="1" pattern="[0-9]" inputmode="numeric" data-index="0" autocomplete="off" />
                            <input type="text" class="otp-box" maxlength="1" pattern="[0-9]" inputmode="numeric" data-index="1" autocomplete="off" />
                            <input type="text" class="otp-box" maxlength="1" pattern="[0-9]" inputmode="numeric" data-index="2" autocomplete="off" />
                            <input type="text" class="otp-box" maxlength="1" pattern="[0-9]" inputmode="numeric" data-index="3" autocomplete="off" />
                            <input type="text" class="otp-box" maxlength="1" pattern="[0-9]" inputmode="numeric" data-index="4" autocomplete="off" />
                            <input type="text" class="otp-box" maxlength="1" pattern="[0-9]" inputmode="numeric" data-index="5" autocomplete="off" />
                        </div>
                        <input type="hidden" id="otp" name="otp" class="otp-hidden-input" autocomplete="off" />
                    </div>

                    <div class="otp-info-box">
                        <i class="ph ph-info-circle" weight="fill"></i>
                        <p><strong>Kode berubah setiap 30 detik.</strong> Gunakan kode terbaru dari aplikasi authenticator Anda.</p>
                    </div>

                    <#if auth.selectedCredential?has_content>
                        <input type="hidden" id="credentialId" name="credentialId" value="${auth.selectedCredential}" />
                    </#if>

                    <div class="button-group">
                        <a href="${url.loginRestartFlowUrl}" class="btn-secondary">
                            <i class="ph ph-arrow-left"></i>
                            Kembali
                        </a>
                        <button type="submit" class="main-btn btn-primary" id="kc-login">
                            <i class="ph ph-check-circle"></i>
                            Verifikasi
                        </button>
                    </div>
                </form>

                <div class="alternative-methods">
                    <p>Tidak bisa mengakses authenticator?</p>
                    <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" class="alternative-link">
                        <i class="ph ph-chat-circle-dots"></i>
                        Gunakan Backup Code
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

    <script>
        // OTP Box Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const otpBoxes = document.querySelectorAll('.otp-box');
            const hiddenInput = document.getElementById('otp');
            
            otpBoxes.forEach((box, index) => {
                box.addEventListener('input', function(e) {
                    const value = e.target.value;
                    
                    // Only allow numbers
                    if (!/^[0-9]$/.test(value)) {
                        e.target.value = '';
                        return;
                    }
                    
                    // Add filled class
                    if (value) {
                        e.target.classList.add('filled');
                    } else {
                        e.target.classList.remove('filled');
                    }
                    
                    // Update hidden input
                    updateHiddenInput();
                    
                    // Move to next box
                    if (value && index < otpBoxes.length - 1) {
                        otpBoxes[index + 1].focus();
                    }
                    
                    // Auto-submit when all boxes are filled
                    if (index === otpBoxes.length - 1 && value) {
                        const allFilled = Array.from(otpBoxes).every(b => b.value.length > 0);
                        if (allFilled) {
                            setTimeout(() => {
                                document.getElementById('kc-otp-login-form').submit();
                            }, 300);
                        }
                    }
                });
                
                box.addEventListener('keydown', function(e) {
                    // Handle backspace
                    if (e.key === 'Backspace' && !e.target.value && index > 0) {
                        otpBoxes[index - 1].focus();
                        otpBoxes[index - 1].value = '';
                        otpBoxes[index - 1].classList.remove('filled');
                        updateHiddenInput();
                    }
                    
                    // Handle arrow keys
                    if (e.key === 'ArrowLeft' && index > 0) {
                        otpBoxes[index - 1].focus();
                    }
                    if (e.key === 'ArrowRight' && index < otpBoxes.length - 1) {
                        otpBoxes[index + 1].focus();
                    }
                });
                
                // Handle paste
                box.addEventListener('paste', function(e) {
                    e.preventDefault();
                    const pastedData = e.clipboardData.getData('text').slice(0, 6);
                    const digits = pastedData.match(/[0-9]/g);
                    
                    if (digits) {
                        digits.forEach((digit, i) => {
                            if (i < otpBoxes.length) {
                                otpBoxes[i].value = digit;
                                otpBoxes[i].classList.add('filled');
                            }
                        });
                        updateHiddenInput();
                        
                        // Focus last filled box or next empty
                        const lastIndex = Math.min(digits.length, otpBoxes.length - 1);
                        otpBoxes[lastIndex].focus();
                        
                        // Auto-submit if all filled
                        if (digits.length === 6) {
                            setTimeout(() => {
                                document.getElementById('kc-otp-login-form').submit();
                            }, 300);
                        }
                    }
                });
            });
            
            function updateHiddenInput() {
                let code = '';
                otpBoxes.forEach(box => {
                    code += box.value;
                });
                hiddenInput.value = code;
            }
            
            // Focus first box on load
            if (otpBoxes.length > 0) {
                otpBoxes[0].focus();
            }
        });
    </script>
</body>
</html>
