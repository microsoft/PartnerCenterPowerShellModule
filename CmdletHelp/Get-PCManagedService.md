# Get-PCManagedService #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantId '<tenant id GUID>'
```

## Get all managed services for specified customer ##

```powershell
    Get-PCManagedService -tenantId $customer.id
```
