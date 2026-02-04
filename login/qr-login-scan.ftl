<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        Verifying QR Code
    <#elseif section = "header">
        QR Code Verification
    <#elseif section = "form">

        <div style="text-align: center; padding: 30px;">
            <div style="margin-bottom: 25px;">
                <svg width="80" height="80" viewBox="0 0 80 80" fill="none">
                    <circle cx="40" cy="40" r="38" stroke="#10b981" stroke-width="4" stroke-linecap="round" stroke-dasharray="60 180" transform="rotate(-90 40 40)">
                        <animateTransform attributeName="transform" type="rotate" from="0 40 40" to="360 40 40" dur="1s" repeatCount="indefinite"/>
                    </circle>
                </svg>
            </div>
            
            <h2 style="font-size: 1.5rem; font-weight: 700; color: #0f172a; margin-bottom: 15px;">
                Verifying Authentication...
            </h2>
            
            <p style="font-size: 1rem; color: #64748b; margin-bottom: 20px;">
                QR Code scanned successfully!<br/>
                Logging you in automatically...
            </p>
            
            <div style="background: #f0f9ff; border-left: 4px solid #0ea5e9; padding: 15px; border-radius: 10px; margin: 20px auto; max-width: 400px; text-align: left;">
                <p style="font-size: 0.85rem; color: #0c4a6e; line-height: 1.6; margin: 0;">
                    <strong>ℹ️ Please wait:</strong> Your desktop will automatically log in. 
                    You can close this mobile page after login completes.
                </p>
            </div>
        </div>

        <form id="com-hadleyso-qrcode-${QRauthExecId}" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post" style="display: none;">
            <input type="hidden" name="authenticationExecution" value="${QRauthExecId}">
            <span style="display: none;">${QRauthToken}</span>
        </form>

        <script type="text/javascript">
            // AUTO SUBMIT - No need to click QR code
            (function() {
                console.log('QR Code scanned - Auto submitting form...');
                
                // Submit immediately after page load
                setTimeout(function() {
                    var form = document.getElementById("com-hadleyso-qrcode-${QRauthExecId}");
                    if (form) {
                        console.log('Submitting authentication form...');
                        form.submit();
                    } else {
                        console.error('Form not found!');
                    }
                }, 1000); // 1 second delay for better UX
            })();
        </script>
    </#if>
</@layout.registrationLayout>
