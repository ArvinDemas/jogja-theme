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
        
        <#-- VISUAL SECTION -->
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

        <#-- FORM SECTION -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in">
                <div class="login-header">
                    <h2>Selamat Datang</h2>
                    <p>Masuk untuk mengakses layanan</p>
                </div>

                <#-- TAB NAVIGASI -->
                <div class="auth-tabs">
                    <button class="tab-btn active" id="tab-credential" onclick="switchTabInline('credential')">Kredensial</button>
                    <button class="tab-btn" id="tab-qr" onclick="switchTabInline('qr')">QR Code</button>
                    <button class="tab-btn" id="tab-passkey" onclick="switchTabInline('passkey')">Passkey</button>
                </div>

                <#-- TAB 1: KREDENSIAL -->
                <div id="form-credential">
                    <#if message?has_content && (message.type != 'warning')>
                        <div class="alert alert-${message.type}">
                            <#if message.type = 'success'><i class="ph ph-check-circle"></i></#if>
                            <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                            <span>${kcSanitize(message.summary)?no_esc}</span>
                        </div>
                    </#if>

                    <#if social.providers??>
                        <div class="social-login-top">
                            <#list social.providers as p>
                                <#if p.alias == "github" || p.alias == "facebook">
                                    <a id="social-${p.alias}" class="social-btn-small" href="${p.loginUrl}">
                                        <#if p.alias == "facebook"><i class="ph ph-facebook-logo"></i>
                                        <#elseif p.alias == "github"><i class="ph ph-github-logo"></i></#if>
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
                                <input tabindex="1" id="username" class="form-input" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off" />
                                <i class="ph ph-user input-icon"></i>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Password</label>
                            <div class="input-wrapper">
                                <input tabindex="2" id="password" class="form-input" name="password" type="password" autocomplete="off" />
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

                <#-- TAB 2: QR CODE LOGIN -->
                <div id="form-qr" class="hidden">
                    <div class="qr-section">
                        <#if QRauthImage??>
                            <div class="qr-header">
                                <i class="ph ph-qr-code qr-header-icon"></i>
                                <h3 class="qr-title">Scan untuk Login</h3>
                                <p class="qr-subtitle">Scan QR Code dengan HP Anda. Login akan diproses <b>otomatis</b>.</p>
                            </div>
                            
                            <div class="qr-code-wrapper">
                                <#-- QR CODE CONTAINER (GAMBAR SAJA) -->
                                <div class="qr-code-container-main" 
                                     style="position: relative; transition: transform 0.2s;">
                                    <img src="data:image/png;base64,${QRauthImage}" alt="QR Code" class="qr-code-img" id="qr-code-image"/>
                                    
                                    <#-- STATUS INDIKATOR (BAKAL BERUBAH OLEH SCRIPT) -->
                                    <div id="qr-loading-status" style="margin-top: 15px; font-size: 0.9rem; color: #166534; background: #dcfce7; padding: 8px 12px; border-radius: 8px; font-weight: 600; display: inline-flex; align-items: center; gap: 6px;">
                                        <i class="ph ph-spinner" style="animation: spin 1s linear infinite;"></i> Menunggu Scan...
                                    </div>
                                </div>
                            </div>
                            
                            <style>
                                @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
                            </style>
                            
                            <#-- SCRIPT AJAIB: POLLING OTOMATIS (Tanpa Refresh Halaman) -->
                            <script>
                            (function() {
                                // URL saat ini (termasuk session ID)
                                var currentUrl = window.location.href;
                                
                                // Cek status setiap 2 detik
                                setInterval(function() {
                                    fetch(currentUrl, { method: 'GET', redirect: 'follow' })
                                    .then(function(response) {
                                        // Keycloak akan me-redirect jika login sukses.
                                        // Jika URL respons berbeda dengan URL halaman saat ini, berarti sudah masuk dashboard!
                                        if (response.url && response.url !== currentUrl) {
                                            document.getElementById('qr-loading-status').innerHTML = '<i class="ph ph-check-circle"></i> Berhasil! Mengalihkan...';
                                            window.location.href = response.url;
                                        }
                                    })
                                    .catch(function(err) {
                                        // Error jaringan, abaikan saja (tunggu polling berikutnya)
                                        console.log('Polling...', err);
                                    });
                                }, 2000);
                            })();
                            </script>
                            
                            <div class="qr-action-buttons">
                                <button type="button" onclick="window.location.reload()" class="qr-btn-secondary">
                                    <i class="ph ph-arrow-clockwise"></i> Refresh QR
                                </button>
                                <button type="button" onclick="switchTabInline('credential')" class="qr-btn-secondary">
                                    <i class="ph ph-arrow-left"></i> Password
                                </button>
                            </div>
                        <#else>
                            <div class="qr-unavailable">
                                <h3 class="qr-unavailable-title">QR Login Belum Tersedia</h3>
                                <button type="button" onclick="switchTabInline('credential')" class="main-btn">Kembali</button>
                            </div>
                        </#if>
                    </div>
                </div>

                <#-- TAB 3: PASSKEY -->
                <div id="form-passkey" class="hidden">
                    <div class="qr-section">
                        <div class="passkey-header">
                            <i class="ph ph-fingerprint" style="font-size: 3rem; color: #0ea5e9; margin-bottom: 10px;"></i>
                            <h3 style="font-size: 1.2rem; margin-bottom: 8px;">Login Passkey</h3>
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
                    </div>
                </div>

                <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                    <div class="bottom-text">
                        Belum punya akun? <a tabindex="6" href="${url.registrationUrl}">Daftar Sekarang</a>
                    </div>
                </#if>

                <div class="footer-links">
                    <a href="#" class="footer-link"><i class="ph ph-shield-check"></i><span>Panduan</span></a>
                    <a href="#" class="footer-link"><i class="ph ph-chat-circle-dots"></i><span>Kontak</span></a>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // FUNGSI GANTI TAB (INLINE)
        function switchTabInline(tabName) {
            const tabs = {'credential': 'tab-credential', 'qr': 'tab-qr', 'passkey': 'tab-passkey'};
            const forms = {'credential': 'form-credential', 'qr': 'form-qr', 'passkey': 'form-passkey'};
            
            Object.values(tabs).forEach(id => { const el = document.getElementById(id); if(el) el.classList.remove('active'); });
            Object.values(forms).forEach(id => { const el = document.getElementById(id); if(el) el.classList.add('hidden'); });
            
            if(tabs[tabName]) document.getElementById(tabs[tabName]).classList.add('active');
            if(forms[tabName]) document.getElementById(forms[tabName]).classList.remove('hidden');
        }

        async function authenticateWithPasskey() {
            if (!window.PublicKeyCredential) { alert('Browser tidak mendukung Passkey.'); return; }
            try {
                const available = await PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable();
                if (available) {
                    const credential = await navigator.credentials.get({ publicKey: { challenge: new Uint8Array(32), timeout: 60000, userVerification: 'required' } });
                    if (credential) {
                        document.getElementById('credentialId').value = arrayBufferToBase64(credential.rawId);
                        document.getElementById('clientDataJSON').value = arrayBufferToBase64(credential.response.clientDataJSON);
                        document.getElementById('authenticatorData').value = arrayBufferToBase64(credential.response.authenticatorData);
                        document.getElementById('signature').value = arrayBufferToBase64(credential.response.signature);
                        document.getElementById('userHandle').value = credential.response.userHandle ? arrayBufferToBase64(credential.response.userHandle) : '';
                        document.getElementById('webauth-form').submit();
                    }
                } else { alert('Authenticator tidak tersedia.'); }
            } catch (error) { console.error(error); alert('Gagal.'); }
        }
        function arrayBufferToBase64(buffer) {
            let binary = '';
            const bytes = new Uint8Array(buffer);
            for (let i = 0; i < bytes.byteLength; i++) { binary += String.fromCharCode(bytes[i]); }
            return window.btoa(binary);
        }
    </script>
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>