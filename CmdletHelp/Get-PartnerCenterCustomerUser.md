# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterCustomerUser ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get all customer users**

    Get-PartnerCenterCustomerUser -tenantid $customer.id -all

**Get customer user**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -userid '<user id>'

**Get customer user assigned licenses**

    Get-PartnerCenterCustomerUser -tenantid $customer.id -userid $user.id -licenses

**Get customer deleted users**

    Get-PartnerCenterCustomerUser -tenantid $customer.id -deleted
