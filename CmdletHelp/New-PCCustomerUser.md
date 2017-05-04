# Partner Center PowerShell Module (preview) #

## New-PCCustomerUser ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Create a customer user**

    $password = '<password>'
	$passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force

    New-PCCustomerUser -tenantid $customer.id -usageLocation '<country code>' -userPrincipalName '<upn>' -firstName '<first name>' -lastName '<last name>' -displayName '<display name>' -forceChangePassword $true -password $passwordSecure

