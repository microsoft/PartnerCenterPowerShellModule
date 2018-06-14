# Get-PCCustomerLicensesDeployment #

## Deprecated: Use Get-PCCustomerLicenseDeployment instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer licenses deployment information ##

```powershell
    Get-PCCustomerLicensesDeployment -TenantId $customer.id
```
