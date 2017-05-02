# Partner Center PowerShell Module (preview) #

## Add-PartnerCenterCustomerRoleMember ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get a role**

    $role = Get-PartnerCenterCustomerRole -tenantid $customer.id | Where-Object name -Contains '<role name>'

**Get a User**

    $user = Get-PartnerCenterCustomerUser -tenantid $customer.id -userid '<user id guid>'

**Add a User to a Role**

    $customerRoleMember = [DirectoryRoleMember]::new()
    $customerRoleMember.id = $user.id
    Add-PartnerCenterCustomerRoleMember -tenantid $customer.id -roleid $role.id -customerrolemember $customerRoleMember
