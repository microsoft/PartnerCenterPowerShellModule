# Get-PCAzureRateCard #

## Get Azure rate card (meters) for default context ##

```powershell
    Get-PCAzureRateCard
```

- **currency** Optional three letter ISO code for the currency in which the resource rates will be provided (e.g. "EUR"). The default is the currency associated with the market in the partner profile.
- **region** Optional two-letter ISO country/region code that indicates the market where the offer is purchased (e.g. "FR"). The default is the country/region code set in the partner profile.

## Get Azure rate card for specific currency and region ##

```powershell
    Get-PCAzureRateCard -currency '<three digits currency>' -region '<two digits region code>'
```
