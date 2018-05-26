# Set-PCCustomerUser #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer user ##

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -userid '<user id>'
```

## Update a customer user ##

```powershell
    Set-PCCustomerUser -TenantId $customer.id -user $user -userPrincipalName '<new UPN>'
```

## Reset a customer user password ##

```powershell
    $password = '<password>'
    $passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force

    Set-PCCustomerUser -TenantId $customer.id -user $user -password $passwordSecure -forceChangePassword $true/$false
```
