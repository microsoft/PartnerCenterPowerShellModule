# Get-PCCustomerLicensesDeployment #

## Deprecated: Use Get-PCCustomerLicenseDeployment instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer licenses deployment information ##

```powershell
    Get-PCCustomerLicensesDeployment -tenantid $customer.id
```
