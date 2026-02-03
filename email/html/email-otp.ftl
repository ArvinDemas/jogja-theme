<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kode OTP</title>
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
        .otp-container { text-align: center; margin: 35px 0; }
        .otp-box { display: inline-block; background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%); color: white; padding: 25px 45px; border-radius: 16px; box-shadow: 0 15px 40px rgba(14, 165, 233, 0.3); }
        .otp-label { font-size: 12px; text-transform: uppercase; letter-spacing: 2px; opacity: 0.9; margin-bottom: 10px; }
        .otp-code { font-size: 42px; font-weight: 700; letter-spacing: 8px; font-family: 'Courier New', monospace; }
        .info-box { background: #fef2f2; border-left: 4px solid #ef4444; padding: 15px; border-radius: 8px; margin: 25px 0; }
        .info-box p { font-size: 14px; color: #991b1b; line-height: 1.6; margin: 0; }
        .warning-box { background: #fffbeb; border-left: 4px solid #f59e0b; padding: 15px; border-radius: 8px; margin: 25px 0; }
        .warning-box p { font-size: 14px; color: #92400e; line-height: 1.6; margin: 0; }
        .footer { background: #f8fafc; padding: 30px; text-align: center; border-top: 1px solid #e2e8f0; }
        .footer p { font-size: 13px; color: #64748b; margin: 5px 0; }
        .social-links { margin: 20px 0; }
        .social-link { display: inline-block; margin: 0 8px; color: #64748b; text-decoration: none; font-size: 13px; }
        .divider { height: 1px; background: #e2e8f0; margin: 25px 0; }
        .security-tips { background: #f0f9ff; border-radius: 10px; padding: 20px; margin: 25px 0; }
        .security-tips h3 { font-size: 16px; color: #0f172a; margin-bottom: 12px; }
        .security-tips ul { margin-left: 20px; color: #475569; line-height: 1.8; font-size: 14px; }
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
                <p>Berikut adalah kode OTP (One-Time Password) Anda untuk masuk ke <strong>Portal SSO Pemda DIY</strong>:</p>
            </div>
            
            <div class="otp-container">
                <div class="otp-box">
                    <div class="otp-label">Kode OTP Anda</div>
                    <div class="otp-code">${otpCode!"123456"}</div>
                </div>
            </div>
            
            <div class="info-box">
                <p><strong>⏰ Penting:</strong> Kode ini akan kedaluwarsa dalam <strong>${linkExpiration!"5"} menit</strong>. Segera masukkan kode ini untuk melanjutkan.</p>
            </div>
            
            <div class="warning-box">
                <p><strong>⚠️ Perhatian Keamanan:</strong> Jangan bagikan kode OTP ini kepada siapapun, termasuk petugas Diskominfo. Kami tidak akan pernah meminta kode OTP Anda melalui telepon, email, atau pesan.</p>
            </div>
            
            <div class="divider"></div>
            
            <div class="security-tips">
                <h3>🔒 Tips Keamanan Akun</h3>
                <ul>
                    <li>Selalu gunakan 2FA pada perangkat pribadi</li>
                    <li>Jangan simpan kode OTP di perangkat yang dapat diakses orang lain</li>
                    <li>Segera hubungi kami jika menerima kode OTP yang tidak Anda minta</li>
                    <li>Pastikan Anda login dari website resmi: <strong>sso.jogjaprov.go.id</strong></li>
                </ul>
            </div>
            
            <div class="message">
                <p>Jika Anda tidak meminta kode OTP ini, harap abaikan email ini dan segera laporkan ke tim keamanan kami.</p>
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
