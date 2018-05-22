# Remove-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'
```

## Delete a customer user ##

```powershell
    Remove-PCCustomerUser -tenantid $customer.id -user $user
```
