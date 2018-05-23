# Get-PCCustomerUserRole #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'
```

## Get customer user roles ##

```powershell
    Get-PCCustomerUserRole -tenantid $customer.id -user $user
```
