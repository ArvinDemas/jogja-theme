<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Portal Pemda DIY</title>
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
                <div class="carousel-slide">
                    <span class="slide-tag">Layanan Terintegrasi</span>
                    <h2 class="slide-title">Satu Akun untuk Semua</h2>
                    <p class="slide-desc">Akses ratusan layanan digital PEMDA DIY hanya dengan satu akun SSO. Praktis, cepat, dan terintegrasi.</p>
                </div>
                <div class="carousel-progress"><div class="progress-bar"></div></div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Selamat Datang</h2>
                    <p>Silakan masuk untuk mengakses dashboard layanan.</p>
                </div>

                <div class="auth-tabs">
                    <button class="tab-btn active" id="tab-pass">Kredensial</button>
                    <button class="tab-btn" id="tab-qr">QR Code</button>
                </div>

                <#-- FORM LOGIN -->
                <div id="form-credential">
                    <#if message?has_content && (message.type != 'warning')>
                        <div class="alert alert-${message.type}">
                            <#if message.type = 'success'><i class="ph ph-check-circle"></i></#if>
                            <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                            <span>${kcSanitize(message.summary)?no_esc}</span>
                        </div>
                    </#if>

                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <div class="form-group">
                            <label class="form-label"><#if !realm.loginWithEmailAllowed>Username<#elseif !realm.registrationEmailAsUsername>Email atau Username<#else>Email</#if></label>
                            <div class="input-wrapper">
                                <input tabindex="1" id="username" class="form-input" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" placeholder="Masukkan username/email" />
                                <i class="ph ph-user input-icon"></i>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Kata Sandi</label>
                            <div class="input-wrapper">
                                <input tabindex="2" id="password" class="form-input" name="password" type="password" autocomplete="off" placeholder="Masukkan kata sandi" />
                                <i class="ph ph-lock input-icon"></i>
                                <i class="ph ph-eye password-toggle" onclick="togglePassword('password')"></i>
                            </div>
                            <div class="links-row">
                                <#if realm.resetPasswordAllowed>
                                    <a tabindex="5" href="${url.loginResetCredentialsUrl}" class="link-text">Lupa Password?</a>
                                </#if>
                            </div>
                        </div>

                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <button tabindex="4" class="main-btn" name="login" id="kc-login" type="submit">Masuk Sekarang</button>
                    </form>

                    <#-- SOCIAL LOGIN (FACEBOOK, GITHUB, GOOGLE) -->
                    <#if social.providers??>
                        <div class="social-divider"><span>Atau masuk dengan</span></div>
                        <div class="social-login-grid">
                            <#list social.providers as p>
                                <a id="social-${p.alias}" class="social-btn" href="${p.loginUrl}">
                                    <#if p.alias == "facebook">
                                        <i class="ph ph-facebook-logo" style="font-size: 1.3rem; color: #1877F2;"></i>
                                    <#elseif p.alias == "google">
                                        <i class="ph ph-google-logo" style="font-size: 1.3rem; color: #DB4437;"></i>
                                    <#elseif p.alias == "github">
                                        <i class="ph ph-github-logo" style="font-size: 1.3rem; color: #333;"></i>
                                    <#elseif p.alias == "microsoft">
                                        <i class="ph ph-microsoft-logo" style="font-size: 1.3rem; color: #00a4ef;"></i>
                                    <#else>
                                        <i class="ph ph-sign-in" style="font-size: 1.3rem;"></i>
                                    </#if>
                                    <span>${p.displayName!}</span>
                                </a>
                            </#list>
                        </div>
                    </#if>
                </div>

                <#-- QR CODE VIEW -->
                <div id="form-qr" class="hidden">
                    <div class="qr-section">
                        <div class="qr-container">
                            <i class="ph ph-qr-code" style="font-size: 80px; opacity: 0.8;"></i>
                            <div class="scan-line"></div>
                        </div>
                        <div class="qr-instructions">
                            <h4>Cara Penggunaan:</h4>
                            <p>1. Buka aplikasi <strong>Jogja Smart Service</strong>.</p>
                            <p>2. Pilih menu <strong>Scan QR</strong>.</p>
                            <p>3. Arahkan kamera ke kode di atas.</p>
                        </div>
                    </div>
                </div>

                <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                    <div class="bottom-text">
                        Belum punya akun? <a tabindex="6" href="${url.registrationUrl}">Daftar Disini</a>
                    </div>
                </#if>
            </div>
        </div>
    </div>
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>