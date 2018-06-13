# Remove-PCCustomerRoleMember

Removes the specified user id from the specified role id.

## SYNTAX

```powershell
Remove-PCCustomerRoleMember [[-TenantId] <String>] [-RoleId] <String> [-UserId] <String> [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Remove-PCCustomerRoleMember cmdlet removes the specified user from the specified role.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -RoleId &lt;String&gt;

Specifies the role guid for which to remove the user.

```
Required?                    true
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -UserId &lt;String&gt;

Specifies the user id to remove from the role.

```
Required?                    true
Position?                    3
Default value
Accept pipeline input?       false
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

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Remove a user from a specified role.

Get a customer named Wingtip Toys

```powershell
    $customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Get a role named

```powershell
     $role = Get-PCCustomerRole -TenantId $customer.id | Where-Object {$_.Name -eq 'Helpdesk Administrator'}
```

Get a User

```powershell
    $user = Get-PCCustomerUser -TenantId $customer.id | Where-Object {$_.userPrincipalName -eq 'John@wingtiptoyscsptest.onmicrosoft.com'}
```

Remove a user from a role

```powershell
    Remove-PCCustomerRoleMember -TenantId $customer.id -RoleId $role.id -UserId $user.id
```
