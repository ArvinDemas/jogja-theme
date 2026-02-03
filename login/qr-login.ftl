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
                    <p>Masuk untuk mengakses layanan</p>
                </div>

                <#-- 3 TABS: Kredensial, QR Code, Passkey -->
                <div class="auth-tabs">
                    <button class="tab-btn active" id="tab-credential">Kredensial</button>
                    <button class="tab-btn" id="tab-qr">QR Code</button>
                    <button class="tab-btn" id="tab-passkey">Passkey</button>
                </div>

                <#-- ===================================== -->
                <#-- TAB 1: KREDENSIAL (PASSWORD LOGIN) -->
                <#-- ===================================== -->
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

                <#-- ===================================== -->
                <#-- TAB 2: QR CODE LOGIN -->
                <#-- ===================================== -->
                <div id="form-qr" class="hidden">
                    <div class="qr-section">
                        <#-- CEK APAKAH ADA QR CODE DARI EXTENSION -->
                        <#if QRauthImage??>
                            <#-- QR CODE TERSEDIA -->
                            <div style="text-align: center; margin-bottom: 25px;">
                                <i class="ph ph-qr-code" style="font-size: 3rem; color: #0ea5e9; margin-bottom: 15px;"></i>
                                <h3 style="font-size: 1.3rem; color: #0f172a; margin-bottom: 10px;">
                                    Scan untuk Login
                                </h3>
                                <p style="font-size: 0.9rem; color: #64748b;">
                                    Gunakan kamera HP Anda untuk scan QR code
                                </p>
                            </div>
                            
                            <div style="text-align: center; margin: 30px 0;">
                                <div style="background: white; padding: 20px; border-radius: 16px; border: 2px dashed #0ea5e9; display: inline-block;">
                                    <img src="data:image/png;base64,${QRauthImage}" 
                                         alt="QR Code" 
                                         style="width: 240px; height: 240px; display: block;"
                                         id="qr-code-image"/>
                                </div>
                            </div>
                            
                            <div style="background: #f0f9ff; border-left: 4px solid #0ea5e9; padding: 15px; border-radius: 10px; margin: 20px 0;">
                                <p style="font-size: 0.85rem; color: #0c4a6e; line-height: 1.6; margin: 0;">
                                    <strong>ℹ️ Cara Menggunakan:</strong><br/>
                                    1. Buka kamera atau QR scanner di HP<br/>
                                    2. Arahkan ke QR code di atas<br/>
                                    3. Login dengan akun Anda di HP<br/>
                                    4. Halaman ini akan otomatis login
                                </p>
                            </div>
                            
                            <#-- Auto-refresh indicator -->
                            <div style="text-align: center; margin-top: 15px;">
                                <p style="font-size: 0.75rem; color: #94a3b8; display: flex; align-items: center; justify-content: center; gap: 8px;">
                                    <i class="ph ph-arrow-clockwise" style="animation: spin 2s linear infinite;"></i>
                                    <span>QR code akan diperbarui otomatis...</span>
                                </p>
                            </div>
                            
                            <#-- Tombol refresh manual (opsional) -->
                            <button type="button" 
                                    onclick="location.reload()" 
                                    class="main-btn" 
                                    style="background: white; color: #0f172a; border: 2px solid #e2e8f0; margin-top: 15px;">
                                <i class="ph ph-arrow-clockwise"></i>
                                Refresh QR Code
                            </button>
                        <#else>
                            <#-- QR CODE TIDAK TERSEDIA (Extension belum diaktifkan) -->
                            <div style="text-align: center; padding: 30px;">
                                <i class="ph ph-warning-circle" style="font-size: 3.5rem; color: #f59e0b; margin-bottom: 20px;"></i>
                                <h3 style="font-size: 1.2rem; color: #0f172a; margin-bottom: 12px;">
                                    QR Login Belum Tersedia
                                </h3>
                                <p style="font-size: 0.9rem; color: #64748b; line-height: 1.6; margin-bottom: 25px;">
                                    Fitur QR Code Login belum diaktifkan pada sistem ini. Silakan hubungi administrator untuk mengaktifkan fitur ini.
                                </p>
                                
                                <div style="background: #fffbeb; border-left: 4px solid #f59e0b; padding: 15px; border-radius: 10px; margin: 20px 0; text-align: left;">
                                    <p style="font-size: 0.85rem; color: #92400e; line-height: 1.6; margin: 0;">
                                        <strong>ℹ️ Untuk Administrator:</strong><br/>
                                        1. Install QR Code Extension ke Keycloak<br/>
                                        2. Aktifkan QR authentication flow<br/>
                                        3. Bind flow ke browser authentication<br/>
                                        4. Restart Keycloak
                                    </p>
                                </div>
                                
                                <button type="button" 
                                        onclick="switchToTab('credential')" 
                                        class="main-btn" 
                                        style="background: #0f172a; max-width: 300px; margin: 0 auto;">
                                    <i class="ph ph-arrow-left"></i>
                                    Kembali ke Login Biasa
                                </button>
                            </div>
                        </#if>
                    </div>
                </div>

                <#-- ===================================== -->
                <#-- TAB 3: PASSKEY LOGIN -->
                <#-- ===================================== -->
                <div id="form-passkey" class="hidden">
                    <div class="qr-section">
                        <div class="passkey-header">
                            <i class="ph ph-fingerprint" style="font-size: 3rem; color: #0ea5e9; margin-bottom: 10px;"></i>
                            <h3 style="font-size: 1.2rem; color: #0f172a; margin-bottom: 8px;">Login dengan Passkey</h3>
                            <p style="font-size: 0.85rem; color: #64748b; margin-bottom: 20px;">Gunakan biometrik perangkat Anda untuk masuk</p>
                        </div>
                        
                        <div id="passkey-action-container">
                            <button type="button" class="passkey-btn" onclick="authenticateWithPasskey()">
                                <i class="ph ph-fingerprint" weight="fill"></i>
                                <span>Gunakan Passkey</span>
                            </button>
                            
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
                    alert('Platform authenticator tidak tersedia di perangkat ini.\n\nSilakan:\n1. Login dengan password untuk setup Passkey\n2. Pastikan Windows Hello/Touch ID/Face ID sudah aktif');
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
        
        // Helper function to convert ArrayBuffer to Base64
        function arrayBufferToBase64(buffer) {
            let binary = '';
            const bytes = new Uint8Array(buffer);
            for (let i = 0; i < bytes.byteLength; i++) {
                binary += String.fromCharCode(bytes[i]);
            }
            return window.btoa(binary);
        }
        
        // Function to switch tabs programmatically
        function switchToTab(tabName) {
            const tabs = {
                'credential': {btn: document.getElementById('tab-credential'), form: document.getElementById('form-credential')},
                'qr': {btn: document.getElementById('tab-qr'), form: document.getElementById('form-qr')},
                'passkey': {btn: document.getElementById('tab-passkey'), form: document.getElementById('form-passkey')}
            };
            
            // Remove all active states
            Object.values(tabs).forEach(tab => {
                tab.btn.classList.remove('active');
                tab.form.classList.add('hidden');
            });
            
            // Activate selected tab
            if (tabs[tabName]) {
                tabs[tabName].btn.classList.add('active');
                tabs[tabName].form.classList.remove('hidden');
            }
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
