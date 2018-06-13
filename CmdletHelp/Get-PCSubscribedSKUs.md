# Get-PCSubscribedSKUs #

## Deprecated: Use Get-PCSubscribedSKU instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get a list of available licenses ##

```powershell
    Get-PCSubscribedSKUs -TenantId $customer.id
```
