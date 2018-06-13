# Get-PCOfferCategoriesByMarket

TODO

## SYNTAX

```powershell
Get-PCOfferCategoriesByMarket [[-CountryId] <Object>] [-SaToken] <String> [<CommonParameters>]
```

## DESCRIPTION

The Get-PCOfferCategoriesByMarket cmdlet

## PARAMETERS

### -CountryId &lt;Object&gt;

Specifies a two-character ISO 2 country code.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token you created with your Partner Center credentials.

```
Required?                    true
Position?                    2
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>Get-PCOfferCategoriesByMarket -CountryId US
```
