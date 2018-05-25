# Get-PCSubscribedSKUs #

## Deprecated: Use Get-PCSubscribedSKU instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get a list of available licenses ##

```powershell
    Get-PCSubscribedSKUs -tenantId $customer.id
```
