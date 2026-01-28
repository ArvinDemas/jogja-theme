<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Akun - Portal Pemda DIY</title>
    
    <#-- PASTIKAN CSS INI TERMUAT -->
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
    <div class="container">
        
        <#-- BAGIAN KIRI: VISUAL (TETAP SAMA) -->
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
                    <p class="slide-desc">Bergabunglah dengan ekosistem digital kami untuk akses layanan publik yang lebih mudah, transparan, dan efisien.</p>
                </div>
            </div>
        </div>

        <#-- BAGIAN KANAN: FORM REGISTER (YANG DIPERBAIKI) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>
            
            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Buat Akun Baru</h2>
                    <p>Lengkapi data diri untuk bergabung.</p>
                </div>

                <#-- Menampilkan Pesan Error jika ada -->
                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}" style="margin-bottom: 20px;">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <form action="${url.registrationAction}" method="post">
                    
                    <#-- ROW: NAMA DEPAN & BELAKANG (SEJAJAR) -->
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Nama Depan</label>
                            <div class="input-wrapper">
                                <input type="text" name="firstName" class="form-input" value="${(register.formData.firstName!'')}" placeholder="Budi" autocomplete="given-name" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Nama Belakang</label>
                            <div class="input-wrapper">
                                <input type="text" name="lastName" class="form-input" value="${(register.formData.lastName!'')}" placeholder="Santoso" autocomplete="family-name" />
                            </div>
                        </div>
                    </div>

                    <#-- EMAIL -->
                    <div class="form-group">
                        <label class="form-label">Email Aktif</label>
                        <div class="input-wrapper">
                            <input type="email" name="email" class="form-input" value="${(register.formData.email!'')}" placeholder="nama@email.com" autocomplete="email" />
                            <i class="ph ph-envelope input-icon"></i>
                        </div>
                    </div>

                    <#-- USERNAME (Jika diaktifkan di Keycloak) -->
                    <#if !realm.registrationEmailAsUsername>
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <div class="input-wrapper">
                                <input type="text" name="username" class="form-input" value="${(register.formData.username!'')}" placeholder="budi.santoso" autocomplete="username" />
                                <i class="ph ph-user input-icon"></i>
                            </div>
                        </div>
                    </#if>

                    <#-- PASSWORD DENGAN CHECKLIST -->
                    <div class="form-group">
                        <label class="form-label">Buat Password</label>
                        <div class="input-wrapper">
                            <#-- ID 'reg-pass' PENTING untuk JavaScript -->
                            <input type="password" name="password" id="reg-pass" class="form-input" placeholder="Minimal 8 karakter" autocomplete="new-password" />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('reg-pass')"></i>
                        </div>
                        
                        <#-- INDIKATOR PASSWORD (CHECKLIST) -->
                        <div class="password-requirements">
                            <div class="req-title">Keamanan Password:</div>
                            <ul class="req-list">
                                <li id="rule-length" class="req-item"><i class="ph ph-circle"></i> Min 8 Karakter</li>
                                <li id="rule-upper" class="req-item"><i class="ph ph-circle"></i> Huruf Besar</li>
                                <li id="rule-number" class="req-item"><i class="ph ph-circle"></i> Angka</li>
                                <li id="rule-symbol" class="req-item"><i class="ph ph-circle"></i> Simbol (!@#)</li>
                            </ul>
                        </div>
                    </div>

                    <#-- KONFIRMASI PASSWORD -->
                    <div class="form-group">
                        <label class="form-label">Konfirmasi Password</label>
                        <div class="input-wrapper">
                            <input type="password" name="password-confirm" id="reg-confirm" class="form-input" placeholder="Ulangi password" autocomplete="new-password" />
                            <i class="ph ph-lock input-icon"></i>
                            <i class="ph ph-eye password-toggle" onclick="togglePassword('reg-confirm')"></i>
                        </div>
                    </div>

                    <#-- RECAPTCHA (Jika diaktifkan) -->
                    <#if recaptchaRequired??>
                        <div class="form-group">
                            <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}"></div>
                        </div>
                    </#if>

                    <button type="submit" class="main-btn">Daftar Sekarang</button>
                </form>

                <div class="bottom-text">
                    Sudah punya akun? <a href="${url.loginUrl}">Masuk Disini</a>
                </div>
            </div>
        </div>
    </div>
    
    <#-- PASTIKAN JS INI TERMUAT AGAR CHECKLIST BERFUNGSI -->
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>