<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Portal Pemda DIY</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
    <div class="container">
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
                    <p class="slide-desc">Mengintegrasikan teknologi informasi dalam tata kelola pemerintahan untuk mewujudkan pelayanan publik yang transparan, akuntabel, dan efisien.</p>
                </div>
                <div class="carousel-slide">
                    <span class="slide-tag">Layanan Terintegrasi</span>
                    <h2 class="slide-title">Satu Akun untuk Semua</h2>
                    <p class="slide-desc">Akses ratusan layanan digital PEMDA DIY hanya dengan satu akun SSO. Praktis, cepat, dan terintegrasi dalam satu ekosistem digital.</p>
                </div>
                <div class="carousel-slide">
                    <span class="slide-tag">Keamanan Data</span>
                    <h2 class="slide-title">Terpercaya & Terenkripsi</h2>
                    <p class="slide-desc">Data Anda dilindungi dengan enkripsi standar internasional dan sistem keamanan berlapis untuk menjamin privasi dan integritas informasi.</p>
                </div>

                <div class="carousel-progress">
                    <div class="progress-bar"></div>
                </div>
            </div>
        </div>

        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card">
                <div class="form-header">
                    <h2>Selamat Datang</h2>
                    <p>Silakan masuk untuk mengakses dashboard layanan.</p>
                </div>

                <div class="auth-tabs">
                    <button class="tab-btn active" id="tab-pass">Kredensial</button>
                    <button class="tab-btn" id="tab-qr">QR Code</button>
                </div>

                <div id="form-credential">
                    <form action="${url.loginAction}" method="post">
                        <div class="form-group">
                            <label class="form-label">Email atau NIP</label>
                            <div class="input-wrapper">
                                <input type="text" id="username" name="username" class="form-input" placeholder="contoh: nama@jogjaprov.go.id" autocomplete="off">
                                <i class="ph ph-user input-icon"></i>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Kata Sandi</label>
                            <div class="input-wrapper">
                                <input type="password" id="password" name="password" class="form-input" placeholder="Masukkan kata sandi" autocomplete="off">
                                <i class="ph ph-lock input-icon"></i>
                                <i class="ph ph-eye password-toggle" onclick="togglePassword('password')"></i>
                            </div>
                            <div class="links-row">
                                <a href="${url.loginResetCredentialsUrl}" class="link-text">Lupa Password?</a>
                            </div>
                        </div>

                        <#if message?has_content && (message.type != 'display-configure-otp')>
                            <div style="color: #ef4444; font-size: 0.85rem; margin-bottom: 15px; text-align: center; font-weight: 600;">
                                ${kcSanitize(message.summary)?no_esc}
                            </div>
                        </#if>

                        <button type="submit" class="main-btn">Masuk Sekarang</button>
                    </form>
                </div>

                <div id="form-qr" class="hidden">
                    <div class="qr-section">
                        <div class="qr-container">
                            <i class="ph ph-qr-code" style="font-size: 80px; opacity: 0.8;"></i>
                            <div class="scan-line"></div>
                        </div>
                        <div class="qr-instructions">
                            <h4>Cara Penggunaan:</h4>
                            <p>1. Buka aplikasi <strong>Jogja Smart Service</strong>.</p>
                            <p>2. Pilih menu <strong>Scan QR</strong> di pojok kanan atas.</p>
                            <p>3. Arahkan kamera ponsel Anda ke kode QR di atas.</p>
                        </div>
                    </div>
                </div>

                <div class="bottom-text">
                    Belum punya akun? <a href="${url.registrationUrl}">Daftar Disini</a>
                </div>
            </div>
        </div>
    </div>
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>