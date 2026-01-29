<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terjadi Kesalahan - Portal Pemda DIY</title>
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
                    <span class="slide-tag">Portal SSO</span>
                    <h2 class="slide-title">Terjadi Kesalahan</h2>
                    <p class="slide-desc">Jangan khawatir, kami akan membantu Anda menyelesaikan masalah ini.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                
                <#-- ERROR ICON & TITLE -->
                <div style="text-align: center; margin-bottom: 25px;">
                    <#if message?? && message.type == 'error'>
                        <i class="ph ph-warning-circle" weight="fill" style="font-size: 4rem; color: #ef4444; margin-bottom: 15px;"></i>
                    <#elseif message?? && message.type == 'warning'>
                        <i class="ph ph-warning" weight="fill" style="font-size: 4rem; color: #f59e0b; margin-bottom: 15px;"></i>
                    <#else>
                        <i class="ph ph-info" weight="fill" style="font-size: 4rem; color: #0ea5e9; margin-bottom: 15px;"></i>
                    </#if>
                    
                    <h2 style="font-size: 1.5rem; color: #0f172a; margin-bottom: 10px;">
                        <#if message?? && message.summary??>
                            ${kcSanitize(message.summary)?no_esc}
                        <#else>
                            Terjadi Kesalahan
                        </#if>
                    </h2>
                </div>

                <#-- ERROR MESSAGE -->
                <#if message?? && message.type??>
                    <div class="alert alert-${message.type}" style="margin-bottom: 25px;">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <#if message.type = 'warning'><i class="ph ph-warning-circle"></i></#if>
                        <#if message.type = 'info'><i class="ph ph-info"></i></#if>
                        <span>
                            <#if message.summary??>
                                ${kcSanitize(message.summary)?no_esc}
                            <#else>
                                Terjadi kesalahan yang tidak terduga. Silakan coba lagi.
                            </#if>
                        </span>
                    </div>
                </#if>

                <#-- SPECIFIC ERROR HANDLING -->
                <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
                    <h4 style="font-size: 0.9rem; font-weight: 700; color: #0f172a; margin-bottom: 12px;">
                        Apa yang bisa Anda lakukan?
                    </h4>
                    
                    <#-- Check for specific error types -->
                    <#if message?? && message.summary??>
                        <#assign errorMsg = message.summary?lower_case>
                        
                        <#-- Session Expired -->
                        <#if errorMsg?contains("expired") || errorMsg?contains("session") || errorMsg?contains("timeout")>
                            <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                                <li>Sesi Anda telah berakhir karena tidak aktif terlalu lama</li>
                                <li>Klik tombol "Kembali ke Login" di bawah untuk masuk kembali</li>
                                <li>Untuk keamanan, Anda akan diminta memasukkan kredensial lagi</li>
                            </ul>
                        
                        <#-- Invalid Credentials -->
                        <#elseif errorMsg?contains("invalid") || errorMsg?contains("incorrect") || errorMsg?contains("salah")>
                            <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                                <li>Periksa kembali username/email dan password Anda</li>
                                <li>Pastikan Caps Lock tidak aktif</li>
                                <li>Jika lupa password, klik "Lupa Password?" di halaman login</li>
                            </ul>
                        
                        <#-- Account Locked -->
                        <#elseif errorMsg?contains("locked") || errorMsg?contains("disabled") || errorMsg?contains("terkunci")>
                            <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                                <li>Akun Anda telah dikunci karena terlalu banyak percobaan login gagal</li>
                                <li>Tunggu beberapa menit atau hubungi administrator</li>
                                <li>Atau gunakan fitur "Lupa Password" untuk reset akun</li>
                            </ul>
                        
                        <#-- Email/Username Exists -->
                        <#elseif errorMsg?contains("already") || errorMsg?contains("exists") || errorMsg?contains("sudah ada")>
                            <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                                <li>Email atau username yang Anda gunakan sudah terdaftar</li>
                                <li>Coba login menggunakan email/username tersebut</li>
                                <li>Atau gunakan email/username yang berbeda untuk registrasi</li>
                            </ul>
                        
                        <#-- Network/Server Error -->
                        <#elseif errorMsg?contains("network") || errorMsg?contains("connection") || errorMsg?contains("server")>
                            <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                                <li>Periksa koneksi internet Anda</li>
                                <li>Coba refresh halaman (F5 atau Ctrl+R)</li>
                                <li>Jika masalah berlanjut, server mungkin sedang maintenance</li>
                            </ul>
                        
                        <#-- Browser Not Supported -->
                        <#elseif errorMsg?contains("browser") || errorMsg?contains("not supported")>
                            <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                                <li>Browser Anda tidak didukung atau versinya terlalu lama</li>
                                <li>Update browser ke versi terbaru</li>
                                <li>Atau gunakan Chrome, Firefox, Safari, atau Edge versi terbaru</li>
                            </ul>
                        
                        <#-- Default Generic Error -->
                        <#else>
                            <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                                <li>Coba refresh halaman (F5 atau Ctrl+R)</li>
                                <li>Clear cache dan cookies browser Anda</li>
                                <li>Coba gunakan browser yang berbeda</li>
                                <li>Jika masalah berlanjut, hubungi tim support</li>
                            </ul>
                        </#if>
                    <#else>
                        <#-- No specific error message -->
                        <ul style="margin-left: 20px; color: #475569; line-height: 1.8; font-size: 0.85rem;">
                            <li>Coba refresh halaman (F5 atau Ctrl+R)</li>
                            <li>Clear cache dan cookies browser Anda</li>
                            <li>Coba gunakan browser yang berbeda</li>
                            <li>Jika masalah berlanjut, hubungi tim support</li>
                        </ul>
                    </#if>
                </div>

                <#-- ACTION BUTTONS -->
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <#if skipLink??>
                        <#-- Skip link provided -->
                    <#elseif client.baseUrl?has_content>
                        <a href="${client.baseUrl}" class="main-btn">
                            <i class="ph ph-arrow-left"></i>
                            Kembali ke Aplikasi
                        </a>
                    </#if>
                    
                    <a href="${url.loginUrl}" class="main-btn">
                        <i class="ph ph-sign-in"></i>
                        Kembali ke Login
                    </a>
                    
                    <button type="button" onclick="window.location.reload()" class="main-btn" style="background: white; color: #0f172a; border: 2px solid #e2e8f0;">
                        <i class="ph ph-arrow-clockwise"></i>
                        Coba Lagi
                    </button>
                </div>

                <#-- ERROR CODE (for debugging/support) -->
                <#if message?? && message.summary??>
                    <div style="margin-top: 25px; padding-top: 20px; border-top: 1px solid #e2e8f0; text-align: center;">
                        <p style="font-size: 0.75rem; color: #94a3b8; margin-bottom: 8px;">
                            Kode Error (untuk referensi support):
                        </p>
                        <code style="background: #f1f5f9; padding: 6px 12px; border-radius: 6px; font-size: 0.75rem; color: #64748b;">
                            ${message.type!"UNKNOWN"}_${.now?string("yyyyMMddHHmmss")}
                        </code>
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
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>
