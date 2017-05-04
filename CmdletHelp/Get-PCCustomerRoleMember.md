# Partner Center PowerShell Module (preview) #

## Get-PCCustomerRoleMember ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer role**

    $role = Get-PCCustomerRole -tenantid $customer.id | Where-Object Name -EQ '<Role Name>' 

**Get customer user roles**

    Get-PCCustomerRoleMember -tenantid $customer.id -roleid $role.id


