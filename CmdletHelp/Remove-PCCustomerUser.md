# Remove-PCCustomerUser

Deletes a user from the customer's tenant.

## SYNTAX

```powershell
Remove-PCCustomerUser [[-TenantId] <String>] [-UserId] <String> [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Remove-PCCustomerUser cmdlet removes the specified user from the customer tenant.

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

### -UserId &lt;String&gt;

Specifies the user id to remove.

```
Required?                    true
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

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

Retrieve the user id for the customer user you want to delete

```powershell
PS C:\>$user = Get-PCCustomerUser -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536 | Where-Object {$_.userPrincipalName -eq 'John@wingtiptoyscsptest.onmicrosoft.com'}
```

Delete the specified customer user

```powershell
    Remove-PCCustomerUser -TenantId $customer.id -UserId $user.id
```
