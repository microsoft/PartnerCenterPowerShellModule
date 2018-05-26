# Get-PCCustomerUser #

## Get all customer users ##

```powershell
    Get-PCCustomerUser -TenantId $customer.id -all
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -userid '<user id>'
```

## Get customer user assigned licenses ##

```powershell
    Get-PCCustomerUser -TenantId $customer.id -userid $user.id -licenses
```

## Get customer deleted users ##

```powershell
    Get-PCCustomerUser -TenantId $customer.id -deleted
```
