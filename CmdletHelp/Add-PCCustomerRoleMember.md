# Add-PCCustomerRoleMember

Adds a customer user account.

## SYNTAX

```powershell
Add-PCCustomerRoleMember [[-TenantId] <String>] [-RoleId] <String> [-CustomerRoleMember] <PSObject> [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Add-PCCustomerRoleMember cmdlet adds a customer user account into a role.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant for which to add the role member.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -RoleId &lt;String&gt;

Specifies the role id for which to add the member.

```
Required?                    true
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -CustomerRoleMember &lt;PSObject&gt;

Specifies the member to add to the role.

```
Required?                    true
Position?                    3
Default value
Accept pipeline input?       true (ByValue, ByPropertyName)
Accept wildcard characters?  false
```
 
### -SaToken &lt;String&gt;

Specifies a security token for authenticating and executing the cmdlet.

```
Required?                    false
Position?                    4
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## OUTPUTS

System.Object

## NOTES

## EXAMPLES

### EXAMPLE 1

Specify a customer tenant

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

Get a role

```powershell
    $role = Get-PCCustomerRole -TenantId $customer.id | Where-Object name -Contains '<role name>'
```

Get a User

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id -UserId '<user id guid>'
```

Add the user to a Role

```powershell
    $customerRoleMember = [DirectoryRoleMember]::new()
    $customerRoleMember.id = $user.id
    Add-PCCustomerRoleMember -TenantId $customer.id -RoleId $role.id -CustomerRoleMember $customerRoleMember
```
