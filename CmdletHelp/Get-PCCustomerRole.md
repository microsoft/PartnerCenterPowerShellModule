# Get-PCCustomerRole #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer roles ##

```powershell
    Get-PCCustomerRole -TenantId $customer.id
```
