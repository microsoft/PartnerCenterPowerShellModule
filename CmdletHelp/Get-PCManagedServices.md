# Partner Center PowerShell Module (preview) #

## Get-PCManagedServices ##

Deprecated: Please use Get-PCManagedService instead

### Select a customer ###

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

### Get all managed services for customer ###

```powershell
    Get-PCManagedServices -tenantid $customer.id
```
