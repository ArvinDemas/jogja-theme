<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Halaman Kadaluarsa - Portal Pemda DIY</title>
    <link href="${url.resourcesPath}/css/login.css" rel="stylesheet" />
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
                <div class="brand-text"><h1>Pemerintah Daerah</h1><p>Daerah Istimewa Yogyakarta</p></div>
            </div>
            <div class="carousel-container">
                <div class="carousel-slide active">
                    <span class="slide-tag">Portal SSO</span>
                    <h2 class="slide-title">Sesi Berakhir</h2>
                    <p class="slide-desc">Halaman telah kedaluwarsa karena tidak ada aktivitas. Silakan kembali ke halaman login untuk melanjutkan.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                
                <#-- EXPIRED ICON -->
                <div style="text-align: center; margin-bottom: 25px;">
                    <div style="width: 80px; height: 80px; margin: 0 auto 20px; background: linear-gradient(135deg, #fef3c7, #fde68a); border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                        <i class="ph ph-clock-countdown" style="font-size: 2.5rem; color: #d97706;"></i>
                    </div>
                    <h2 style="font-size: 1.6rem; color: #0f172a; margin-bottom: 8px; font-family: 'Playfair Display', serif;">
                        Halaman Kadaluarsa
                    </h2>
                    <p style="color: #64748b; font-size: 0.9rem; line-height: 1.5;">
                        Sesi pada halaman ini telah berakhir karena tidak ada aktivitas dalam waktu tertentu.
                    </p>
                </div>

                <#-- INFO BOX -->
                <div style="background: #fffbeb; border: 1px solid #fde68a; border-left: 4px solid #f59e0b; border-radius: 12px; padding: 16px; margin-bottom: 25px; display: flex; gap: 12px; align-items: flex-start;">
                    <i class="ph ph-info" style="font-size: 1.2rem; color: #d97706; flex-shrink: 0; margin-top: 2px;"></i>
                    <div>
                        <p style="font-size: 0.85rem; color: #92400e; font-weight: 600; margin: 0 0 4px 0;">Mengapa ini terjadi?</p>
                        <p style="font-size: 0.8rem; color: #a16207; margin: 0; line-height: 1.5;">
                            Untuk keamanan, halaman otomatis kedaluwarsa jika tidak ada aktivitas. Silakan ulangi proses dari awal.
                        </p>
                    </div>
                </div>

                <#-- WHAT TO DO -->
                <div style="background: #f8fafc; border-radius: 12px; padding: 18px; margin-bottom: 25px;">
                    <h4 style="font-size: 0.85rem; font-weight: 700; color: #0f172a; margin-bottom: 12px; font-family: 'Inter', sans-serif;">
                        <i class="ph ph-lightbulb" style="color: #f59e0b; margin-right: 6px;"></i>
                        Yang bisa Anda lakukan:
                    </h4>
                    <ul style="margin-left: 20px; color: #475569; line-height: 2; font-size: 0.85rem; font-family: 'Inter', sans-serif;">
                        <li>Klik <strong>"Lanjutkan"</strong> untuk melanjutkan proses yang tertunda</li>
                        <li>Atau klik <strong>"Kembali ke Login"</strong> untuk mulai dari awal</li>
                    </ul>
                </div>

                <#-- ACTION BUTTONS -->
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <#-- Restart login -->
                    <a id="loginRestartLink" href="${url.loginRestartFlowUrl}" class="main-btn">
                        <i class="ph ph-arrow-clockwise"></i>
                        Lanjutkan
                    </a>

                    <#-- Back to login -->
                    <a id="loginContinueLink" href="${url.loginAction}" class="main-btn" style="background: white; color: #0f172a; border: 2px solid #e2e8f0;">
                        <i class="ph ph-sign-in"></i>
                        Kembali ke Login
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
                        <span>Kontak Support</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script src="${url.resourcesPath}/js/login.js"></script>
</body>
</html>
