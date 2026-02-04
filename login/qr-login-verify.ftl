<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        Approve Desktop Login
    <#elseif section = "header">
        Approve Desktop Login
    <#elseif section = "form">

        <div style="padding: 20px;">
            <div style="text-align: center; margin-bottom: 25px;">
                <svg width="80" height="80" viewBox="0 0 24 24" fill="none">
                    <rect x="2" y="3" width="20" height="14" rx="2" stroke="#0ea5e9" stroke-width="2"/>
                    <path d="M8 21h8" stroke="#0ea5e9" stroke-width="2" stroke-linecap="round"/>
                    <path d="M12 17v4" stroke="#0ea5e9" stroke-width="2" stroke-linecap="round"/>
                </svg>
            </div>

            <h2 style="font-size: 1.4rem; font-weight: 700; color: #0f172a; margin-bottom: 15px; text-align: center;">
                Approve Desktop Login?
            </h2>

            <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 20px; margin: 20px 0;">
                <p style="font-size: 0.85rem; color: #64748b; margin-bottom: 15px;"><strong>Device Information:</strong></p>
                
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span style="font-size: 0.85rem; color: #64748b;">Device:</span>
                    <span style="font-size: 0.85rem; font-weight: 600; color: #0f172a;">${ua_device!"Unknown"}</span>
                </div>
                
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span style="font-size: 0.85rem; color: #64748b;">OS:</span>
                    <span style="font-size: 0.85rem; font-weight: 600; color: #0f172a;">${ua_os!"Unknown"}</span>
                </div>
                
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                    <span style="font-size: 0.85rem; color: #64748b;">Browser:</span>
                    <span style="font-size: 0.85rem; font-weight: 600; color: #0f172a;">${ua_agent!"Unknown"}</span>
                </div>
                
                <div style="display: flex; justify-content: space-between;">
                    <span style="font-size: 0.85rem; color: #64748b;">Session:</span>
                    <span style="font-size: 0.75rem; font-weight: 600; color: #0f172a; font-family: monospace;">${tabId!"N/A"}</span>
                </div>
            </div>

            <div style="background: #fffbeb; border-left: 4px solid #f59e0b; padding: 15px; border-radius: 10px; margin: 20px 0;">
                <p style="font-size: 0.85rem; color: #92400e; line-height: 1.6; margin: 0;">
                    <strong>⚠️ Security Warning:</strong><br/>
                    Only approve if YOU initiated this login on your desktop. If you don't recognize this activity, click <strong>Decline</strong>.
                </p>
            </div>

            <div style="display: flex; gap: 12px; margin-top: 25px;">
                <a href="${rejectURL}" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" style="flex: 1; text-align: center;">
                    Decline
                </a>
                
                <a href="${approveURL}" id="approveBtn" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" style="flex: 2; text-align: center;">
                    Approve & Login
                </a>
            </div>

            <p style="font-size: 0.75rem; color: #94a3b8; margin-top: 20px; text-align: center; line-height: 1.5;">
                After approval, your desktop will automatically log in.<br/>
                You can close this mobile page after that.
            </p>
        </div>

        <#-- AUTO APPROVE: Uncomment this if you want automatic approval -->
        <#--
        <script type="text/javascript">
            // AUTO APPROVE after 3 seconds
            setTimeout(function() {
                console.log('Auto-approving login...');
                window.location.href = '${approveURL}';
            }, 3000);
        </script>
        -->
        
    </#if>
</@layout.registrationLayout>
