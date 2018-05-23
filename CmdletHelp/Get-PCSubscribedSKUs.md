# Get-PCSubscribedSKUs #

## Deprecated: Use Get-PCSubscribedSKU instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get a list of available licenses ##

```powershell
    Get-PCSubscribedSKUs -tenantid $customer.id
```
