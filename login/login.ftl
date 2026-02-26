<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Portal Pemda DIY</title>
    <link href="${url.resourcesPath}/css/login.css" rel="stylesheet" />
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
                <div class="brand-text"><h1>Pemerintah Daerah</h1><p>Daerah Istimewa Yogyakarta</p></div>
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

                        <#if realm.rememberMe>
                            <div style="margin: 4px 0 18px 0;">
                                <label style="display: flex; align-items: center; gap: 8px; cursor: pointer; user-select: none; font-size: 0.88rem; color: #334155; font-family: 'Inter', sans-serif;">
                                    <input type="checkbox" id="rememberMe" name="rememberMe" value="on" tabindex="3"
                                           <#if login.rememberMe??>checked</#if>
                                           style="width: 16px; height: 16px; accent-color: #0ea5e9; cursor: pointer;" />
                                    Ingat Saya
                                </label>
                            </div>
                        </#if>

                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <button tabindex="4" class="main-btn" name="login" id="kc-login" type="submit">Masuk Sekarang</button>
                    </form>
                </div>

                <#-- ===================================== -->
                <#-- TAB 2: QR CODE LOGIN WITH AUTO-POLLING -->
                <#-- ===================================== -->
                <div id="form-qr" class="hidden">
                    <div class="qr-section">
                        <div class="qr-header">
                            <i class="ph ph-qr-code qr-header-icon"></i>
                            <h3 class="qr-title">Login dengan QR Code</h3>
                            <p class="qr-subtitle">Klik tombol di bawah untuk memunculkan QR</p>
                        </div>

                        <#-- Hidden data element for QR (same as reference) -->
                        <#if QRauthImage??>
                            <div id="qr-auth-data"
                                 data-qr-image="${QRauthImage}"
                                 data-qr-exec-id="${QRauthExecId!''}"
                                 data-qr-tab-id="${QRauthTabId!''}"
                                 style="display: none;">
                            </div>
                        </#if>

                        <button type="button" class="main-btn" onclick="showQRModal()" style="margin-top: 20px;">
                            <i class="ph ph-qr-code"></i> Tampilkan QR Code
                        </button>

                        <p style="margin-top: 16px; font-size: 0.82rem; color: #64748b; text-align: center;">
                            QR Code akan muncul dalam popup.<br>Scan menggunakan aplikasi mobile PEMDA DIY.
                        </p>
                    </div>

                    <#-- ============================================ -->
                    <#-- MODAL QR CODE + POLLING SCRIPTS              -->
                    <#-- ============================================ -->
                    <script>
                    (function() {
                        var qrPollingInterval = null;
                        var qrCountdownInterval = null;
                        var QR_TIMEOUT_SECONDS = 1800; // 30 menit

                        // Determine smart redirect URL after successful QR login
                        function getSmartRedirectUrl() {
                            // Try 1: client_data URL param (base64 encoded)
                            try {
                                var params = new URLSearchParams(window.location.search);
                                var clientData = params.get('client_data');
                                if (clientData) {
                                    var decoded = JSON.parse(atob(clientData));
                                    if (decoded && decoded.redirect_uri) return decoded.redirect_uri;
                                }
                            } catch (e) {}

                            // Try 2: Freemarker client baseUrl
                            <#if (client.baseUrl)??>
                            var baseUrl = '${(client.baseUrl)!}';
                            if (baseUrl && baseUrl.length > 0) return baseUrl;
                            </#if>

                            // Fallback: hostname + :3000
                            return window.location.protocol + '//' + window.location.hostname + ':3000';
                        }

                        // Show the QR Modal popup
                        window.showQRModal = function() {
                            // Remove existing modal if any
                            var existing = document.getElementById('qr-modal-overlay');
                            if (existing) existing.remove();

                            var qrDataEl = document.getElementById('qr-auth-data');
                            var qrImage = qrDataEl ? qrDataEl.getAttribute('data-qr-image') : null;
                            var execId = qrDataEl ? qrDataEl.getAttribute('data-qr-exec-id') : '';

                            if (!qrImage) {
                                alert('QR Code tidak tersedia. Pastikan QR Login extension sudah diaktifkan di Keycloak.');
                                return;
                            }

                            // Build modal HTML
                            var overlay = document.createElement('div');
                            overlay.id = 'qr-modal-overlay';
                            overlay.style.cssText = 'position:fixed;inset:0;background:rgba(15,23,42,0.6);backdrop-filter:blur(4px);display:flex;align-items:center;justify-content:center;z-index:9999;animation:qrFadeIn 0.25s ease;';

                            overlay.innerHTML = ''
                                + '<div id="qr-modal-card" style="background:#fff;border-radius:20px;box-shadow:0 25px 60px rgba(0,0,0,0.25);max-width:720px;width:92%;max-height:90vh;overflow-y:auto;position:relative;animation:qrSlideUp 0.3s ease;">'
                                +   '<button onclick="closeQRModal()" style="position:absolute;top:14px;right:14px;background:none;border:none;cursor:pointer;padding:6px;border-radius:8px;color:#64748b;font-size:1.4rem;transition:all 0.2s;z-index:1;" onmouseover="this.style.background=\'#f1f5f9\';this.style.color=\'#0f172a\'" onmouseout="this.style.background=\'none\';this.style.color=\'#64748b\'"><i class="ph ph-x"></i></button>'
                                +   '<div style="display:flex;flex-wrap:wrap;">'
                                +     '<div style="flex:1;min-width:260px;padding:32px;text-align:center;border-right:1px solid #e2e8f0;">'
                                +       '<h3 style="font-family:\'Playfair Display\',serif;font-size:1.3rem;color:#0f172a;margin-bottom:6px;">Scan QR Code</h3>'
                                +       '<p style="font-size:0.82rem;color:#64748b;margin-bottom:20px;">Gunakan HP untuk login otomatis</p>'
                                +       '<div style="background:#f8fafc;border-radius:16px;padding:20px;display:inline-block;border:2px solid #e2e8f0;">'
                                +         '<img id="qr-modal-image" src="data:image/png;base64,' + qrImage + '" alt="QR Code" style="width:200px;height:200px;display:block;" />'
                                +       '</div>'
                                +       '<div style="margin-top:18px;">'
                                +         '<div style="position:relative;display:inline-block;">'
                                +           '<svg width="64" height="64" style="transform:rotate(-90deg);">'
                                +             '<circle cx="32" cy="32" r="28" stroke="#e2e8f0" stroke-width="5" fill="none"/>'
                                +             '<circle id="qr-modal-progress" cx="32" cy="32" r="28" stroke="#0ea5e9" stroke-width="5" fill="none" stroke-dasharray="176" stroke-dashoffset="0" style="transition:stroke-dashoffset 1s linear;"/>'
                                +           '</svg>'
                                +           '<div id="qr-modal-timer" style="position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);font-size:1rem;font-weight:700;color:#0f172a;">' + QR_TIMEOUT_SECONDS + '</div>'
                                +         '</div>'
                                +         '<div id="qr-modal-status" style="margin-top:8px;font-size:0.82rem;color:#64748b;font-weight:500;"><i class="ph ph-spinner" style="animation:spin 1s linear infinite;vertical-align:middle;"></i> Menunggu scan...</div>'
                                +       '</div>'
                                +       '<button type="button" onclick="refreshQRCode()" style="margin-top:14px;padding:8px 18px;background:none;border:1px solid #cbd5e1;border-radius:10px;color:#334155;font-size:0.82rem;font-weight:600;cursor:pointer;font-family:\'Inter\',sans-serif;transition:all 0.2s;" onmouseover="this.style.borderColor=\'#0ea5e9\';this.style.color=\'#0ea5e9\'" onmouseout="this.style.borderColor=\'#cbd5e1\';this.style.color=\'#334155\'"><i class="ph ph-arrow-clockwise"></i> Refresh QR</button>'
                                +     '</div>'
                                +     '<div style="flex:1;min-width:240px;padding:32px;">'
                                +       '<h4 style="font-family:\'Inter\',sans-serif;font-size:0.92rem;font-weight:700;color:#0f172a;margin-bottom:18px;"><i class="ph ph-list-numbers" style="color:#0ea5e9;margin-right:6px;"></i>Cara Menggunakan</h4>'
                                +       '<div style="display:flex;flex-direction:column;gap:16px;">'
                                +         '<div style="display:flex;gap:12px;align-items:flex-start;">'
                                +           '<div style="width:28px;height:28px;background:#e0f2fe;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><span style="font-size:0.8rem;font-weight:700;color:#0ea5e9;">1</span></div>'
                                +           '<div><p style="font-size:0.84rem;color:#334155;margin:0;font-weight:600;">Buka Aplikasi Mobile</p><p style="font-size:0.78rem;color:#64748b;margin:3px 0 0 0;">Buka aplikasi PEMDA DIY di HP Anda</p></div>'
                                +         '</div>'
                                +         '<div style="display:flex;gap:12px;align-items:flex-start;">'
                                +           '<div style="width:28px;height:28px;background:#e0f2fe;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><span style="font-size:0.8rem;font-weight:700;color:#0ea5e9;">2</span></div>'
                                +           '<div><p style="font-size:0.84rem;color:#334155;margin:0;font-weight:600;">Scan QR Code</p><p style="font-size:0.78rem;color:#64748b;margin:3px 0 0 0;">Arahkan kamera ke QR code di sebelah kiri</p></div>'
                                +         '</div>'
                                +         '<div style="display:flex;gap:12px;align-items:flex-start;">'
                                +           '<div style="width:28px;height:28px;background:#e0f2fe;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><span style="font-size:0.8rem;font-weight:700;color:#0ea5e9;">3</span></div>'
                                +           '<div><p style="font-size:0.84rem;color:#334155;margin:0;font-weight:600;">Konfirmasi Login</p><p style="font-size:0.78rem;color:#64748b;margin:3px 0 0 0;">Konfirmasi login di HP Anda</p></div>'
                                +         '</div>'
                                +         '<div style="display:flex;gap:12px;align-items:flex-start;">'
                                +           '<div style="width:28px;height:28px;background:#dcfce7;border-radius:8px;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="ph ph-check" style="font-size:0.85rem;color:#10b981;"></i></div>'
                                +           '<div><p style="font-size:0.84rem;color:#334155;margin:0;font-weight:600;">Otomatis Login</p><p style="font-size:0.78rem;color:#64748b;margin:3px 0 0 0;">Halaman ini akan login otomatis</p></div>'
                                +         '</div>'
                                +       '</div>'
                                +       '<div style="margin-top:24px;padding:14px;background:#fffbeb;border:1px solid #fef3c7;border-radius:10px;">'
                                +         '<p style="font-size:0.78rem;color:#92400e;margin:0;line-height:1.5;"><i class="ph ph-info" style="vertical-align:middle;margin-right:4px;"></i><strong>QR berlaku ' + QR_TIMEOUT_SECONDS + ' detik.</strong> Klik Refresh jika kedaluwarsa.</p>'
                                +       '</div>'
                                +     '</div>'
                                +   '</div>'
                                + '</div>';

                            document.body.appendChild(overlay);

                            // Close on overlay click (not card)
                            overlay.addEventListener('click', function(e) {
                                if (e.target === overlay) closeQRModal();
                            });

                            // Start polling
                            startQRPolling(execId);
                        };

                        // Start polling via iframe form POST + cross-origin detection
                        function startQRPolling(execId) {
                            var timeLeft = QR_TIMEOUT_SECONDS;
                            var circumference = 176;
                            var timerEl = document.getElementById('qr-modal-timer');
                            var progressEl = document.getElementById('qr-modal-progress');
                            var statusEl = document.getElementById('qr-modal-status');

                            // Countdown
                            qrCountdownInterval = setInterval(function() {
                                timeLeft--;
                                if (timerEl) timerEl.textContent = timeLeft > 0 ? timeLeft : 0;
                                if (progressEl) {
                                    progressEl.style.strokeDashoffset = (circumference * (QR_TIMEOUT_SECONDS - timeLeft)) / QR_TIMEOUT_SECONDS;
                                }
                                if (timeLeft <= 0) {
                                    clearInterval(qrCountdownInterval);
                                    clearInterval(qrPollingInterval);
                                    if (statusEl) statusEl.innerHTML = '<i class="ph ph-warning" style="color:#f59e0b;"></i> <span style="color:#92400e;">QR kedaluwarsa. Klik Refresh.</span>';
                                }
                            }, 1000);

                            // Poll via hidden iframe POST
                            qrPollingInterval = setInterval(function() {
                                checkAuthStatus(execId);
                            }, 3000);

                            // Immediate first check
                            checkAuthStatus(execId);
                        }

                        // Check auth status: iframe form POST + cross-origin try/catch
                        function checkAuthStatus(execId) {
                            var actionUrl = '${url.loginAction}';

                            // Create hidden iframe for polling
                            var pollFrame = document.createElement('iframe');
                            pollFrame.style.cssText = 'display:none;width:0;height:0;border:0;';
                            pollFrame.name = 'qr-poll-frame-' + Date.now();
                            document.body.appendChild(pollFrame);

                            // Create form targeting the iframe
                            var form = document.createElement('form');
                            form.method = 'POST';
                            form.action = actionUrl;
                            form.target = pollFrame.name;
                            form.style.display = 'none';

                            var input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'authenticationExecution';
                            input.value = execId;
                            form.appendChild(input);

                            document.body.appendChild(form);

                            pollFrame.onload = function() {
                                try {
                                    // If we can access iframe content, auth is still pending (same origin)
                                    var iframeUrl = pollFrame.contentWindow.location.href;
                                    // Still on the same Keycloak page — not authenticated yet
                                } catch (e) {
                                    // Cross-origin security error = Keycloak redirected to the client app
                                    // This means authentication succeeded!
                                    clearInterval(qrPollingInterval);
                                    clearInterval(qrCountdownInterval);

                                    var statusEl = document.getElementById('qr-modal-status');
                                    if (statusEl) statusEl.innerHTML = '<i class="ph ph-check-circle" style="color:#10b981;"></i> <span style="color:#166534;font-weight:600;">Login berhasil! Mengalihkan...</span>';

                                    // Redirect to the dashboard
                                    setTimeout(function() {
                                        var redirectUrl = getSmartRedirectUrl();
                                        var realmBase = window.location.href.split('/login-actions/')[0];
                                        var params = new URLSearchParams(window.location.search);
                                        var clientId = params.get('client_id') || 'pemda-dashboard';
                                        window.location.href = realmBase + '/protocol/openid-connect/auth'
                                            + '?client_id=' + encodeURIComponent(clientId)
                                            + '&redirect_uri=' + encodeURIComponent(redirectUrl)
                                            + '&response_type=code&scope=openid&prompt=none';
                                    }, 500);
                                }

                                // Cleanup
                                setTimeout(function() {
                                    if (form.parentNode) form.parentNode.removeChild(form);
                                    if (pollFrame.parentNode) pollFrame.parentNode.removeChild(pollFrame);
                                }, 100);
                            };

                            // Submit the form
                            form.submit();
                        }

                        // Refresh QR Code without reloading the main page
                        window.refreshQRCode = function() {
                            clearInterval(qrPollingInterval);
                            clearInterval(qrCountdownInterval);

                            var statusEl = document.getElementById('qr-modal-status');
                            if (statusEl) statusEl.innerHTML = '<i class="ph ph-spinner" style="animation:spin 1s linear infinite;vertical-align:middle;"></i> Memuat QR baru...';

                            // Fetch a new QR code from the current login page
                            fetch(window.location.href, {
                                method: 'GET',
                                credentials: 'same-origin'
                            }).then(function(response) {
                                return response.text();
                            }).then(function(html) {
                                // Parse the HTML to extract QR data
                                var parser = new DOMParser();
                                var doc = parser.parseFromString(html, 'text/html');
                                var newQrData = doc.getElementById('qr-auth-data');

                                if (newQrData) {
                                    var newImage = newQrData.getAttribute('data-qr-image');
                                    var newExecId = newQrData.getAttribute('data-qr-exec-id');

                                    // Update the displayed QR
                                    var imgEl = document.getElementById('qr-modal-image');
                                    if (imgEl && newImage) imgEl.src = 'data:image/png;base64,' + newImage;

                                    // Update hidden data element too
                                    var dataEl = document.getElementById('qr-auth-data');
                                    if (dataEl) {
                                        dataEl.setAttribute('data-qr-image', newImage);
                                        dataEl.setAttribute('data-qr-exec-id', newExecId);
                                    }

                                    // Restart polling with new execId
                                    resetQRTimer(newExecId);
                                } else {
                                    if (statusEl) statusEl.innerHTML = '<i class="ph ph-warning" style="color:#f59e0b;"></i> <span style="color:#92400e;">Gagal memuat QR baru.</span>';
                                }
                            }).catch(function() {
                                if (statusEl) statusEl.innerHTML = '<i class="ph ph-warning" style="color:#f59e0b;"></i> <span style="color:#92400e;">Gagal refresh. Coba lagi.</span>';
                            });
                        };

                        // Reset QR timer and restart polling
                        function resetQRTimer(execId) {
                            var timerEl = document.getElementById('qr-modal-timer');
                            var progressEl = document.getElementById('qr-modal-progress');
                            if (timerEl) timerEl.textContent = QR_TIMEOUT_SECONDS;
                            if (progressEl) progressEl.style.strokeDashoffset = '0';

                            startQRPolling(execId);
                        }

                        // Close the QR Modal and cleanup
                        window.closeQRModal = function() {
                            clearInterval(qrPollingInterval);
                            clearInterval(qrCountdownInterval);
                            qrPollingInterval = null;
                            qrCountdownInterval = null;

                            var overlay = document.getElementById('qr-modal-overlay');
                            if (overlay) {
                                overlay.style.animation = 'qrFadeOut 0.2s ease';
                                setTimeout(function() {
                                    if (overlay.parentNode) overlay.parentNode.removeChild(overlay);
                                }, 200);
                            }
                        };

                        // Close on Escape key
                        document.addEventListener('keydown', function(e) {
                            if (e.key === 'Escape') closeQRModal();
                        });
                    })();
                    </script>
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
        @keyframes qrFadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes qrFadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
        @keyframes qrSlideUp {
            from { opacity: 0; transform: translateY(30px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }
    </style>
    
    <script src="${url.resourcesPath}/js/login.js"></script>
</body>
</html>
