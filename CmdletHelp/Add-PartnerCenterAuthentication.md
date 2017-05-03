# Partner Center PowerShell Module (preview) #

## Add-PartnerCenterAuthentication ##

**Set a global token for the script session - user authentication**

    $credential = Get-Credential

    Add-PartnerCenterAuthentication -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -credential $credential

**Set a global token for the script session - app authentication**

    $clientSecret = '<key code secret>'
	$clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force

	Add-PartnerCenterAuthentication -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -cspClientSecret $clientSecretSecure
