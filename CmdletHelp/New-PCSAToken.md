# New-PCSAToken #

## Set a specific token for a command/function - user authentication ##

```powershell
    $cred = Get-Credential

    New-PCSAToken -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -credential $cred
```

## Set a specific token for a command/function - app authentication ##

```powershell
    $clientSecret = '<key code secret>'
    $clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force

    New-PCSAToken -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -cspClientSecret $clientSecretSecure
```
