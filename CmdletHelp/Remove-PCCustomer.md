# Remove-PCCustomer #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Delete a customer (integration sandbox only) ##

```powershell
    Remove-PCCustomer -TenantId $customer.id
```
