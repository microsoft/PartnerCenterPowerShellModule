# Get-PCCustomerCompanyProfile #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer company profile ##

```powershell
    Get-PCCustomerCompanyProfile -TenantId $customer.id
```
