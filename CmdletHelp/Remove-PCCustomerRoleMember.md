# Remove-PCCustomerRoleMember #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get a role ##

```powershell
    $role = Get-PCDirectoryRoles -tenantId $customer.id | Where-Object name -Contains '<role name>'
```

## Get a User ##

```powershell
    $user = Get-PCCustomerUser -tenantId $customer.id -userid '<user id guid>'
```

## Remove a User from a Role ##

```powershell
    Remove-PCCustomerRoleMember -tenantId $customer.id -roleid $role.id -userid $user.id
```
