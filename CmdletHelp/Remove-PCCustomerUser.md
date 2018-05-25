# Remove-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -tenantId $customer.id -userid '<user id>'
```

## Delete a customer user ##

```powershell
    Remove-PCCustomerUser -tenantId $customer.id -user $user
```
