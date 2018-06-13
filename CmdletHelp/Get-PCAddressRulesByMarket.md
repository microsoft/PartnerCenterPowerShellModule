# Get-PCAddressRulesByMarket

Retrieves a list of address rules for a specified market.

## SYNTAX

```powershell
Get-PCAddressRulesByMarket [-CountryId] <String> [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCAddressRulesByMarket returns a list of rules for the specified market.

## PARAMETERS

### -CountryId &lt;String&gt;

Specifies a two-character ISO 2 country code.

```
Required?                    true
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token you have created with your Partner Center credentials.

```
Required?                    false
Position?                    2
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

You need to have authenticated before running this cmdlet.

## EXAMPLES

### EXAMPLE 1

Return the address rules for the US.

```powershell
PS C:\>Get-PCAddressRulesByMarket -CountryId US
```
