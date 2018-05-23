# Remove-PCCustomerRoleMember #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get a role ##

```powershell
    $role = Get-PCDirectoryRoles -tenantid $customer.id | Where-Object name -Contains '<role name>'
```

## Get a User ##

```powershell
    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id guid>'
```

## Remove a User from a Role ##

```powershell
    Remove-PCCustomerRoleMember -tenantid $customer.id -roleid $role.id -userid $user.id
```
