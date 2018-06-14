# Get-PCOrder

Returns a list of orders or a specified order.

## SYNTAX

```powershell
Get-PCOrder [[-TenantId] <String>] [[-OrderId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCOrder cmdlet returns a list of orders for the specified tenant.

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
 
### -OrderId &lt;String&gt;

Specifies the order id for which to return information.

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

## EXAMPLES

### EXAMPLE 1

Return all orders for the specified customer tenant.

```powershell
    Get-PCOrder -TenantId 3c762ceb-b839-4b4a-85d8-0e7304c89f62
```

### EXAMPLE 2

Get the specified customer order

```powershell
    Get-PCOrder -TenantId -TenantId '3c762ceb-b839-4b4a-85d8-0e7304c89f62' -OrderId '1168c0f1-f0ed-4f9a-9e8c-1dcac072cba8'
```
