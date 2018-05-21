# Partner Center PowerShell Module (preview) #

## Get-PCOffer ##

### Get all Offers details for countryid ###

```powershell
    Get-PCOffer -countryid '<country two digits id>'
```

### Get a specific offer ###

```powershell
    Get-PCOffer -countryid '<country two digits id>' -offerid '<offer id GUID>'
```

### Get all offer details for countryid and localeid ###

```powershell
    Get-PCOffer -countryid '<country two digits id>' -localeid '<locale id four digits>'
```

### Get addons for a specific offer ###

```powershell
    Get-PCOffer -countryid '<country two digits id>' -offerid '<offer id GUID>' -addons
```
