# Get-PCCustomerLicenseUsage #

This cmdlet requires App+User authentication

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer license usage information ##

```powershell
    Get-PCCustomerLicenseUsage -tenantId $customer.id
```
