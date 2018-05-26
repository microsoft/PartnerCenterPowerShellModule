# Add-PCCustomerRoleMember #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get a role ##

```powershell
    $role = Get-PCCustomerRole -TenantId $customer.id | Where-Object name -Contains '<role name>'
```

## Get a User ##

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -userid '<user id guid>'
```

## Add a User to a Role ##

```powershell
    $customerRoleMember = [DirectoryRoleMember]::new()
    $customerRoleMember.id = $user.id
    Add-PCCustomerRoleMember -TenantId $customer.id -roleid $role.id -customerrolemember $customerRoleMember
```
