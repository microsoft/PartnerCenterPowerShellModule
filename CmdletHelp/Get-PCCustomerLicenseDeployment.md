# Get-PCCustomerLicenseDeployment #

This cmdlet requires App+User authentication

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer licenses deployment information ##

```powershell
    Get-PCCustomerLicenseDeployment -tenantId $customer.id
```
