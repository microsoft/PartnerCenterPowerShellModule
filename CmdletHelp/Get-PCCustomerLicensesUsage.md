# Partner Center PowerShell Module (preview) #

## Get-PCCustomerLicensesUsage ##

Deprecated: Please use Get-PCCustomerLicenseUsage instead

### Get a customer ###

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

### Get customer licenses usage information ###

```powershell
    Get-PCCustomerLicensesUsage -tenantid $customer.id
```
