# Partner Center PowerShell Module #

## Remove-PartnerCenterCustomerUser ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer user**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -userid '<user id>'

**Delete a customer user**

    Remove-PartnerCenterCustomerUser -tenantid $customer.id -user $user
