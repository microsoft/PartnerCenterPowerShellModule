# Get-PCSubscribedSKU

TODO

## SYNTAX

```powershell
Get-PCSubscribedSKU [[-TenantId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-SusbscribedSKU cmdlet.

## PARAMETERS

### -TenantId &lt;String&gt;

The tenant Id assigned to the customer you want to retrieve.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
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

Return the subscribed SKUs for the specified Tenant Id

```powershell
PS C:\>Get-SubscribedSKU -TenantId '97037612-799c-4fa6-8c40-68be72c6b83c'
```
