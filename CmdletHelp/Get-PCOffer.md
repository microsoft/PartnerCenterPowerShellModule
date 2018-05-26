# Get-PCOffer #

## Get all offer details for CountryId ##

```powershell
    Get-PCOffer -CountryId '<Country two digits id>'
```

## Get a specific offer ##

```powershell
    Get-PCOffer -CountryId '<Country two digits id>' -OfferId '<offer id GUID>'
```

## Get all offer details for CountryId and localeId ##

```powershell
    Get-PCOffer -CountryId '<Country two digits id>' -localeId '<locale id four digits>'
```

## Get addons for a specific offer ##

```powershell
    Get-PCOffer -CountryId '<Country two digits id>' -OfferId '<offer id GUID>' -addOns
```
