# Restore-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer deleted users ##

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -deleted | ? id -EQ '<user id>'
```

## Restore a customer deleted user ##

```powershell
    Restore-PCCustomerUser -TenantId $customer.id -user $user
```
