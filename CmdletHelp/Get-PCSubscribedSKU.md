# Get-PCSubscribedSKU #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get a list of available licenses ##

```powershell
    Get-PCSubscribedSKU -TenantId $customer.id
```
