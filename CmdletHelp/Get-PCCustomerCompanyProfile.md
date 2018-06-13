# Get-PCCustomerCompanyProfile

Returns the specified customer company profile.

## SYNTAX

```powershell
Get-PCCustomerCompanyProfile [[-TenantId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerCompanyProfile cmdlet retrieves the specified customer company profile.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies a tenant id to scope this cmdlet.
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

Specify a customer

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

Get customer company profile

```powershell
    Get-PCCustomerCompanyProfile -TenantId $customer.id
```
