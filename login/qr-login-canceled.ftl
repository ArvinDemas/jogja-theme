<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        Login Cancelled
    <#elseif section = "header">
        Login Cancelled
    <#elseif section = "form">

        <div style="text-align: center; padding: 30px;">
            <div style="width: 100px; height: 100px; margin: 0 auto 25px; background: linear-gradient(135deg, #ef4444, #dc2626); border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <svg width="60" height="60" viewBox="0 0 24 24" fill="none">
                    <path d="M6 6l12 12M6 18L18 6" stroke="white" stroke-width="3" stroke-linecap="round"/>
                </svg>
            </div>
            
            <h2 style="font-size: 1.8rem; font-weight: 700; color: #0f172a; margin-bottom: 15px;">
                Login Cancelled
            </h2>
            
            <p style="font-size: 1rem; color: #64748b; line-height: 1.6; margin-bottom: 25px;">
                You have declined the desktop login request.<br/>
                The desktop will not be logged in.
            </p>
            
            <div style="background: #fef2f2; border-left: 4px solid #ef4444; padding: 20px; border-radius: 10px; margin: 20px 0; text-align: left;">
                <h4 style="font-size: 0.95rem; font-weight: 700; color: #991b1b; margin-bottom: 10px;">
                    ❌ What Happened:
                </h4>
                <ul style="margin: 0; padding-left: 20px; color: #991b1b; font-size: 0.85rem; line-height: 1.8;">
                    <li>Login request was declined by you</li>
                    <li>Desktop will not be logged in</li>
                    <li>No access has been granted</li>
                    <li>Your account remains secure</li>
                </ul>
            </div>

            <div style="background: #fffbeb; border-left: 4px solid #f59e0b; padding: 15px; border-radius: 10px; margin: 20px 0; text-align: left;">
                <p style="font-size: 0.85rem; color: #92400e; line-height: 1.6; margin: 0;">
                    <strong>🔒 Security Notice:</strong> If you didn't recognize this login attempt, 
                    consider changing your password and enabling 2FA for additional security.
                </p>
            </div>

            <button type="button" onclick="window.close()" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" style="margin-top: 20px;">
                Close This Page
            </button>
        </div>
        
    </#if>
</@layout.registrationLayout>
