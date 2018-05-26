# Get-PCManagedServices #

## Deprecated: Use Get-PCManagedService instead ##

## Select a customer ##

```powershell
    Select-PCCustomer -TenantId '<tenant id GUID>'
```

## Get all managed services for customer ##

```powershell
    Get-PCManagedServices -TenantId $customer.id
```
