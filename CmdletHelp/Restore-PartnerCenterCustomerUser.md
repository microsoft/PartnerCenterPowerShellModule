# Partner Center PowerShell Module #

## Restore-PartnerCenterCustomerUser ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer deleted users**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -deleted | ? id -EQ '<user id>'

**Restore a customer deleted user**

    Restore-PartnerCenterCustomerUser -tenantid $customer.id -user $user