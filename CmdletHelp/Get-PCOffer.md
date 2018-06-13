# Get-PCOffer

TODO

## SYNTAX

```powershell
Get-PCOffer [-CountryId] <String> [[-OfferId] <String>] [[-LocaleId] <String>] [-AddOns] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCOffer cmdlet retrives a list of offers based on the specified country id

## PARAMETERS

### -CountryId &lt;String&gt;

Specifies a two letter country id

```
Required?                    true
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -OfferId &lt;String&gt;

Specifies the offer id to return.

```
Required?                    false
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -LocaleId &lt;String&gt;

Specifies a locale as the language and country code. For example, English in the United States is en-us

```
Required?                    false
Position?                    3
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -AddOns &lt;SwitchParameter&gt;

Specifies add on skus

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -SaToken &lt;String&gt;

Specifies an authentication token you have created with your Partner Center credentials.

```
Required?                    false
Position?                    4
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

TODO

## EXAMPLES

### EXAMPLE 1

Get all offer details for the US Country Id

```powershell
PS C:\>Get-PCOffer
```

### EXAMPLE 2

Get a specific offer using the offer id and country.

```powershell
    Get-PCOffer -CountryId 'US'
```

### EXAMPLE 3

Get all offer details using the Country Id and Locale Id.

```powershell
    Get-PCOffer -CountryId 'US' -localeId 'en-us'
```

### EXAMPLES 4

Get add ons for the specified offer id.

```powershell
    Get-PCOffer -CountryId 'US' -OfferId '8AA7E78B-B265-4AC6-ADA0-14900A8A3F94' -addOns
```
