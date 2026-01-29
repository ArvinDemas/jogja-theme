<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Akun - Portal Pemda DIY</title>
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
    <div class="container">
        
        <#-- BAGIAN KIRI: VISUAL WITH SECURITY TIPS -->
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
                    <br> <br> <br>
                    <div class="tips-badge">Tips Nyaman Karena Aman</div>
                    
                    <div class="tips-list">
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-shield-check" weight="fill"></i>
                            </div>
                            <p>Jaga kerahasiaan akun Anda dan tidak membagikan password kepada orang lain</p>
                        </div>
                        
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-device-mobile" weight="fill"></i>
                            </div>
                            <p>Gunakan 2FA (Two Factor Authentication) hanya pada perangkat pribadi</p>
                        </div>
                        
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-arrow-clockwise" weight="fill"></i>
                            </div>
                            <p>Selalu mengganti password Anda secara berkala</p>
                        </div>
                        
                        <div class="tip-item">
                            <div class="tip-icon">
                                <i class="ph ph-lock-key" weight="fill"></i>
                            </div>
                            <p>Hindari password yang mudah ditebak. Gunakan kombinasi huruf besar, huruf kecil, simbol dan angka, dengan panjang minimal 12 karakter</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <#-- BAGIAN KANAN: FORM REGISTER -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>
            
            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Buat Akun Baru</h2>
                    <p>Lengkapi data diri untuk bergabung</p>
                </div>

                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <#if message.type = 'success'><i class="ph ph-check-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <form action="${url.registrationAction}" method="post" autocomplete="off" id="register-form">
                    
                    <#-- ROW: NAMA DEPAN & BELAKANG -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Nama Depan</label>
                            <div class="input-wrapper">
                                <input type="text" name="firstName" class="form-input" value="${(register.formData.firstName!'')}" placeholder="Nama Depan" autocomplete="off" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Nama Belakang</label>
                            <div class="input-wrapper">
                                <input type="text" name="lastName" class="form-input" value="${(register.formData.lastName!'')}" placeholder="Nama Belakang" autocomplete="off" />
                            </div>
                        </div>
                    </div>

                    <#-- EMAIL -->
                    <div class="form-group">
                        <label class="form-label">Email Aktif</label>
                        <div class="input-wrapper">
                            <input type="email" name="email" class="form-input" value="${(register.formData.email!'')}" placeholder="email@jogjaprov.go.id" autocomplete="off" required />
                            <i class="ph ph-envelope input-icon"></i>
                        </div>
                    </div>

                    <#-- USERNAME -->
                    <#if !realm.registrationEmailAsUsername>
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <div class="input-wrapper">
                                <input type="text" name="username" class="form-input" value="${(register.formData.username!'')}" placeholder="nama.anda" autocomplete="off" required />
                                <i class="ph ph-user input-icon"></i>
                            </div>
                        </div>
                    </#if>

                    <#-- PASSWORD -->
                    <div class="form-group">
                        <label class="form-label">Buat Password</label>
                        <div class="input-wrapper">
                            <input type="password" name="password" id="reg-pass" class="form-input" placeholder="Minimal 8 karakter" autocomplete="off" required />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('reg-pass')"></i>
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
                        <label class="form-label">Konfirmasi Password</label>
                        <div class="input-wrapper">
                            <input type="password" name="password-confirm" id="reg-confirm" class="form-input" placeholder="Ulangi password" autocomplete="off" required />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('reg-confirm')"></i>
                        </div>
                        <div class="password-match-indicator" id="match-indicator" style="display: none;">
                            <i class="ph ph-x-circle"></i>
                            <span>Password tidak cocok</span>
                        </div>
                    </div>

                    <#-- RECAPTCHA -->
                    <#if recaptchaRequired??>
                        <div class="form-group">
                            <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}"></div>
                        </div>
                    </#if>

                    <#-- PRIVACY POLICY CHECKBOX -->
                    <div class="form-group">
                        <div class="privacy-checkbox">
                            <input type="checkbox" id="privacy-accept" name="privacy-accept" required />
                            <label for="privacy-accept">
                                Saya menyetujui <a href="https://drive.google.com/file/d/1nvLDfcjULstrpKbt-8o3nSY23FgCMxl4/view" target="_blank" class="privacy-link">Kebijakan Privasi</a> dan <a href="https://wiki.jogjaprov.go.id/diskominfo/panduan/panduan-2fa" target="_blank" class="privacy-link">Ketentuan Layanan</a>
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="main-btn" id="submit-btn" disabled>Daftar Sekarang</button>
                </form>

                <div class="bottom-text">
                    Sudah punya akun? <a href="${url.loginUrl}">Masuk Disini</a>
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
