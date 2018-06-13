# Get-PCMpnProfile

TODO

## SYNTAX

```powershell
Get-PCMpnProfile [[-MpnId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCMpnProfile cmdlet

## PARAMETERS

### -MpnId &lt;String&gt;

Specifies the MPN id used to scope this cmdlet.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

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

## EXAMPLES

### EXAMPLE 1

Return the Mpn profile for the current partner.

```powershell
PS C:\>Get-PCMpnProfile
```
