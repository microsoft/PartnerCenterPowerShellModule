# Get-PCCustomerBillingProfile #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer billing profile ##

```powershell
    Get-PCCustomerBillingProfile -tenantId $customer.id
```
