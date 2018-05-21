# Partner Center PowerShell Module (preview) #

## Add-PCAuthentication ##

### Set a global token for the script session - user authentication ###

```powershell
    $cred = Get-Credential
    Add-PCAuthentication -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -credential $cred
```

### Set a global token for the script session - app authentication ###

```powershell
    $clientSecret = '<key code secret>'
    $clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force
    Add-PCAuthentication -cspappID '<web app id GUID>' -cspDomain '<csp partner domain>' -cspClientSecret $clientSecretSecure
```

You can obtain the Web App ID and the Client Secret from either Partner Center UI or Azure Active Directory
