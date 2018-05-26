# Get-PCManagedService #

## Select a customer ##

```powershell
    Select-PCCustomer -TenantId '<tenant id GUID>'
```

## Get all managed services for specified customer ##

```powershell
    Get-PCManagedService -TenantId $customer.id
```
