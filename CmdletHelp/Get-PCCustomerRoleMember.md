# Get-PCCustomerRoleMember #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer role ##

```powershell
    $role = Get-PCCustomerRole -tenantId $customer.id | Where-Object Name -EQ '<Role Name>'
```

## Get customer user roles ##

```powershell
    Get-PCCustomerRoleMember -tenantId $customer.id -roleid $role.id
```
