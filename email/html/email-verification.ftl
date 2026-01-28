<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verifikasi Email</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8fafc; padding: 20px; }
        .email-container { max-width: 600px; margin: 0 auto; background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1); }
        .header { background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%); padding: 40px 30px; text-align: center; }
        .logo-box { width: 80px; height: 80px; background: white; border-radius: 16px; margin: 0 auto 20px; padding: 10px; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2); }
        .logo-box img { width: 100%; height: 100%; object-fit: contain; }
        .header h1 { color: white; font-size: 28px; margin-bottom: 8px; font-weight: 700; }
        .header p { color: #cbd5e1; font-size: 15px; }
        .content { padding: 40px 30px; }
        .greeting { font-size: 20px; font-weight: 600; color: #0f172a; margin-bottom: 20px; }
        .message { font-size: 15px; line-height: 1.7; color: #475569; margin-bottom: 30px; }
        .button-container { text-align: center; margin: 35px 0; }
        .verify-button { display: inline-block; padding: 16px 40px; background: #0f172a; color: white; text-decoration: none; border-radius: 12px; font-weight: 600; font-size: 16px; box-shadow: 0 10px 25px rgba(15, 23, 42, 0.2); transition: all 0.3s ease; }
        .verify-button:hover { background: #1e293b; transform: translateY(-2px); box-shadow: 0 15px 35px rgba(15, 23, 42, 0.3); }
        .link-box { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; padding: 15px; margin: 25px 0; word-break: break-all; }
        .link-text { color: #0ea5e9; font-size: 13px; font-family: monospace; }
        .info-box { background: #eff6ff; border-left: 4px solid #0ea5e9; padding: 15px; border-radius: 8px; margin: 25px 0; }
        .info-box p { font-size: 14px; color: #334155; line-height: 1.6; margin: 0; }
        .footer { background: #f8fafc; padding: 30px; text-align: center; border-top: 1px solid #e2e8f0; }
        .footer p { font-size: 13px; color: #64748b; margin: 5px 0; }
        .social-links { margin: 20px 0; }
        .social-link { display: inline-block; margin: 0 8px; color: #64748b; text-decoration: none; font-size: 13px; }
        .divider { height: 1px; background: #e2e8f0; margin: 25px 0; }
    </style>
</head>
<body>
    <div class="email-container">
        <div class="header">
            <div class="logo-box">
                <img src="https://jogjaprov.go.id/storage/files/shares/page/1518066730_2d84b769e3cc9d6f06f8c91a6c3e285c.jpg" alt="Logo DIY">
            </div>
            <h1>PEMDA DIY</h1>
            <p>Portal Single Sign-On</p>
        </div>
        
        <div class="content">
            <div class="greeting">Halo, ${user.firstName!""}!</div>
            
            <div class="message">
                <p>Terima kasih telah mendaftar di <strong>Portal SSO Pemda DIY</strong>. Untuk mengaktifkan akun Anda, silakan verifikasi alamat email dengan mengklik tombol di bawah ini:</p>
            </div>
            
            <div class="button-container">
                <a href="${link}" class="verify-button">Verifikasi Email Saya</a>
            </div>
            
            <div class="link-box">
                <p style="font-size: 13px; color: #64748b; margin-bottom: 8px;">Atau salin tautan berikut ke browser Anda:</p>
                <p class="link-text">${link}</p>
            </div>
            
            <div class="info-box">
                <p><strong>⏰ Penting:</strong> Tautan verifikasi ini akan kedaluwarsa dalam <strong>${linkExpiration} menit</strong>. Jika Anda tidak meminta pendaftaran ini, abaikan email ini.</p>
            </div>
            
            <div class="divider"></div>
            
            <div class="message">
                <p><strong>Tips Keamanan:</strong></p>
                <ul style="margin-left: 20px; color: #475569; line-height: 1.8;">
                    <li>Jangan bagikan password Anda kepada siapapun</li>
                    <li>Aktifkan 2FA untuk keamanan tambahan</li>
                    <li>Ganti password secara berkala</li>
                </ul>
            </div>
        </div>
        
        <div class="footer">
            <p style="font-weight: 600; color: #0f172a; margin-bottom: 15px;">Butuh bantuan?</p>
            <div class="social-links">
                <a href="https://wiki.jogjaprov.go.id/diskominfo/panduan/panduan-2fa" class="social-link">📖 Panduan</a>
                <span style="color: #cbd5e1;">•</span>
                <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" class="social-link">💬 Kontak</a>
                <span style="color: #cbd5e1;">•</span>
                <a href="https://drive.google.com/file/d/1nvLDfcjULstrpKbt-8o3nSY23FgCMxl4/view" class="social-link">📄 Privasi</a>
            </div>
            <div class="divider" style="margin: 20px 0;"></div>
            <p>&copy; 2025 Pemerintah Daerah Istimewa Yogyakarta</p>
            <p>Dinas Komunikasi dan Informatika</p>
        </div>
    </div>
</body>
</html>
