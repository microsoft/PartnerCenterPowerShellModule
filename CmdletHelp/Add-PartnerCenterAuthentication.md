# Partner Center PowerShell Module #

## Add-PartnerCenterAuthentication ##

**Set a global token for the script session - user authentication**

    $credential = Get-Credential

    Add-PartnerCenterAuthentication -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -credential $credential

**Set a global token for the script session - app authentication**

    Add-PartnerCenterAuthentication -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -cspClientSecret '<key code secret>'

**Set a global token for the script session - file authentication**

    Add-PartnerCenterAuthentication -AuthenticationFileUrl '<file.json>'

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