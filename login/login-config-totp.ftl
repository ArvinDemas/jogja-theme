<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Setup Authenticator - Portal Pemda DIY</title>
    
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    
    <#-- Tambahan CSS Khusus Halaman TOTP -->
    <style>
        .tips-badge { display: inline-block; padding: 6px 12px; background: rgba(56, 189, 248, 0.15); border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 30px; font-size: 0.75rem; font-weight: 700; margin-bottom: 15px; text-transform: uppercase; letter-spacing: 1px; color: #38bdf8; font-family: 'Inter', sans-serif; }
        .tips-list { display: flex; flex-direction: column; gap: 20px; margin-top: 20px; }
        .tip-item { display: flex; gap: 15px; align-items: flex-start; }
        .tip-icon { min-width: 40px; height: 40px; background: rgba(255,255,255,0.1); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: #38bdf8; font-size: 1.2rem; }
        .tip-text h4 { font-family: 'Inter', sans-serif; font-size: 0.95rem; font-weight: 700; margin: 0 0 4px 0; color: #f8fafc; }
        .tip-text p { font-size: 0.85rem; color: #cbd5e1; margin: 0; line-height: 1.4; opacity: 0.8; font-family: 'Inter', sans-serif;}

        .otp-step { margin-bottom: 25px; padding-bottom: 25px; border-bottom: 1px dashed #e2e8f0; }
        .otp-step:last-child { border-bottom: none; padding-bottom: 0; margin-bottom: 0; }
        .step-header { display: flex; align-items: center; gap: 10px; margin-bottom: 15px; }
        .step-num { width: 28px; height: 28px; background: #0f172a; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.85rem; font-weight: 700; }
        .step-title { font-size: 1rem; font-weight: 700; color: #0f172a; margin: 0; font-family: 'Inter', sans-serif; }
        
        .app-badges { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 10px; }
        .app-badge { display: flex; align-items: center; gap: 6px; background: #f1f5f9; padding: 6px 12px; border-radius: 8px; font-size: 0.8rem; color: #475569; font-weight: 600; }
        
        .qr-wrapper { text-align: center; background: #fff; padding: 15px; border-radius: 15px; border: 2px dashed #0ea5e9; display: inline-block; margin: 10px 0; }
        .qr-wrapper img { width: 160px; height: 160px; display: block; }
        
        .secret-box { background: #f8fafc; padding: 12px; border-radius: 8px; border: 1px solid #cbd5e1; display: flex; justify-content: space-between; align-items: center; margin-top: 10px; }
        .secret-code { font-family: monospace; font-size: 1.1rem; color: #0f172a; font-weight: 700; letter-spacing: 2px; }
        .copy-btn { background: none; border: none; cursor: pointer; color: #0ea5e9; transition: 0.2s; }
        .copy-btn:hover { color: #0284c7; }

        .manual-toggle { background: none; border: none; color: #64748b; font-size: 0.85rem; cursor: pointer; text-decoration: underline; margin-top: 10px; }
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

            <div class="carousel-container" style="max-width: 500px;">
                <div class="tips-badge">Keamanan Akun</div>
                <h2 class="slide-title" style="font-size: 2.5rem; margin-bottom: 30px;">Two-Factor Authentication</h2>
                
                <div class="tips-list">
                    <div class="tip-item">
                        <div class="tip-icon"><i class="ph ph-shield-check"></i></div>
                        <div class="tip-text">
                            <h4>Proteksi Ganda</h4>
                            <p>Melindungi akun Anda meskipun password diketahui orang lain.</p>
                        </div>
                    </div>
                    <div class="tip-item">
                        <div class="tip-icon"><i class="ph ph-device-mobile"></i></div>
                        <div class="tip-text">
                            <h4>Akses Pribadi</h4>
                            <p>Hanya perangkat terdaftar yang dapat mengizinkan akses login.</p>
                        </div>
                    </div>
                    <div class="tip-item">
                        <div class="tip-icon"><i class="ph ph-lock-key"></i></div>
                        <div class="tip-text">
                            <h4>Standar Keamanan</h4>
                            <p>Menggunakan enkripsi TOTP standar industri yang aman.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in" style="max-width: 500px;">
                <div class="login-header">
                    <h2>Setup Authenticator</h2>
                    <p>Tingkatkan keamanan akun Anda dalam 3 langkah mudah.</p>
                </div>

                <#-- Alert Error -->
                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <#-- STEP 1: DOWNLOAD APP -->
                <div class="otp-step">
                    <div class="step-header">
                        <div class="step-num">1</div>
                        <h3 class="step-title">Install Aplikasi</h3>
                    </div>
                    <p style="font-size: 0.9rem; color: #64748b; margin-bottom: 10px;">Unduh salah satu aplikasi berikut di HP Anda:</p>
                    <div class="app-badges">
                        <div class="app-badge"><i class="ph ph-google-logo"></i> Google Auth</div>
                        <div class="app-badge"><i class="ph ph-microsoft-logo"></i> Microsoft Auth</div>
                        <div class="app-badge"><i class="ph ph-lock"></i> FreeOTP</div>
                    </div>
                </div>

                <#-- STEP 2: SCAN QR -->
                <div class="otp-step">
                    <div class="step-header">
                        <div class="step-num">2</div>
                        <h3 class="step-title">Scan Barcode</h3>
                    </div>
                    <div style="text-align: center;">
                        <#-- INI KUNCINYA: Gunakan Gambar dari Server Keycloak, Bukan JS Client -->
                        <div class="qr-wrapper">
                            <img src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Scan QR Code ini" />
                        </div>
                        
                        <div style="margin-top: 10px;">
                            <button type="button" class="manual-toggle" onclick="toggleManual()">Tidak bisa scan? Lihat kode manual</button>
                            
                            <div id="manual-box" style="display: none; text-align: left; margin-top: 10px;">
                                <label class="form-label" style="font-size: 0.8rem;">Kode Rahasia (Secret Key)</label>
                                <div class="secret-box">
                                    <span class="secret-code" id="secretCode">${totp.totpSecretEncoded}</span>
                                    <button type="button" class="copy-btn" onclick="copyCode()" title="Salin">
                                        <i class="ph ph-copy" style="font-size: 1.2rem;"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <#-- STEP 3: VERIFIKASI -->
                <div class="otp-step">
                    <div class="step-header">
                        <div class="step-num">3</div>
                        <h3 class="step-title">Verifikasi</h3>
                    </div>
                    
                    <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
                        <div class="form-group">
                            <div class="input-wrapper">
                                <input type="text" id="totp" name="totp" autocomplete="off" class="form-input" placeholder="Masukkan 6 digit kode" style="text-align: center; letter-spacing: 5px; font-weight: 700; font-size: 1.2rem;" maxlength="6" autofocus />
                                <i class="ph ph-key input-icon"></i>
                            </div>
                        </div>

                        <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                        
                        <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>

                        <#-- DEVICE NAME (OPTIONAL) -->
                        <div class="form-group">
                            <div class="input-wrapper">
                                <input type="text" class="form-input" id="userLabel" name="userLabel" autocomplete="off" placeholder="Nama Perangkat (cth: iPhone Saya)" value="${(totp.userLabel!'')}" />
                                <i class="ph ph-device-mobile input-icon"></i>
                            </div>
                        </div>

                        <button type="submit" class="main-btn" id="saveTOTPBtn">Simpan & Aktifkan</button>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <script>
        function toggleManual() {
            var x = document.getElementById("manual-box");
            if (x.style.display === "none") {
                x.style.display = "block";
            } else {
                x.style.display = "none";
            }
        }

        function copyCode() {
            var copyText = document.getElementById("secretCode").innerText;
            navigator.clipboard.writeText(copyText).then(function() {
                alert("Kode berhasil disalin: " + copyText);
            });
        }
    </script>
</body>
</html>