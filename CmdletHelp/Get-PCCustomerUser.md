# Partner Center PowerShell Module (preview) #

## Get-PCCustomerUser ##

### Select a customer ###

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

**Get all customer users**

    Get-PCCustomerUser -tenantid $customer.id -all

**Get customer user**

    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'

**Get customer user assigned licenses**

    Get-PCCustomerUser -tenantid $customer.id -userid $user.id -licenses

**Get customer deleted users**

    Get-PCCustomerUser -tenantid $customer.id -deleted

