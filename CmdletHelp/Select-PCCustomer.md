# Select-PCCustomer

Selects a customer to be used in other cmdlets.

## SYNTAX

```powershell
Select-PCCustomer -TenantId <String> [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Select-PCCustomer cmdlet selects a customer tenant specified by the tenant id.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    named
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
PS C:\>Select-PCCustomer -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c
```
