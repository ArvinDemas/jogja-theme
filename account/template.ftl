<#macro mainLayout active bodyClass>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Portal Pemda DIY</title>
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    
    <#-- HARDCODE CSS LANGSUNG BIAR GA ERROR -->
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
</head>
<body>
    <div class="dashboard-container">
        <#-- HEADER -->
        <div class="header">
            <div class="brand">
                <div class="logo-box">
                    <#-- Pastikan URL gambar valid atau gunakan placeholder jika ragu -->
                    <img src="https://jogjaprov.go.id/storage/files/shares/page/1518066730_2d84b769e3cc9d6f06f8c91a6c3e285c.jpg" alt="Logo DIY">
                </div>
                <div class="brand-text">
                    <h1>PEMDA DIY</h1>
                    <p>Dashboard SSO</p>
                </div>
            </div>
            <a href="${url.logoutUrl}" class="logout-btn">
                <i class="ph ph-sign-out"></i>
                <span>Logout</span>
            </a>
        </div>

        <#-- CONTENT INJECTION (SIMPLIFIED) -->
        <#nested>
        
    </div>
</body>
</html>
</#macro>