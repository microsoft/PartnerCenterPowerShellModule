# Get-PCSubscribedSKU #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get a list of available licenses ##

```powershell
    Get-PCSubscribedSKU -tenantId $customer.id
```
