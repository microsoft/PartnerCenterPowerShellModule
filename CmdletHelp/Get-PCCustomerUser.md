# Get-PCCustomerUser #

## Get all customer users ##

```powershell
    Get-PCCustomerUser -tenantid $customer.id -all
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'
```

## Get customer user assigned licenses ##

```powershell
    Get-PCCustomerUser -tenantid $customer.id -userid $user.id -licenses
```

## Get customer deleted users ##

```powershell
    Get-PCCustomerUser -tenantid $customer.id -deleted
```
