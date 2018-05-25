# Add-PCCustomerRoleMember #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get a role ##

```powershell
    $role = Get-PCCustomerRole -tenantId $customer.id | Where-Object name -Contains '<role name>'
```

## Get a User ##

```powershell
    $user = Get-PCCustomerUser -tenantId $customer.id -userid '<user id guid>'
```

## Add a User to a Role ##

```powershell
    $customerRoleMember = [DirectoryRoleMember]::new()
    $customerRoleMember.id = $user.id
    Add-PCCustomerRoleMember -tenantId $customer.id -roleid $role.id -customerrolemember $customerRoleMember
```
