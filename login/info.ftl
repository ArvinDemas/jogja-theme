<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informasi - Portal Pemda DIY</title>
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
                    <span class="slide-tag">Transformasi Digital</span>
                    <h2 class="slide-title">Yogyakarta Istimewa</h2>
                    <p class="slide-desc">Mengintegrasikan teknologi informasi dalam tata kelola pemerintahan untuk mewujudkan pelayanan publik yang transparan.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                <#if message?has_content>
                    <div class="info-message-box">
                        <#if message.type = 'success'>
                            <div class="info-icon success">
                                <i class="ph ph-check-circle" weight="fill"></i>
                            </div>
                        <#elseif message.type = 'warning'>
                            <div class="info-icon warning">
                                <i class="ph ph-warning-circle" weight="fill"></i>
                            </div>
                        <#elseif message.type = 'error'>
                            <div class="info-icon error">
                                <i class="ph ph-x-circle" weight="fill"></i>
                            </div>
                        <#else>
                            <div class="info-icon info">
                                <i class="ph ph-info" weight="fill"></i>
                            </div>
                        </#if>
                        
                        <h2 class="info-title">${message.summary?no_esc}</h2>
                        
                        <#if message.type = 'success'>
                            <p class="info-desc">Silakan cek email Anda untuk verifikasi akun. Jika tidak menemukan email, periksa folder spam.</p>
                        <#elseif message.type = 'error'>
                            <p class="info-desc">Mohon periksa kembali data Anda dan coba lagi.</p>
                        </#if>
                    </div>
                </#if>

                <#if skipLink??>
                <#else>
                    <#if pageRedirectUri?has_content>
                        <a href="${pageRedirectUri}" class="main-btn">Kembali ke Aplikasi</a>
                    <#elseif actionUri?has_content>
                        <a href="${actionUri}" class="main-btn">Lanjutkan</a>
                    <#elseif client.baseUrl?has_content>
                        <a href="${client.baseUrl}" class="main-btn">Kembali ke Aplikasi</a>
                    </#if>
                </#if>

                <div class="bottom-text">
                    <a href="${url.loginUrl}">Kembali ke Halaman Login</a>
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
</body>
</html>
