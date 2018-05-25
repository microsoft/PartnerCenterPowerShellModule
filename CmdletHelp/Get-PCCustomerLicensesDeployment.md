# Get-PCCustomerLicensesDeployment #

## Deprecated: Use Get-PCCustomerLicenseDeployment instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer licenses deployment information ##

```powershell
    Get-PCCustomerLicensesDeployment -tenantId $customer.id
```
