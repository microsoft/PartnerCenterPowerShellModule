# Partner Center PowerShell Module (preview) #

## Get-PCManagedService ##

### Select a customer ###

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

### Get all managed services for specified customer ###

```powershell
    Get-PCManagedService -tenantid $customer.id
```
