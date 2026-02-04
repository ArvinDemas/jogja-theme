<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        Login Successful
    <#elseif section = "header">
        Login Successful
    <#elseif section = "form">

        <div style="text-align: center; padding: 30px;">
            <div style="width: 100px; height: 100px; margin: 0 auto 25px; background: linear-gradient(135deg, #10b981, #059669); border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <svg width="60" height="60" viewBox="0 0 24 24" fill="none">
                    <path d="M5 13l4 4L19 7" stroke="white" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            
            <h2 style="font-size: 1.8rem; font-weight: 700; color: #0f172a; margin-bottom: 15px;">
                Desktop Login Approved!
            </h2>
            
            <p style="font-size: 1rem; color: #64748b; line-height: 1.6; margin-bottom: 25px;">
                Your desktop is now logged in.<br/>
                You can close this mobile page.
            </p>
            
            <div style="background: #f0fdf4; border-left: 4px solid #10b981; padding: 20px; border-radius: 10px; margin: 20px 0; text-align: left;">
                <h4 style="font-size: 0.95rem; font-weight: 700; color: #065f46; margin-bottom: 10px;">
                    ✅ What Happened:
                </h4>
                <ul style="margin: 0; padding-left: 20px; color: #065f46; font-size: 0.85rem; line-height: 1.8;">
                    <li>Your desktop has been automatically logged in</li>
                    <li>You can now use your desktop to access the system</li>
                    <li>This mobile page is no longer needed</li>
                    <li>Feel free to close this tab/window</li>
                </ul>
            </div>

            <button type="button" onclick="window.close()" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" style="margin-top: 20px;">
                Close This Page
            </button>
            
            <p style="font-size: 0.75rem; color: #94a3b8; margin-top: 15px; line-height: 1.5;">
                If the button doesn't work, you can manually close this tab.
            </p>
        </div>

        <script type="text/javascript">
            // Auto close after 10 seconds
            setTimeout(function() {
                if (confirm('Desktop login successful! Close this mobile page?')) {
                    window.close();
                }
            }, 10000);
        </script>
        
    </#if>
</@layout.registrationLayout>
