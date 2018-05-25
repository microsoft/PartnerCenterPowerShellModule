# Restore-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer deleted users ##

```powershell
    $user = Get-PCCustomerUser -tenantId $customer.id -deleted | ? id -EQ '<user id>'
```

## Restore a customer deleted user ##

```powershell
    Restore-PCCustomerUser -tenantId $customer.id -user $user
```
