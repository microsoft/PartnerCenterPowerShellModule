# Get-PCCustomerRole #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer roles ##

```powershell
    Get-PCCustomerRole -tenantid $customer.id
```
