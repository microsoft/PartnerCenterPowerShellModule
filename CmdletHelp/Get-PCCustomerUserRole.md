# Get-PCCustomerUserRole #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -tenantId $customer.id -userid '<user id>'
```

## Get customer user roles ##

```powershell
    Get-PCCustomerUserRole -tenantId $customer.id -user $user
```
