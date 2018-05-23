# Remove-PCCustomer #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Delete a customer (integration sandbox only) ##

```powershell
    Remove-PCCustomer -tenantid $customer.id
```
