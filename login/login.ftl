<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Portal Pemda DIY</title>
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <script src="https://cdn.jsdelivr.net/npm/qrcode@1.5.3/build/qrcode.min.js"></script>
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
                    <p>Masuk untuk mengakses layanan</p>
                </div>

                <div class="auth-tabs">
                    <button class="tab-btn active" id="tab-pass">Kredensial</button>
                    <button class="tab-btn" id="tab-passkey">Passkey</button>
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

                    <#-- SOCIAL LOGIN (2 KECIL + 1 BESAR) -->
                    <#if social.providers??>
                        <div class="social-login-top">
                            <#list social.providers as p>
                                <#if p.alias == "github" || p.alias == "facebook">
                                    <a id="social-${p.alias}" class="social-btn-small" href="${p.loginUrl}">
                                        <#if p.alias == "facebook">
                                            <i class="ph ph-facebook-logo"></i>
                                        <#elseif p.alias == "github">
                                            <i class="ph ph-github-logo"></i>
                                        </#if>
                                        <span>${p.displayName!}</span>
                                    </a>
                                </#if>
                            </#list>
                        </div>
                        <#list social.providers as p>
                            <#if p.alias == "google">
                                <a id="social-${p.alias}" class="social-btn-full" href="${p.loginUrl}">
                                    <i class="ph ph-google-logo"></i>
                                    <span>${p.displayName!}</span>
                                </a>
                            </#if>
                        </#list>
                        <div class="social-divider"><span>Atau masuk dengan email</span></div>
                    </#if>

                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" autocomplete="off">
                        <div class="form-group">
                            <label class="form-label"><#if !realm.loginWithEmailAllowed>Username<#elseif !realm.registrationEmailAsUsername>Email atau Username<#else>Email</#if></label>
                            <div class="input-wrapper">
                                <input tabindex="1" id="username" class="form-input" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off" placeholder="<#if !realm.loginWithEmailAllowed>username<#elseif !realm.registrationEmailAsUsername>Email atau username<#else>email@jogjaprov.go.id</#if>" />
                                <i class="ph ph-user input-icon"></i>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <div class="input-wrapper">
                                <input tabindex="2" id="password" class="form-input" name="password" type="password" autocomplete="off" placeholder="Masukkan password" />
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
                </div>

                <#-- PASSKEY VIEW -->
                <div id="form-qr" class="hidden">
                    <div class="qr-section">
                        <div class="passkey-header">
                            <i class="ph ph-fingerprint" style="font-size: 3rem; color: #0ea5e9; margin-bottom: 10px;"></i>
                            <h3 style="font-size: 1.2rem; color: #0f172a; margin-bottom: 8px;">Login dengan Passkey</h3>
                            <p style="font-size: 0.85rem; color: #64748b; margin-bottom: 20px;">Gunakan biometrik atau scan QR code dari perangkat lain</p>
                        </div>
                        
                        <div id="passkey-qr-container" style="display: none; text-align: center; margin: 25px 0;">
                            <div style="background: white; padding: 20px; border-radius: 16px; border: 2px dashed #0ea5e9; display: inline-block; margin-bottom: 20px;">
                                <canvas id="passkey-qr-canvas" width="240" height="240"></canvas>
                            </div>
                            <p style="font-size: 0.85rem; color: #64748b; margin-bottom: 15px;">
                                <i class="ph ph-device-mobile" style="font-size: 1.2rem; vertical-align: middle;"></i>
                                Scan QR code ini dari perangkat mobile Anda
                            </p>
                            <button type="button" class="passkey-btn" onclick="cancelPasskeyAuth()" style="background: linear-gradient(135deg, #64748b, #475569); max-width: 250px; margin: 0 auto;">
                                <i class="ph ph-x"></i>
                                <span>Batalkan</span>
                            </button>
                        </div>
                        
                        <div id="passkey-action-container">
                            <button type="button" class="passkey-btn" onclick="authenticateWithPasskey()">
                                <i class="ph ph-fingerprint" weight="fill"></i>
                                <span>Gunakan Passkey</span>
                            </button>
                            
                            <div style="text-align: center; margin: 20px 0;">
                                <span style="color: #cbd5e1; font-size: 0.85rem;"></span>
                            </div>
                            
                            
                            
                            <form id="webauth-form" action="${url.loginAction}" method="post" style="display: none;">
                                <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                                <input type="hidden" id="authenticatorData" name="authenticatorData"/>
                                <input type="hidden" id="signature" name="signature"/>
                                <input type="hidden" id="credentialId" name="credentialId"/>
                                <input type="hidden" id="userHandle" name="userHandle"/>
                            </form>
                        </div>
                        
                        <div class="qr-instructions">
                            <h4>Cara Menggunakan Passkey</h4>
                            <p><strong>Via Biometrik:</strong> Klik "Gunakan Passkey" dan ikuti petunjuk di perangkat Anda</p>
                            <p><strong>Via QR Code:</strong> Klik "Tampilkan QR Code" dan scan dari perangkat mobile yang sudah terdaftar</p>
                            <p style="margin-top: 15px; color: #f59e0b;">
                                <i class="ph ph-warning" weight="fill" style="vertical-align: middle;"></i>
                                <strong>Belum punya Passkey?</strong> Login dengan password terlebih dahulu untuk mendaftarkan
                            </p>
                        </div>
                    </div>
                </div>

                <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                    <div class="bottom-text">
                        Belum punya akun? <a tabindex="6" href="${url.registrationUrl}">Daftar Sekarang</a>
                    </div>
                </#if>

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
    
    <#-- WebAuthn Authentication Script -->
    <script>
        // WebAuthn Authentication with Passkey
        async function authenticateWithPasskey() {
            // Check if WebAuthn is supported
            if (!window.PublicKeyCredential) {
                alert('Browser Anda tidak mendukung Passkey. Gunakan Chrome, Edge, atau Safari versi terbaru.');
                return;
            }
            
            const btn = event.target.closest('button');
            const originalContent = btn.innerHTML;
            btn.disabled = true;
            btn.innerHTML = '<i class="ph ph-spinner" style="animation: spin 1s linear infinite;"></i><span>Memproses...</span>';
            
            try {
                // Check if platform authenticator is available
                const available = await PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable();
                
                if (available) {
                    // Trigger Windows Hello / Touch ID / Face ID
                    const publicKeyCredentialRequestOptions = {
                        challenge: new Uint8Array(32), // In production, get from server
                        timeout: 60000,
                        userVerification: 'required'
                    };
                    
                    const credential = await navigator.credentials.get({
                        publicKey: publicKeyCredentialRequestOptions
                    });
                    
                    // Process credential and submit
                    if (credential) {
                        document.getElementById('credentialId').value = arrayBufferToBase64(credential.rawId);
                        document.getElementById('clientDataJSON').value = arrayBufferToBase64(credential.response.clientDataJSON);
                        document.getElementById('authenticatorData').value = arrayBufferToBase64(credential.response.authenticatorData);
                        document.getElementById('signature').value = arrayBufferToBase64(credential.response.signature);
                        document.getElementById('userHandle').value = credential.response.userHandle ? arrayBufferToBase64(credential.response.userHandle) : '';
                        
                        document.getElementById('webauth-form').submit();
                    }
                } else {
                    alert('Platform authenticator tidak tersedia di perangkat ini.\n\nSilakan:\n1. Gunakan QR Code untuk scan dari mobile\n2. Login dengan password untuk setup Passkey\n3. Pastikan Windows Hello/Touch ID/Face ID sudah aktif');
                }
            } catch (error) {
                console.error('Passkey authentication error:', error);
                if (error.name === 'NotAllowedError') {
                    alert('Autentikasi dibatalkan atau ditolak.');
                } else {
                    alert('Terjadi kesalahan: ' + error.message);
                }
            } finally {
                btn.disabled = false;
                btn.innerHTML = originalContent;
            }
        }
        
        // Show QR Code for cross-device authentication
        function showPasskeyQR() {
            // Hide action buttons
            document.getElementById('passkey-action-container').style.display = 'none';
            
            // Show QR container
            const qrContainer = document.getElementById('passkey-qr-container');
            qrContainer.style.display = 'block';
            
            // Generate QR Code
            const canvas = document.getElementById('passkey-qr-canvas');
            const ctx = canvas.getContext('2d');
            
            // Create authentication URL (in production, this should be a WebAuthn registration URL)
            const authUrl = window.location.origin + window.location.pathname;
            const qrData = {
                url: authUrl,
                type: 'passkey-auth',
                timestamp: Date.now()
            };
            
            // Generate QR code using qrcode.js library
            QRCode.toCanvas(canvas, JSON.stringify(qrData), {
                width: 240,
                margin: 1,
                color: {
                    dark: '#0f172a',
                    light: '#ffffff'
                }
            }, function (error) {
                if (error) console.error(error);
            });
            
            // In production, you would:
            // 1. Request a challenge from server
            // 2. Generate QR with authentication URL + challenge
            // 3. Mobile device scans and completes WebAuthn
            // 4. Poll server for authentication result
        }
        
        function cancelPasskeyAuth() {
            document.getElementById('passkey-qr-container').style.display = 'none';
            document.getElementById('passkey-action-container').style.display = 'block';
        }
        
        // Helper function to convert ArrayBuffer to Base64
        function arrayBufferToBase64(buffer) {
            let binary = '';
            const bytes = new Uint8Array(buffer);
            for (let i = 0; i < bytes.byteLength; i++) {
                binary += String.fromCharCode(bytes[i]);
            }
            return window.btoa(binary);
        }
    </script>
    
    <style>
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>
