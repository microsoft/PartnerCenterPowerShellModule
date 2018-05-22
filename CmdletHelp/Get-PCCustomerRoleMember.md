# Get-PCCustomerRoleMember #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer role ##

```powershell
    $role = Get-PCCustomerRole -tenantid $customer.id | Where-Object Name -EQ '<Role Name>'
```

## Get customer user roles ##

```powershell
    Get-PCCustomerRoleMember -tenantid $customer.id -roleid $role.id
```
