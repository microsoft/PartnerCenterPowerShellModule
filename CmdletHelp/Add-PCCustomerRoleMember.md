# Partner Center PowerShell Module (preview) #

## Add-PCCustomerRoleMember ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get a role**

    $role = Get-PCCustomerRole -tenantid $customer.id | Where-Object name -Contains '<role name>'

**Get a User**

    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id guid>'

**Add a User to a Role**

    $customerRoleMember = [DirectoryRoleMember]::new()
    $customerRoleMember.id = $user.id
    Add-PCCustomerRoleMember -tenantid $customer.id -roleid $role.id -customerrolemember $customerRoleMember


