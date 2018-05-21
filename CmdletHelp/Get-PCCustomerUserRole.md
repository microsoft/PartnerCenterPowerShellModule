# Partner Center PowerShell Module (preview) #

## Get-PCCustomerUserRole ##

### Select a customer ###

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

**Get customer user**

    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'

**Get customer user roles**

    Get-PCCustomerUserRole -tenantid $customer.id -user $user

