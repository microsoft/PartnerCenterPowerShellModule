# Partner Center PowerShell Module (preview) #

## Restore-PCCustomerUser ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer deleted users**

    $user = Get-PCCustomerUser -tenantid $customer.id -deleted | ? id -EQ '<user id>'

**Restore a customer deleted user**

    Restore-PCCustomerUser -tenantid $customer.id -user $user

