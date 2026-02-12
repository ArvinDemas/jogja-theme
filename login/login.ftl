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
                    <#-- ERROR MESSAGE CONTAINER (Will be filled by cookie if redirected from login.ftl) -->
                    <div id="cookie-error-container"></div>
                    
                    <script>
                    // Read error from cookie (set by login.ftl redirect)
                    (function() {
                        function getCookie(name) {
                            var value = "; " + document.cookie;
                            var parts = value.split("; " + name + "=");
                            if (parts.length === 2) return decodeURIComponent(parts.pop().split(";").shift());
                            return null;
                        }
                        
                        function deleteCookie(name) {
                            document.cookie = name + "=; path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC";
                        }
                        
                        var errorMessage = getCookie('keycloak_login_error');
                        var errorType = getCookie('keycloak_login_error_type');
                        
                        if (errorMessage && errorType === 'error') {
                            var container = document.getElementById('cookie-error-container');
                            
                            // Create error alert
                            var errorAlert = document.createElement('div');
                            errorAlert.className = 'alert alert-error';
                            errorAlert.id = 'login-error-message';
                            errorAlert.innerHTML = '<i class="ph ph-x-circle"></i><span>' + errorMessage + '</span>';
                            container.appendChild(errorAlert);
                            
                            // Delete the cookies after reading
                            deleteCookie('keycloak_login_error');
                            deleteCookie('keycloak_login_error_type');
                        }
                    })();
                    </script>
                    
                    <#-- Server-side error messages (fallback) -->
                    <#if message?has_content && (message.type != 'warning')>
                        <div class="alert alert-${message.type}" id="server-error-message">
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
                <#-- TAB 2: QR CODE LOGIN WITH AUTO-POLLING -->
                <#-- ===================================== -->
                <div id="form-qr" class="hidden">
                    <div class="qr-section">
                        <#-- CEK APAKAH ADA QR CODE DARI EXTENSION -->
                        <#if QRauthImage??>
                            <#-- QR CODE TERSEDIA -->
                            <div class="qr-header">
                                <i class="ph ph-qr-code qr-header-icon"></i>
                                <h3 class="qr-title">Scan QR Code</h3>
                                <p class="qr-subtitle">Gunakan HP Anda untuk login otomatis</p>
                            </div>
                            
                            <div class="qr-code-wrapper">
                                <div class="qr-code-container-main" style="position: relative; transition: transform 0.2s;">
                                    <img src="data:image/png;base64,${QRauthImage}" alt="QR Code" class="qr-code-img" id="qr-code-image"/>
                                </div>
                            </div>
                            
                            <!-- CIRCULAR COUNTDOWN TIMER -->
                            <div style="text-align: center; margin: 20px 0;">
                                <div style="position: relative; display: inline-block;">
                                    <svg width="80" height="80" style="transform: rotate(-90deg);">
                                        <circle cx="40" cy="40" r="35" stroke="#e2e8f0" stroke-width="6" fill="none"/>
                                        <circle id="qr-progress-circle" cx="40" cy="40" r="35" stroke="#0ea5e9" stroke-width="6" fill="none" 
                                                stroke-dasharray="220" stroke-dashoffset="0" style="transition: stroke-dashoffset 1s linear;"/>
                                    </svg>
                                    <div id="qr-timer-text" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 1.2rem; font-weight: 700; color: #0f172a;">90</div>
                                </div>
                                <div id="qr-loading-status" style="margin-top: 10px; font-size: 0.85rem; color: #64748b; font-weight: 500;">
                                    <i class="ph ph-spinner" style="animation: spin 1s linear infinite; vertical-align: middle;"></i> Menunggu Scan
                                </div>
                            </div>
                            
                            <#-- ============================================ -->
                            <#-- SCRIPT AJAIB: AUTO-POLLING (KUNCI SUKSES!) -->
                            <#-- ============================================ -->
                            <script>
                            (function() {
                                // URL saat ini (termasuk session ID)
                                var currentUrl = window.location.href;
                                var pollingInterval = null;
                                var pollCount = 0;
                                var maxPolls = 90; // 90 x 2 detik = 3 menit
                                
                                // Status indicator element
                                var statusEl = document.getElementById('qr-loading-status');
                                
                                // Function to update status
                                function updateStatus(message, color, bgColor) {
                                    if (statusEl) {
                                        statusEl.innerHTML = message;
                                        statusEl.style.color = color;
                                        statusEl.style.background = bgColor;
                                    }
                                }
                                
                                // Polling function
                                function pollLoginStatus() {
                                    pollCount++;
                                    
                                    // Update countdown timer
                                    var remaining = maxPolls - pollCount;
                                    var timerText = document.getElementById('qr-timer-text');
                                    var progressCircle = document.getElementById('qr-progress-circle');
                                    
                                    if (timerText) {
                                        timerText.textContent = remaining;
                                    }
                                    
                                    // Update circular progress (220 is the circle circumference)
                                    var progress = (pollCount / maxPolls) * 220;
                                    if (progressCircle) {
                                        progressCircle.style.strokeDashoffset = progress;
                                    }
                                    
                                    // Update status text only
                                    if (statusEl) {
                                        statusEl.innerHTML = '<i class="ph ph-spinner" style="animation: spin 1s linear infinite; vertical-align: middle;"></i> Menunggu Scan';
                                    }
                                    
                                    // Check if max polls reached
                                    if (pollCount >= maxPolls) {
                                        clearInterval(pollingInterval);
                                        if (statusEl) {
                                            statusEl.innerHTML = '<i class="ph ph-warning" style="vertical-align: middle;"></i> QR Code kedaluwarsa';
                                            statusEl.style.color = '#92400e';
                                        }
                                        if (timerText) {
                                            timerText.textContent = '0';
                                            timerText.style.color = '#ef4444';
                                        }
                                        return;
                                    }
                                    
                                    // Fetch current page to check if redirected
                                    fetch(currentUrl, { 
                                        method: 'GET', 
                                        redirect: 'follow',
                                        credentials: 'same-origin'
                                    })
                                    .then(function(response) {
                                        // Keycloak akan me-redirect jika login sukses.
                                        // Jika URL respons berbeda dengan URL halaman saat ini, berarti sudah masuk dashboard!
                                        if (response.url && response.url !== currentUrl) {
                                            clearInterval(pollingInterval);
                                            if (statusEl) {
                                                statusEl.innerHTML = '<i class="ph ph-check-circle" style="vertical-align: middle;"></i> Berhasil! Mengalihkan...';
                                                statusEl.style.color = '#166534';
                                            }
                                            if (timerText) {
                                                timerText.style.color = '#10b981';
                                            }
                                            
                                            // Redirect to new URL (dashboard)
                                            setTimeout(function() {
                                                window.location.href = response.url;
                                            }, 500);
                                        }
                                    })
                                    .catch(function(err) {
                                        // Error jaringan, continue polling
                                        console.log('Polling... (attempt ' + pollCount + ')', err);
                                    });
                                }
                                
                                // Start polling setiap 2 detik
                                console.log('[QR AUTO-POLLING] Started - checking every 2 seconds');
                                pollingInterval = setInterval(pollLoginStatus, 2000);
                                
                                // Initial poll
                                pollLoginStatus();
                                
                                // Cleanup on page unload
                                window.addEventListener('beforeunload', function() {
                                    if (pollingInterval) {
                                        clearInterval(pollingInterval);
                                    }
                                });
                            })();
                            </script>
                            
                            <div class="qr-instructions-box" style="background: #f0f9ff; border: 1px solid #bfdbfe; border-left: 4px solid #0ea5e9; border-radius: 12px; padding: 18px; margin: 25px 0; text-align: left;">
                                <div class="instruction-header" style="display: flex; align-items: flex-start; gap: 10px; margin-bottom: 10px;">
                                    <i class="ph ph-info" style="font-size: 1.2rem; color: #0ea5e9; margin-top: 2px; flex-shrink: 0;"></i>
                                    <div style="flex: 1;">
                                        <h4 style="font-size: 0.9rem; font-weight: 700; color: #0c4a6e; margin: 0 0 8px 0; font-family: 'Inter', sans-serif;">Cara Menggunakan</h4>
                                        <ol style="margin: 0; padding-left: 18px; color: #0c4a6e; line-height: 1.7; font-size: 0.82rem;">
                                            <li style="margin-bottom: 6px;">Buka kamera atau QR scanner di HP</li>
                                            <li style="margin-bottom: 6px;">Arahkan ke QR code di atas</li>
                                            <li style="margin-bottom: 6px;">Login dengan akun Anda di HP</li>
                                            <li>Halaman ini akan otomatis login</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="qr-action-buttons">
                                <button type="button" onclick="window.location.reload()" class="qr-btn-secondary">
                                    <i class="ph ph-arrow-clockwise"></i> Refresh QR
                                </button>
                                <button type="button" onclick="switchToTab('credential')" class="qr-btn-secondary">
                                    <i class="ph ph-arrow-left"></i> Password
                                </button>
                            </div>
                        <#else>
                            <#-- QR CODE TIDAK TERSEDIA - FETCH VIA IFRAME, USE EXISTING UI -->
                            <div class="qr-header">
                                <i class="ph ph-qr-code qr-header-icon"></i>
                                <h3 class="qr-title">Scan QR Code</h3>
                                <p class="qr-subtitle" id="qr-subtitle-dynamic">Memuat QR Code...</p>
                            </div>
                            
                            <div class="qr-code-wrapper">
                                <div class="qr-code-container-main" id="qr-dynamic-container" style="position: relative; transition: transform 0.2s;">
                                    <!-- Loading state -->
                                    <div id="qr-loading-state" style="text-align: center; padding: 60px 0;">
                                        <i class="ph ph-spinner" style="font-size: 4rem; color: #0ea5e9; animation: spin 1s linear infinite;"></i>
                                        <p style="margin-top: 15px; color: #64748b; font-size: 0.9rem;">Memuat QR Code...</p>
                                    </div>
                                    
                                    <!-- QR Code image (will be populated from iframe) -->
                                    <img id="qr-code-dynamic" alt="QR Code" class="qr-code-img" style="display: none;"/>
                                </div>
                            </div>
                            
                            <!-- CIRCULAR COUNTDOWN TIMER (Same as normal QR) -->
                            <div id="qr-timer-section" style="display: none; text-align: center; margin: 20px 0;">
                                <div style="position: relative; display: inline-block;">
                                    <svg width="80" height="80" style="transform: rotate(-90deg);">
                                        <circle cx="40" cy="40" r="35" stroke="#e2e8f0" stroke-width="6" fill="none"/>
                                        <circle id="qr-progress-circle-dynamic" cx="40" cy="40" r="35" stroke="#0ea5e9" stroke-width="6" fill="none" 
                                                stroke-dasharray="220" stroke-dashoffset="0" style="transition: stroke-dashoffset 1s linear;"/>
                                    </svg>
                                    <div id="qr-timer-text-dynamic" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 1.2rem; font-weight: 700; color: #0f172a;">90</div>
                                </div>
                                <div id="qr-loading-status-dynamic" style="margin-top: 10px; font-size: 0.85rem; color: #64748b; font-weight: 500;">
                                    <i class="ph ph-spinner" style="animation: spin 1s linear infinite; vertical-align: middle;"></i> Menunggu Scan
                                </div>
                            </div>
                            
                            <!-- Hidden iframe to fetch QR session -->
                            <iframe id="qr-fetch-iframe" style="display: none; position: absolute; width: 1px; height: 1px; opacity: 0;"></iframe>
                            
                            <!-- Instructions (Same as normal QR) -->
                            <div id="qr-instructions" style="display: none;" class="qr-instructions-box">
                                <div class="instruction-header" style="display: flex; align-items: flex-start; gap: 10px; margin-bottom: 10px;">
                                    <i class="ph ph-info" style="font-size: 1.2rem; color: #0ea5e9; margin-top: 2px; flex-shrink: 0;"></i>
                                    <div style="flex: 1;">
                                        <h4 style="font-size: 0.9rem; font-weight: 700; color: #0c4a6e; margin: 0 0 8px 0; font-family: 'Inter', sans-serif;">Cara Menggunakan</h4>
                                        <ol style="margin: 0; padding-left: 18px; color: #0c4a6e; line-height: 1.7; font-size: 0.82rem;">
                                            <li style="margin-bottom: 6px;">Buka kamera atau QR scanner di HP</li>
                                            <li style="margin-bottom: 6px;">Arahkan ke QR code di atas</li>
                                            <li style="margin-bottom: 6px;">Login dengan akun Anda di HP</li>
                                            <li>Halaman ini akan otomatis login</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Action buttons -->
                            <div id="qr-actions" class="qr-action-buttons" style="display: none;">
                                <button type="button" onclick="window.location.reload()" class="qr-btn-secondary">
                                    <i class="ph ph-arrow-clockwise"></i> Refresh QR
                                </button>
                                <button type="button" onclick="switchToTab('credential')" class="qr-btn-secondary">
                                    <i class="ph ph-arrow-left"></i> Password
                                </button>
                            </div>
                            
                            <!-- Error state -->
                            <div id="qr-error-state" style="display: none; text-align: center; padding: 20px;">
                                <i class="ph ph-warning-circle" style="font-size: 3rem; color: #f59e0b;"></i>
                                <p style="margin-top: 15px; color: #64748b; font-size: 0.9rem;">Gagal memuat QR Code</p>
                                <button type="button" onclick="retryLoadQR()" class="main-btn" style="margin-top: 20px;">
                                    <i class="ph ph-arrow-clockwise"></i> Coba Lagi
                                </button>
                                <button type="button" onclick="switchToTab('credential')" class="secondary-btn" style="margin-top: 10px;">
                                    <i class="ph ph-arrow-left"></i> Kembali ke Login
                                </button>
                            </div>
                            
                            <script>
                            // Fetch QR code data via hidden iframe, inject into existing UI
                            (function() {
                                var iframe = document.getElementById('qr-fetch-iframe');
                                var loadingState = document.getElementById('qr-loading-state');
                                var qrImage = document.getElementById('qr-code-dynamic');
                                var timerSection = document.getElementById('qr-timer-section');
                                var instructions = document.getElementById('qr-instructions');
                                var actions = document.getElementById('qr-actions');
                                var errorState = document.getElementById('qr-error-state');
                                var subtitle = document.getElementById('qr-subtitle-dynamic');
                                var currentUrl = window.location.href;
                                var retryCount = 0;
                                var maxRetries = 3;
                                var countdownInterval;
                                
                                function loadQRData() {
                                    console.log('[QR Fetch] Loading QR data via iframe, attempt:', retryCount + 1);
                                    
                                    // Show loading state
                                    loadingState.style.display = 'block';
                                    qrImage.style.display = 'none';
                                    timerSection.style.display = 'none';
                                    instructions.style.display = 'none';
                                    actions.style.display = 'none';
                                    errorState.style.display = 'none';
                                    subtitle.textContent = 'Memuat QR Code...';
                                    
                                    // Load iframe
                                    iframe.onload = function() {
                                        console.log('[QR Fetch] Iframe loaded, extracting QR...');
                                        
                                        setTimeout(function() {
                                            try {
                                                var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                                                var iframeQR = iframeDoc.querySelector('img[alt="QR Code"]');
                                                
                                                if (iframeQR && iframeQR.src) {
                                                    console.log('[QR Fetch] QR data extracted successfully!');
                                                    
                                                    // Inject QR image into our UI
                                                    qrImage.src = iframeQR.src;
                                                    
                                                    // Show beautiful UI
                                                    loadingState.style.display = 'none';
                                                    qrImage.style.display = 'block';
                                                    timerSection.style.display = 'block';
                                                    instructions.style.display = 'block';
                                                    actions.style.display = 'flex';
                                                    subtitle.textContent = 'Gunakan HP Anda untuk login otomatis';
                                                    
                                                    // Start countdown timer (90 seconds)
                                                    startCountdown();
                                                    
                                                    // Start polling (copy from normal QR flow)
                                                    startPolling();
                                                } else {
                                                    throw new Error('QR image not found in iframe');
                                                }
                                            } catch (e) {
                                                console.error('[QR Fetch] Error:', e);
                                                retryCount++;
                                                
                                                if (retryCount < maxRetries) {
                                                    console.log('[QR Fetch] Retrying in 2s...');
                                                    setTimeout(loadQRData, 2000);
                                                } else {
                                                    // Show error
                                                    loadingState.style.display = 'none';
                                                    errorState.style.display = 'block';
                                                    subtitle.textContent = 'Gagal memuat QR Code';
                                                }
                                            }
                                        }, 1000);
                                    };
                                    
                                    iframe.src = currentUrl;
                                }
                                
                                function startCountdown() {
                                    var timeLeft = 90;
                                    var timerText = document.getElementById('qr-timer-text-dynamic');
                                    var progressCircle = document.getElementById('qr-progress-circle-dynamic');
                                    var circumference = 220;
                                    
                                    if (countdownInterval) clearInterval(countdownInterval);
                                    
                                    countdownInterval = setInterval(function() {
                                        timeLeft--;
                                        timerText.textContent = timeLeft;
                                        
                                        var offset = (circumference * (90 - timeLeft)) / 90;
                                        progressCircle.style.strokeDashoffset = offset;
                                        
                                        if (timeLeft <= 0) {
                                            clearInterval(countdownInterval);
                                            window.location.reload();
                                        }
                                    }, 1000);
                                }
                                
                                function startPolling() {
                                    // Copy polling logic from normal QR flow
                                    var pollingInterval = setInterval(function() {
                                        fetch(currentUrl, { method: 'GET', credentials: 'same-origin' })
                                            .then(function(response) {
                                                if (response.redirected || response.url !== currentUrl) {
                                                    clearInterval(pollingInterval);
                                                    window.location.href = response.url;
                                                }
                                            })
                                            .catch(function(e) {
                                                console.log('[QR Fetch] Polling error:', e);
                                            });
                                    }, 2000);
                                }
                                
                                window.retryLoadQR = function() {
                                    retryCount = 0;
                                    loadQRData();
                                };
                                
                                // Auto-load on page ready
                                loadQRData();
                            })();
                            </script>
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
    
    <#-- Tab Switching & WebAuthn Authentication Script -->
    <script>
        // ==========================================
        // TAB SWITCHING FUNCTIONALITY
        // ==========================================
        document.addEventListener('DOMContentLoaded', function() {
            // Get all tab buttons
            const tabCredential = document.getElementById('tab-credential');
            const tabQr = document.getElementById('tab-qr');
            const tabPasskey = document.getElementById('tab-passkey');
            
            // Add click event listeners
            if (tabCredential) {
                tabCredential.addEventListener('click', function() {
                    switchToTab('credential');
                });
            }
            
            if (tabQr) {
                tabQr.addEventListener('click', function() {
                    switchToTab('qr');
                });
            }
            
            if (tabPasskey) {
                tabPasskey.addEventListener('click', function() {
                    switchToTab('passkey');
                });
            }
        });
        
        // Function to switch tabs programmatically
        function switchToTab(tabName) {
            const tabs = {
                'credential': {btn: document.getElementById('tab-credential'), form: document.getElementById('form-credential')},
                'qr': {btn: document.getElementById('tab-qr'), form: document.getElementById('form-qr')},
                'passkey': {btn: document.getElementById('tab-passkey'), form: document.getElementById('form-passkey')}
            };
            
            // Remove all active states
            Object.values(tabs).forEach(tab => {
                if (tab.btn) tab.btn.classList.remove('active');
                if (tab.form) tab.form.classList.add('hidden');
            });
            
            // Activate selected tab
            if (tabs[tabName]) {
                if (tabs[tabName].btn) tabs[tabName].btn.classList.add('active');
                if (tabs[tabName].form) tabs[tabName].form.classList.remove('hidden');
            }
        }
        
        // ==========================================
        // WEBAUTHN / PASSKEY AUTHENTICATION
        // ==========================================
        async function authenticateWithPasskey() {
            if (!window.PublicKeyCredential) {
                alert('Browser Anda tidak mendukung Passkey. Gunakan Chrome, Edge, atau Safari versi terbaru.');
                return;
            }
            
            const btn = event.target.closest('button');
            const originalContent = btn.innerHTML;
            btn.disabled = true;
            btn.innerHTML = '<i class="ph ph-spinner" style="animation: spin 1s linear infinite;"></i><span>Memproses...</span>';
            
            try {
                const available = await PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable();
                
                if (available) {
                    const publicKeyCredentialRequestOptions = {
                        challenge: new Uint8Array(32),
                        timeout: 60000,
                        userVerification: 'required'
                    };
                    
                    const credential = await navigator.credentials.get({
                        publicKey: publicKeyCredentialRequestOptions
                    });
                    
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
