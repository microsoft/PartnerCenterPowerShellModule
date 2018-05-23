# Get-PCCustomerBillingProfile #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer billing profile ##

```powershell
    Get-PCCustomerBillingProfile -tenantid $customer.id
```
