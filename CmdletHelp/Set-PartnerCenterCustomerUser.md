# Partner Center PowerShell Module (preview) #

## Set-PartnerCenterCustomerUser ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer user**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -userid '<user id>'

**Update a customer user**

    Set-PartnerCenterCustomerUser -tenantid $customer.id -user $user -userPrincipalName '<new UPN>'

**Reset a customer user password**

    Set-PartnerCenterCustomerUser -tenantid $customer.id -user $user -password '<new password>' -forceChangePassword $true/$false
