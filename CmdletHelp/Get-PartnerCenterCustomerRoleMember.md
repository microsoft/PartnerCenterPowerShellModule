# Partner Center PowerShell Module #

## Get-PartnerCenterCustomerRoleMember ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer role**

    $role = Get-PartnerCenterCustomerRole -tenantid $customer.id | Where-Object Name -EQ '<Role Name>' 

**Get customer user roles**

    Get-PartnerCenterCustomerRoleMember -tenantid $customer.id -roleid $role.id
