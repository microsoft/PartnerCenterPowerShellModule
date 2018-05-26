# Get-PCCustomerRoleMember #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer role ##

```powershell
    $role = Get-PCCustomerRole -TenantId $customer.id | Where-Object Name -EQ '<Role Name>'
```

## Get customer user roles ##

```powershell
    Get-PCCustomerRoleMember -TenantId $customer.id -roleid $role.id
```
