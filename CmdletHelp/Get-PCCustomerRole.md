# Get-PCCustomerRole #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer roles ##

```powershell
    Get-PCCustomerRole -tenantId $customer.id
```
