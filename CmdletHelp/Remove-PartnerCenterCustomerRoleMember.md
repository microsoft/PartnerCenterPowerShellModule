# Partner Center PowerShell Module #

## Remove-PartnerCenterCustomerRoleMember ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get a role**

    $role = Get-PartnerCenterDirectoryRoles -tenantid $customer.id | Where-Object name -Contains '<role name>'

**Get a User**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -userid '<user id guid>'

**Remove a User from a Role**

    Remove-PartnerCenterCustomerRoleMember -tenantid $customer.id -roleid $role.id -userid $user.id
