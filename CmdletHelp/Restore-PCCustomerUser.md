# Restore-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer deleted users ##

```powershell
    $user = Get-PCCustomerUser -tenantid $customer.id -deleted | ? id -EQ '<user id>'
```

## Restore a customer deleted user ##

```powershell
    Restore-PCCustomerUser -tenantid $customer.id -user $user
```
