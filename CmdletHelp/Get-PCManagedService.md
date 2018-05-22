# Get-PCManagedService #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

## Get all managed services for specified customer ##

```powershell
    Get-PCManagedService -tenantid $customer.id
```
