# Get-PCCustomerBillingProfile #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer billing profile ##

```powershell
    Get-PCCustomerBillingProfile -TenantId $customer.id
```
