# Get-PCCustomerRelationship

Returns the type of relationship the specified tenant has with the current partner.

## SYNTAX

```powershell
Get-PCCustomerRelationship [[-TenantId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerRelationship cmdlet returns the relationship the specified customer has with the current partner.

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

This cmdlet can only be used in an indirect model.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>Get-PCCustomerRelationship -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c
```

### EXAMPLE 2

Specify a customer tenant.

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

Return the customer relationship.

```powershell
    Get-PCCustomerRelationship -TenantId $customer.id
```
