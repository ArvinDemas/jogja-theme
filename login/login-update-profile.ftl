<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lengkapi Profil - Portal Pemda DIY</title>
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
                    <span class="slide-tag">Hampir Selesai</span>
                    <h2 class="slide-title">Lengkapi Profil Anda</h2>
                    <p class="slide-desc">Kami membutuhkan beberapa informasi tambahan untuk menyelesaikan pendaftaran akun Anda.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Lengkapi Profil Anda</h2>
                    <p>Beberapa informasi diperlukan untuk melanjutkan</p>
                </div>

                <#-- INFO BOX -->
                <div class="alert alert-info" style="margin-bottom: 20px;">
                    <i class="ph ph-info"></i>
                    <span>
                        <#if user.username??>
                            Anda login dengan <strong>${user.username}</strong>.
                        </#if>
                        Harap lengkapi data berikut untuk melanjutkan.
                    </span>
                </div>

                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <#if message.type = 'success'><i class="ph ph-check-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <form action="${url.loginAction}" method="post" id="update-profile-form">
                    
                    <#-- USERNAME (if not provided by social login) -->
                    <#if user.editUsernameAllowed?? && user.editUsernameAllowed && !user.username??>
                        <div class="form-group">
                            <label class="form-label">
                                Username <span style="color: #ef4444;">*</span>
                            </label>
                            <div class="input-wrapper">
                                <input type="text" 
                                       id="username" 
                                       name="username" 
                                       class="form-input" 
                                       value="${(user.username!'')}" 
                                       placeholder="nama.anda"
                                       required
                                       autocomplete="off" />
                                <i class="ph ph-user input-icon"></i>
                            </div>
                            <p style="font-size: 0.75rem; color: #64748b; margin-top: 6px;">
                                Username akan digunakan untuk login ke sistem
                            </p>
                        </div>
                    </#if>

                    <#-- EMAIL (if not provided or needs update) -->
                    <#if user.editEmailAllowed?? && user.editEmailAllowed>
                        <div class="form-group">
                            <label class="form-label">
                                Email <span style="color: #ef4444;">*</span>
                            </label>
                            <div class="input-wrapper">
                                <input type="email" 
                                       id="email" 
                                       name="email" 
                                       class="form-input" 
                                       value="${(user.email!'')}" 
                                       placeholder="email@jogjaprov.go.id"
                                       required
                                       autocomplete="off" />
                                <i class="ph ph-envelope input-icon"></i>
                            </div>
                        </div>
                    </#if>

                    <#-- FIRST NAME (required) -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                Nama Depan <span style="color: #ef4444;">*</span>
                            </label>
                            <div class="input-wrapper">
                                <input type="text" 
                                       id="firstName" 
                                       name="firstName" 
                                       class="form-input" 
                                       value="${(user.firstName!'')}" 
                                       placeholder="Nama Depan"
                                       required
                                       autocomplete="off" />
                            </div>
                        </div>

                        <#-- LAST NAME (optional but recommended) -->
                        <div class="form-group">
                            <label class="form-label">
                                Nama Belakang
                            </label>
                            <div class="input-wrapper">
                                <input type="text" 
                                       id="lastName" 
                                       name="lastName" 
                                       class="form-input" 
                                       value="${(user.lastName!'')}" 
                                       placeholder="Nama Belakang"
                                       autocomplete="off" />
                            </div>
                        </div>
                    </div>

                    <#-- ADDITIONAL ATTRIBUTES (if configured) -->
                    <#if user.attributes??>
                        <#list user.attributes as attribute>
                            <div class="form-group">
                                <label class="form-label">
                                    ${attribute.displayName!''}
                                    <#if attribute.required?? && attribute.required>
                                        <span style="color: #ef4444;">*</span>
                                    </#if>
                                </label>
                                <div class="input-wrapper">
                                    <input type="text" 
                                           name="${attribute.name}" 
                                           class="form-input" 
                                           value="${(attribute.value!'')}"
                                           <#if attribute.required?? && attribute.required>required</#if>
                                           autocomplete="off" />
                                </div>
                            </div>
                        </#list>
                    </#if>

                    <#-- INFO ABOUT SOCIAL LOGIN -->
                    <div style="background: #f0f9ff; border-left: 4px solid #0ea5e9; padding: 15px; border-radius: 8px; margin: 20px 0;">
                        <p style="font-size: 0.85rem; color: #0c4a6e; line-height: 1.6; margin: 0;">
                            <strong>ℹ️ Catatan:</strong> Data ini diperlukan karena akun social login Anda 
                            <#if user.username??>
                                (<strong>${user.username}</strong>)
                            </#if>
                            tidak menyediakan informasi lengkap. Data ini hanya akan disimpan di sistem kami dan tidak akan dibagikan.
                        </p>
                    </div>

                    <#-- SUBMIT BUTTON -->
                    <button type="submit" class="main-btn" id="submit-btn">
                        <i class="ph ph-check-circle"></i>
                        Simpan & Lanjutkan
                    </button>
                </form>

                <#-- CANCEL OPTION (if allowed) -->
                <div class="bottom-text" style="margin-top: 20px;">
                    <a href="${url.loginRestartFlowUrl}" style="color: #64748b; text-decoration: none; font-size: 0.85rem;">
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
        // Auto-populate username from email if empty
        document.addEventListener('DOMContentLoaded', function() {
            const emailInput = document.getElementById('email');
            const usernameInput = document.getElementById('username');
            
            if (emailInput && usernameInput && !usernameInput.value) {
                emailInput.addEventListener('blur', function() {
                    const email = this.value;
                    if (email && !usernameInput.value) {
                        // Suggest username from email (before @)
                        const suggestedUsername = email.split('@')[0].toLowerCase().replace(/[^a-z0-9._-]/g, '');
                        usernameInput.value = suggestedUsername;
                    }
                });
            }
            
            // Validate form before submit
            const form = document.getElementById('update-profile-form');
            form.addEventListener('submit', function(e) {
                const firstName = document.getElementById('firstName');
                if (firstName && !firstName.value.trim()) {
                    e.preventDefault();
                    alert('Nama Depan wajib diisi');
                    firstName.focus();
                    return false;
                }
            });
        });
    </script>
    
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>
