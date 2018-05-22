# Get-PCOffer #

## Get all offer details for countryId ##

```powershell
    Get-PCOffer -countryId '<country two digits id>'
```

## Get a specific offer ##

```powershell
    Get-PCOffer -countryId '<country two digits id>' -offerId '<offer id GUID>'
```

## Get all offer details for countryId and localeId ##

```powershell
    Get-PCOffer -countryId '<country two digits id>' -localeId '<locale id four digits>'
```

## Get addons for a specific offer ##

```powershell
    Get-PCOffer -countryId '<country two digits id>' -offerId '<offer id GUID>' -addOns
```
