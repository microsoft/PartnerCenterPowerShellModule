# Get-PCCustomerLicensesUsage #

## Deprecated: Please  use Get-PCCustomerLicenseUsage instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer licenses usage information ##

```powershell
    Get-PCCustomerLicensesUsage -tenantId $customer.id
```
