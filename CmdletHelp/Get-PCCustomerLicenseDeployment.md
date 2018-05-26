# Get-PCCustomerLicenseDeployment #

This cmdlet requires App+User authentication

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer licenses deployment information ##

```powershell
    Get-PCCustomerLicenseDeployment -TenantId $customer.id
```
