# Remove-PCCustomer #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Delete a customer (integration sandbox only) ##

```powershell
    Remove-PCCustomer -tenantId $customer.id
```
