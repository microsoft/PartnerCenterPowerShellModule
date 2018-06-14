# Get-PCAzureRateCard

Retrieves the Azure services rate card for the specified region.

## SYNTAX

```powershell
Get-PCAzureRateCard [[-Currency] <String>] [[-Region] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCAzureRateCard returns a list of Azure rates for the specified region.

## PARAMETERS

### -Currency &lt;String&gt;

Specifies a three-character ISO currency code.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Region &lt;String&gt;

Specifies a two-character ISO 2 country code.

```
Required?                    false
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    3
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

You need to have a authentication Credential already established before running this cmdlet. The region and the currency must match to return a result.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>Get-PCAzureRateCard -region US -currency USD

Returns the Azure rate card for the specified region and currency.
```
