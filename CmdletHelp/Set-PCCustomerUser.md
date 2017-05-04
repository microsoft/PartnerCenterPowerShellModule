# Partner Center PowerShell Module (preview) #

## Set-PCCustomerUser ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer user**

    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'

**Update a customer user**

    Set-PCCustomerUser -tenantid $customer.id -user $user -userPrincipalName '<new UPN>'

**Reset a customer user password**

    $password = '<password>'
	$passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force

    Set-PCCustomerUser -tenantid $customer.id -user $user -password $passwordSecure -forceChangePassword $true/$false

