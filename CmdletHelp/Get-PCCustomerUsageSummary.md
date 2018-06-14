# Get-PCCustomerUsageSummary

Returns aa summary of usage for the specified tenant.

## SYNTAX

```powershell
Get-PCCustomerUsageSummary [[-TenantId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerUsageSummary cmdlet returns a summary of usage for the specified tenant.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token created with your Partner Center credentials.

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

Get the usage summary for all subscritions for the specified tenant id.

```powershell
PS C:\>Get-PCCustomerUsageSummary -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f
```
