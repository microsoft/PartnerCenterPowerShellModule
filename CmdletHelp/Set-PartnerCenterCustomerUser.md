# Partner Center PowerShell Module (preview) #

## Set-PartnerCenterCustomerUser ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer user**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -userid '<user id>'

**Update a customer user**

    Set-PartnerCenterCustomerUser -tenantid $customer.id -user $user -userPrincipalName '<new UPN>'

**Reset a customer user password**

    $password = '<password>'
	$passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force

    Set-PartnerCenterCustomerUser -tenantid $customer.id -user $user -password $passwordSecure -forceChangePassword $true/$false
