<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftarkan Passkey - Portal Pemda DIY</title>
    
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    
    <style>
        .register-passkey-section {
            text-align: center;
            padding: 30px;
        }
        
        .passkey-icon-large {
            font-size: 4rem;
            color: #0ea5e9;
            margin-bottom: 20px;
        }
        
        .passkey-steps {
            text-align: left;
            margin: 30px 0;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .passkey-step {
            display: flex;
            gap: 15px;
            align-items: flex-start;
            padding: 18px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }
        
        .step-number-circle {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, #0ea5e9, #0284c7);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.1rem;
            flex-shrink: 0;
        }
        
        .step-content h4 {
            font-size: 0.95rem;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 6px 0;
        }
        
        .step-content p {
            font-size: 0.85rem;
            color: #64748b;
            line-height: 1.5;
            margin: 0;
        }
        
        .device-name-input {
            margin: 25px 0;
        }
        
        .button-group-passkey {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }
        
        .btn-skip {
            flex: 1;
            padding: 14px;
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            color: #64748b;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s ease;
        }
        
        .btn-skip:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }
        
        .btn-register-passkey {
            flex: 2;
        }
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

            <div class="carousel-container">
                <div class="carousel-slide active">
                    <span class="slide-tag">Keamanan Modern</span>
                    <h2 class="slide-title">Passkey</h2>
                    <p class="slide-desc">Login tanpa password menggunakan biometrik perangkat Anda. Lebih aman, lebih cepat, dan tidak perlu mengingat password rumit.</p>
                </div>
            </div>
        </div>

        <#-- FORM SECTION (KANAN) -->
        <div class="form-section">
            <div class="blob blob-1"></div><div class="blob blob-2"></div>

            <div class="login-card fade-in" style="max-width: 520px;">
                <div class="login-header">
                    <h2>Daftarkan Passkey</h2>
                    <p>Tingkatkan keamanan akun dengan biometrik</p>
                </div>

                <#if message?has_content && (message.type != 'warning')>
                    <div class="alert alert-${message.type}">
                        <#if message.type = 'error'><i class="ph ph-x-circle"></i></#if>
                        <span>${kcSanitize(message.summary)?no_esc}</span>
                    </div>
                </#if>

                <div class="register-passkey-section">
                    <i class="ph ph-fingerprint passkey-icon-large" weight="fill"></i>
                    
                    <div class="passkey-steps">
                        <div class="passkey-step">
                            <div class="step-number-circle">1</div>
                            <div class="step-content">
                                <h4>Siapkan Perangkat</h4>
                                <p>Pastikan Windows Hello, Touch ID, Face ID, atau security key Anda aktif dan siap digunakan.</p>
                            </div>
                        </div>
                        
                        <div class="passkey-step">
                            <div class="step-number-circle">2</div>
                            <div class="step-content">
                                <h4>Klik Tombol Daftar</h4>
                                <p>Browser akan meminta izin untuk menggunakan biometrik atau security key Anda.</p>
                            </div>
                        </div>
                        
                        <div class="passkey-step">
                            <div class="step-number-circle">3</div>
                            <div class="step-content">
                                <h4>Verifikasi Identitas</h4>
                                <p>Gunakan sidik jari, wajah, atau PIN perangkat untuk menyelesaikan pendaftaran.</p>
                            </div>
                        </div>
                    </div>

                    <form id="register-form" action="${url.loginAction}" method="post">
                        <div class="device-name-input">
                            <label class="form-label">Nama Perangkat (Opsional)</label>
                            <div class="input-wrapper">
                                <input type="text" 
                                       id="authenticatorLabel" 
                                       name="authenticatorLabel" 
                                       class="form-input" 
                                       placeholder="Contoh: Laptop Kantor, iPhone Pribadi" 
                                       autocomplete="off" />
                                <i class="ph ph-device-mobile input-icon"></i>
                            </div>
                            <p style="font-size: 0.75rem; color: #64748b; margin-top: 6px; text-align: left;">
                                Beri nama untuk mengidentifikasi perangkat ini di masa mendatang
                            </p>
                        </div>

                        <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                        <input type="hidden" id="attestationObject" name="attestationObject"/>
                        <input type="hidden" id="publicKeyCredentialId" name="publicKeyCredentialId"/>
                        <input type="hidden" id="authenticatorLabel" name="authenticatorLabel"/>
                        <input type="hidden" id="transports" name="transports"/>

                        <div class="button-group-passkey">
                            <#if isAppInitiatedAction?? && isAppInitiatedAction>
                                <a href="${url.loginAction}" class="btn-skip">
                                    <i class="ph ph-x"></i>
                                    Lewati
                                </a>
                            </#if>
                            
                            <button type="button" 
                                    class="main-btn btn-register-passkey" 
                                    id="registerWebAuthnBtn"
                                    onclick="registerWebAuthn()">
                                <i class="ph ph-fingerprint"></i>
                                Daftarkan Passkey Sekarang
                            </button>
                        </div>
                    </form>
                </div>

                <div class="qr-instructions" style="margin-top: 25px;">
                    <h4>Perangkat yang Didukung</h4>
                    <p>• Windows 10/11 dengan Windows Hello</p>
                    <p>• macOS dengan Touch ID atau Face ID</p>
                    <p>• iPhone/iPad dengan Face ID atau Touch ID</p>
                    <p>• Android dengan fingerprint atau face unlock</p>
                    <p>• Hardware security keys (YubiKey, Titan, dll)</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Check WebAuthn support on page load
        window.addEventListener('DOMContentLoaded', function() {
            if (!window.PublicKeyCredential) {
                document.getElementById('registerWebAuthnBtn').disabled = true;
                document.getElementById('registerWebAuthnBtn').innerHTML = '<i class="ph ph-warning"></i> Browser Tidak Didukung';
                
                const alert = document.createElement('div');
                alert.className = 'alert alert-error';
                alert.innerHTML = '<i class="ph ph-x-circle"></i><span>Browser Anda tidak mendukung Passkey. Gunakan Chrome, Edge, Safari, atau Firefox versi terbaru.</span>';
                document.querySelector('.register-passkey-section').prepend(alert);
            }
        });
        
        // WebAuthn Registration Function
        async function registerWebAuthn() {
            const btn = document.getElementById('registerWebAuthnBtn');
            const originalContent = btn.innerHTML;
            
            try {
                // Disable button and show loading
                btn.disabled = true;
                btn.innerHTML = '<i class="ph ph-spinner" style="animation: spin 1s linear infinite;"></i> Menunggu verifikasi...';
                
                // Check browser support
                if (!window.PublicKeyCredential) {
                    throw new Error('Browser tidak mendukung WebAuthn');
                }
                
                // Check if platform authenticator is available
                const available = await PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable();
                if (!available) {
                    throw new Error('Platform authenticator tidak tersedia. Pastikan Windows Hello, Touch ID, atau Face ID sudah aktif.');
                }
                
                // In production, get challenge from Keycloak WebAuthn endpoint
                // For now, show message about configuration
                alert('Fitur Passkey memerlukan konfigurasi WebAuthn di Keycloak.\n\nPastikan:\n1. WebAuthn Passwordless sudah di-enable di Authentication Flow\n2. Required Actions "Webauthn Register Passwordless" sudah ditambahkan\n3. User sudah login dengan password terlebih dahulu\n\nSetelah konfigurasi benar, fitur ini akan bekerja otomatis.');
                
                // TODO: Implement actual WebAuthn registration flow
                // This requires proper integration with Keycloak's WebAuthn API
                
                // Example of how it should work:
                /*
                const publicKeyCredentialCreationOptions = {
                    challenge: Uint8Array.from(challengeFromServer, c => c.charCodeAt(0)),
                    rp: {
                        name: "PEMDA DIY",
                        id: window.location.hostname
                    },
                    user: {
                        id: Uint8Array.from(userId, c => c.charCodeAt(0)),
                        name: username,
                        displayName: displayName
                    },
                    pubKeyCredParams: [{alg: -7, type: "public-key"}],
                    authenticatorSelection: {
                        authenticatorAttachment: "platform",
                        userVerification: "required"
                    },
                    timeout: 60000,
                    attestation: "none"
                };
                
                const credential = await navigator.credentials.create({
                    publicKey: publicKeyCredentialCreationOptions
                });
                
                // Submit credential to Keycloak
                document.getElementById('clientDataJSON').value = arrayBufferToBase64(credential.response.clientDataJSON);
                document.getElementById('attestationObject').value = arrayBufferToBase64(credential.response.attestationObject);
                document.getElementById('publicKeyCredentialId').value = arrayBufferToBase64(credential.rawId);
                
                document.getElementById('register-form').submit();
                */
                
            } catch (error) {
                console.error('WebAuthn registration error:', error);
                alert('Terjadi kesalahan: ' + error.message);
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
