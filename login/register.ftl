<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Daftar Akun - Portal Pemda DIY</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
    <div class="container">
        <div class="visual-section">
            <div class="brand-wrapper">
                <div class="logo-box">
                    <img src="https://jogjaprov.go.id/storage/files/shares/page/1518066730_2d84b769e3cc9d6f06f8c91a6c3e285c.jpg">
                </div>
                <div class="brand-text"><h1>PEMDA DIY</h1><p>YOGYAKARTA</p></div>
            </div>
            <div class="carousel-container">
                <div class="carousel-slide active">
                    <h2 class="slide-title">Yogyakarta Istimewa</h2>
                    <p class="slide-desc">Lengkapi data diri untuk bergabung dalam ekosistem digital.</p>
                </div>
            </div>
        </div>

        <div class="form-section">
            <div class="login-card">
                <div class="form-header">
                    <h2>Buat Akun Baru</h2>
                </div>

                <form action="${url.registrationAction}" method="post">
                    <#if message?has_content>
                        <div style="color: #ef4444; margin-bottom: 10px;">${message.summary}</div>
                    </#if>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Nama Depan</label>
                            <input type="text" name="firstName" class="form-input" value="${(register.formData.firstName!'')}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Nama Belakang</label>
                            <input type="text" name="lastName" class="form-input" value="${(register.formData.lastName!'')}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input" value="${(register.formData.email!'')}">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-input" value="${(register.formData.username!'')}">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-input">
                    </div>

                    <div class="form-group">
                        <label class="form-label">Konfirmasi Password</label>
                        <input type="password" name="password-confirm" class="form-input">
                    </div>

                    <button type="submit" class="main-btn">Daftar Sekarang</button>
                </form>
                <div class="bottom-text">Sudah punya akun? <a href="${url.loginUrl}">Masuk Disini</a></div>
            </div>
        </div>
    </div>
    <script src="${url.resourcesPath}/js/script.js"></script>
</body>
</html>