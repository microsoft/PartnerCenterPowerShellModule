# Partner Center PowerShell Module #

## New-PartnerCenterCustomerUser ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Create a customer user**

    New-PartnerCenterCustomerUser -tenantid $customer.id -usageLocation '<country code>' -userPrincipalName '<upn>' -firstName '<first name>' -lastName '<last name>' -displayName '<display name>' -forceChangePassword $true -password '<password>'
