<#import "template.ftl" as layout>
<#-- HAPUS "; section" DI BAWAH INI KARENA BIKIN ERROR DI BASE THEME -->
<@layout.mainLayout active='account' bodyClass='user'>

    <#-- BANNER SELAMAT DATANG -->
    <div class="card full-width" style="margin-bottom: 20px;">
        <div class="welcome-message">
            <h1>Selamat Datang! 🎉</h1>
            <p>Anda telah berhasil masuk ke Portal SSO Pemda DIY.</p>
        </div>
    </div>

    <#-- PESAN ERROR/SUKSES (DENGAN NULL CHECK KETAT) -->
    <#if message?has_content>
        <div class="card full-width" style="margin-bottom: 20px; padding: 15px; border-radius: 12px; background: rgba(56, 189, 248, 0.1); border: 1px solid #38bdf8; color: white;">
            <div style="display: flex; align-items: center; gap: 10px;">
                <i class="ph ph-info" style="font-size: 1.2rem;"></i>
                <span>${message.summary!'Pesan sistem'}</span>
            </div>
        </div>
    </#if>

    <div class="content">
        <#-- KARTU 1: INFORMASI PENGGUNA -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon">
                    <i class="ph ph-user" weight="fill"></i>
                </div>
                <h2>Informasi Akun</h2>
            </div>
            
            <div class="info-group">
                <div class="info-row">
                    <span class="info-label">Username</span>
                    <#-- Cek apakah account ada isinya -->
                    <span class="info-value">${(account.username!'Guest')}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Email</span>
                    <span class="info-value">${(account.email!'Email belum diatur')}</span>
                </div>
                <div class="info-row">
                    <span class="info-label">Nama Lengkap</span>
                    <span class="info-value">${(account.firstName!'')} ${(account.lastName!'')}</span>
                </div>
                
                <div style="margin-top: 20px; text-align: right;">
                    <a href="${url.accountUrl}?referrer=${referrer!''}&mode=edit" style="display: inline-flex; align-items: center; gap: 5px; color: #38bdf8; text-decoration: none; font-size: 0.9rem; font-weight: 600;">
                        <i class="ph ph-pencil-simple"></i> Edit Profil
                    </a>
                </div>
            </div>
        </div>
        
        <#-- KARTU 2: KEAMANAN -->
        <div class="card">
            <div class="card-header">
                <div class="card-icon">
                    <i class="ph ph-shield-check" weight="fill"></i>
                </div>
                <h2>Keamanan</h2>
            </div>
            
            <div class="info-group">
                <div class="info-row">
                    <span class="info-label">Password</span>
                    <a href="${url.passwordUrl}" style="color: #38bdf8; text-decoration: none; font-weight: 600;">Ubah Password</a>
                </div>
                <div class="info-row">
                    <span class="info-label">Authenticator (2FA)</span>
                    <a href="${url.totpUrl}" style="color: #38bdf8; text-decoration: none; font-weight: 600;">Konfigurasi OTP</a>
                </div>
                <div class="info-row">
                    <span class="info-label">Status Verifikasi</span>
                    <#if account?? && account.emailVerified?? && account.emailVerified>
                        <span class="success-badge">✓ Email Terverifikasi</span>
                    <#else>
                        <span style="color: #fca5a5; font-weight: 600; font-size: 0.85rem;">✗ Email Belum Verifikasi</span>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <#-- KARTU 3: TAUTAN -->
    <div class="card full-width">
        <div class="card-header">
            <div class="card-icon">
                <i class="ph ph-squares-four" weight="fill"></i>
            </div>
            <h2>Layanan Terhubung</h2>
        </div>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 10px;">
            <a href="https://jogjaprov.go.id" target="_blank" class="app-link">
                <i class="ph ph-house"></i>
                <span>Portal Resmi</span>
            </a>
            <a href="#" class="app-link">
                <i class="ph ph-files"></i>
                <span>E-Layanan</span>
            </a>
            <a href="#" class="app-link">
                <i class="ph ph-life-buoy"></i>
                <span>Bantuan</span>
            </a>
        </div>
    </div>

</@layout.mainLayout>