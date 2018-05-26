# Remove-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -userid '<user id>'
```

## Delete a customer user ##

```powershell
    Remove-PCCustomerUser -TenantId $customer.id -user $user
```
