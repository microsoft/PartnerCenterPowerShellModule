# Get-PCIndirectReseller (indirect model only)

Returns a list of indirect resellers. This only works for a partner that is an indirect provider.

## SYNTAX

```powershell
Get-PCIndirectReseller [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCIndirectReseller cmdlet returns a list of indirect resellers.

## PARAMETERS

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    1
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

This cmdlet is only intended to work for the indirect model.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>Get-PCIndirectReseller
```
