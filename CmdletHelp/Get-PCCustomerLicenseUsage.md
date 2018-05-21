# Partner Center PowerShell Module (preview) #

## Get-PCCustomerLicenseUsage ##

### Get a customer ###

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

### Get customer license usage information ###

```powershell
    Get-PCCustomerLicenseUsage -tenantid $customer.id
```
