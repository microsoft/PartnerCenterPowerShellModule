# Remove-PCCustomerRoleMember #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get a role ##

```powershell
    $role = Get-PCDirectoryRoles -TenantId $customer.id | Where-Object name -Contains '<role name>'
```

## Get a User ##

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -userid '<user id guid>'
```

## Remove a User from a Role ##

```powershell
    Remove-PCCustomerRoleMember -TenantId $customer.id -roleid $role.id -userid $user.id
```
