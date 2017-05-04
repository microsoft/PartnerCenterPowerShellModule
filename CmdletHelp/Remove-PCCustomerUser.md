# Partner Center PowerShell Module (preview) #

## Remove-PCCustomerUser ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer user**

    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'

**Delete a customer user**

    Remove-PCCustomerUser -tenantid $customer.id -user $user

