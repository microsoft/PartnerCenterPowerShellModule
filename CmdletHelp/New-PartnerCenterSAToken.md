# Partner Center PowerShell Module (preview) #

## New-PartnerCenterSAToken ##

**Set a specific token for a command/function - user authentication**

    $credential = Get-Credential

    New-PartnerCenterSAToken -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -credential $credential

**Set a specific token for a command/function - app authentication**

    New-PartnerCenterSAToken -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -cspClientSecret '<key code secret>'

**Set a specific token for a command/function - file authentication**

    New-PartnerCenterSAToken -AuthenticationFileUrl '<file.json>'

**File authentication format example - user**

```
{
    "authType": "User",
    "cspDomain": "mydomain.onmicrosoft.com",
    "cspClientID": "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "cspClientSecret": "",
    "cspUsername": "admin@mydomain.onmicrosoft.com",
    "cspPassword": "*********"
}
```

**File authentication format example - app**

```
{
    "authType": "app",
    "cspDomain": "mydomain.onmicrosoft.com",
    "cspClientID": "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "cspClientSecret": "******-****-****-****-************",
    "cspUsername": "",
    "cspPassword": ""
}
```