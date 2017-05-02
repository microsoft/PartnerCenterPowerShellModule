# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterCustomerUserRole ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer user**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -userid '<user id>'

**Get customer user roles**

    Get-PartnerCenterCustomerUserRole -tenantid $customer.id -user $user
