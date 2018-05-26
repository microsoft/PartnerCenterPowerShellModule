# Get-PCCustomerUserRole #

## Select a customer ##

```powershell
    Select-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -userid '<user id>'
```

## Get customer user roles ##

```powershell
    Get-PCCustomerUserRole -TenantId $customer.id -user $user
```
