# Partner Center PowerShell Module (preview) #

## Remove-PCCustomerRoleMember ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get a role**

    $role = Get-PCDirectoryRoles -tenantid $customer.id | Where-Object name -Contains '<role name>'

**Get a User**

    $user = Get-PCCustomerUser -tenantid $customer.id -userid '<user id guid>'

**Remove a User from a Role**

    Remove-PCCustomerRoleMember -tenantid $customer.id -roleid $role.id -userid $user.id

