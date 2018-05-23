# Set-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id>'
```

## Update a customer user ##

```powershell
    Set-PCCustomerUser -tenantid $customer.id -user $user -userPrincipalName '<new UPN>'
```

## Reset a customer user password ##

```powershell
    $password = '<password>'
    $passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force

    Set-PCCustomerUser -tenantid $customer.id -user $user -password $passwordSecure -forceChangePassword $true/$false
```
