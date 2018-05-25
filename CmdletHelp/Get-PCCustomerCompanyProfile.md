# Get-PCCustomerCompanyProfile #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer company profile ##

```powershell
    Get-PCCustomerCompanyProfile -tenantId $customer.id
```
