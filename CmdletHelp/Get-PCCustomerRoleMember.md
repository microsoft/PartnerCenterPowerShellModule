# Get-PCCustomerRoleMember

Returns a list of members for the specified role.

## SYNTAX

```powershell
Get-PCCustomerRoleMember [-RoleId] <String> [[-TenantId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerRoleMember cmdlet returns a list of members for the specified role.

## PARAMETERS

### -RoleId &lt;String&gt;

Specifies the role id.

```
Required?                    true
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    2
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies a security token for authenticating and executing the cmdlet.

```
Required?                    false
Position?                    3
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>Get-PCCustomerRoleMember
```

### EXAMPLE 2

Specify a customer

```powershell
    $customer = Get-PCCustomer -TenantId '97037612-799c-4fa6-8c40-68be72c6b83c'
```

Get customer role

```powershell
    $role = Get-PCCustomerRole -TenantId $customer.id | Where-Object Name -EQ '<Role Name>'
```

Get customer user roles

```powershell
    Get-PCCustomerRoleMember -TenantId $customer.id -RoleId $role.id
```
