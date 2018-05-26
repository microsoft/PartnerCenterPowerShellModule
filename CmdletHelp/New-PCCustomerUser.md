# New-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Create a customer user ##

```powershell
    $password = '<password>'
    $passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force

    New-PCCustomerUser -TenantId $customer.id -usageLocation '<Country code>' -userPrincipalName '<upn>' -FirstName '<first name>' -LastName '<last name>' -displayName '<display name>' -forceChangePassword $true -password $passwordSecure
```
