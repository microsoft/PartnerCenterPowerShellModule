# New-PCSAToken #

## Set a specific token for a command/function - user authentication ##

```powershell
    $cred = Get-Credential

    New-PCSAToken -CspAppId '<native app id GUID>' -CspDomain '<csp partner domain>' -Credential $cred
```

## Set a specific token for a command/function - app authentication ##

```powershell
    $clientSecret = '<key code secret>'
    $clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force

    New-PCSAToken -CspAppId '<native app id GUID>' -CspDomain '<csp partner domain>' -CspClientSecret $clientSecretSecure
```
