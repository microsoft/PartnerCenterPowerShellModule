# Partner Center PowerShell Module (preview) #

## Add-PCCustomerRoleMember ##

### Get a customer ###

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

### Get a role ###

```powershell
    $role = Get-PCCustomerRole -tenantid $customer.id | Where-Object name -Contains '<role name>'
```

### Get a User ###

```powershell
    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id guid>'
```

### Add a User to a Role ###

```powershell
    $customerRoleMember = [DirectoryRoleMember]::new()
    $customerRoleMember.id = $user.id
    Add-PCCustomerRoleMember -tenantid $customer.id -roleid $role.id -customerrolemember $customerRoleMember
```
