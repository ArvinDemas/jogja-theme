<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Akun Dinonaktifkan - Portal Pemda DIY</title>
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
                    <h2 class="slide-title">Akses Ditangguhkan</h2>
                    <p class="slide-desc">Akun Anda sementara tidak dapat diakses untuk menjaga keamanan sistem.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                
                <#-- LOCK ICON -->
                <div style="text-align: center; margin-bottom: 25px;">
                    <i class="ph ph-lock" weight="fill" style="font-size: 4rem; color: #f59e0b; margin-bottom: 15px;"></i>
                    <h2 style="font-size: 1.5rem; color: #0f172a; margin-bottom: 10px;">
                        Akun Dinonaktifkan
                    </h2>
                </div>

                <#-- ERROR MESSAGE -->
                <#if message?has_content>
                    <div class="alert alert-warning" style="margin-bottom: 25px;">
                        <i class="ph ph-warning-circle"></i>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <#-- REASON EXPLANATION -->
                <div style="background: #fffbeb; border-left: 4px solid #f59e0b; padding: 20px; border-radius: 10px; margin-bottom: 25px;">
                    <h4 style="font-size: 0.95rem; font-weight: 700; color: #92400e; margin-bottom: 12px;">
                        Mengapa akun saya dinonaktifkan?
                    </h4>
                    <p style="font-size: 0.85rem; color: #78350f; line-height: 1.6; margin: 0;">
                        Akun Anda mungkin dinonaktifkan karena salah satu alasan berikut:
                    </p>
                    <ul style="margin: 12px 0 0 20px; color: #78350f; line-height: 1.8; font-size: 0.85rem;">
                        <li><strong>Terlalu banyak percobaan login gagal</strong> - Akun dikunci sementara untuk keamanan</li>
                        <li><strong>Aktivitas mencurigakan terdeteksi</strong> - Login dari lokasi atau perangkat tidak biasa</li>
                        <li><strong>Pelanggaran kebijakan</strong> - Akun ditangguhkan oleh administrator</li>
                        <li><strong>Tidak aktif dalam waktu lama</strong> - Akun dormant perlu diaktifkan kembali</li>
                        <li><strong>Permintaan pengguna</strong> - Anda atau administrator menonaktifkan akun</li>
                    </ul>
                </div>

                <#-- SOLUTIONS -->
                <div style="background: #f8fafc; border-radius: 12px; padding: 20px; margin-bottom: 20px;">
                    <h4 style="font-size: 0.9rem; font-weight: 700; color: #0f172a; margin-bottom: 12px;">
                        Apa yang harus saya lakukan?
                    </h4>
                    
                    <div style="display: flex; flex-direction: column; gap: 15px;">
                        <#-- Option 1: Wait -->
                        <div style="display: flex; gap: 12px; align-items: flex-start;">
                            <div style="min-width: 30px; height: 30px; background: linear-gradient(135deg, #0ea5e9, #0284c7); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">1</div>
                            <div>
                                <h5 style="font-size: 0.85rem; font-weight: 600; color: #0f172a; margin: 0 0 4px 0;">
                                    Tunggu Beberapa Saat
                                </h5>
                                <p style="font-size: 0.8rem; color: #64748b; line-height: 1.5; margin: 0;">
                                    Jika akun dikunci karena terlalu banyak percobaan gagal, akun akan otomatis aktif kembali dalam <strong>15-30 menit</strong>.
                                </p>
                            </div>
                        </div>

                        <#-- Option 2: Reset Password -->
                        <div style="display: flex; gap: 12px; align-items: flex-start;">
                            <div style="min-width: 30px; height: 30px; background: linear-gradient(135deg, #0ea5e9, #0284c7); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">2</div>
                            <div>
                                <h5 style="font-size: 0.85rem; font-weight: 600; color: #0f172a; margin: 0 0 4px 0;">
                                    Reset Password
                                </h5>
                                <p style="font-size: 0.8rem; color: #64748b; line-height: 1.5; margin: 0;">
                                    Gunakan fitur "Lupa Password" untuk reset akun dan membuat password baru. Ini mungkin akan membuka kembali akun Anda.
                                </p>
                            </div>
                        </div>

                        <#-- Option 3: Contact Admin -->
                        <div style="display: flex; gap: 12px; align-items: flex-start;">
                            <div style="min-width: 30px; height: 30px; background: linear-gradient(135deg, #0ea5e9, #0284c7); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem;">3</div>
                            <div>
                                <h5 style="font-size: 0.85rem; font-weight: 600; color: #0f172a; margin: 0 0 4px 0;">
                                    Hubungi Administrator
                                </h5>
                                <p style="font-size: 0.8rem; color: #64748b; line-height: 1.5; margin: 0;">
                                    Jika masalah berlanjut atau akun ditangguhkan oleh admin, hubungi tim support untuk bantuan lebih lanjut.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <#-- ACTION BUTTONS -->
                <div style="display: flex; flex-direction: column; gap: 12px;">
                    <#if url.loginResetCredentialsUrl??>
                        <a href="${url.loginResetCredentialsUrl}" class="main-btn">
                            <i class="ph ph-key"></i>
                            Reset Password
                        </a>
                    </#if>
                    
                    <a href="${url.loginUrl}" class="main-btn" style="background: white; color: #0f172a; border: 2px solid #e2e8f0;">
                        <i class="ph ph-arrow-left"></i>
                        Kembali ke Login
                    </a>
                    
                    <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" class="main-btn" style="background: linear-gradient(135deg, #5865f2, #4752c4);">
                        <i class="ph ph-chat-circle-dots"></i>
                        Hubungi Support
                    </a>
                </div>

                <#-- SECURITY INFO -->
                <div style="margin-top: 25px; padding: 15px; background: #f0f9ff; border-radius: 10px;">
                    <p style="font-size: 0.75rem; color: #0c4a6e; line-height: 1.6; margin: 0;">
                        <strong>🔒 Keamanan:</strong> Penonaktifan akun adalah langkah keamanan untuk melindungi data Anda. 
                        Jika Anda tidak merasa melakukan aktivitas yang mencurigakan, segera hubungi administrator 
                        untuk mengamankan akun Anda.
                    </p>
                </div>

                <#-- FOOTER LINKS -->
                <div class="footer-links" style="margin-top: 25px;">
                    <a href="https://wiki.jogjaprov.go.id/diskominfo/panduan/panduan-2fa" target="_blank" class="footer-link">
                        <i class="ph ph-shield-check"></i>
                        <span>Panduan Keamanan</span>
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
