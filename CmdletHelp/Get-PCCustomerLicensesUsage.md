# Get-PCCustomerLicensesUsage #

## Deprecated: Please  use Get-PCCustomerLicenseUsage instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer licenses usage information ##

```powershell
    Get-PCCustomerLicensesUsage -tenantid $customer.id
```
