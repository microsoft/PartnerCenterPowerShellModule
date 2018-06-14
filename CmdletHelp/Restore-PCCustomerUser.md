# Restore-PCCustomerUser

Restores a deleted customer user.

## SYNTAX

```powershell
Restore-PCCustomerUser [[-TenantId] <String>] [-UserId] <String> [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Restore-PCCustomerUser cmdlet restores a deleted customer user.

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

Specifies the user id to restore.

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

Find the deleted account.

```powershell
PS C:\>$user = Get-PCCustomerUser -Deleted -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536 | Where-Object {$_.userPrincipalName -eq 'John@wingtiptoyscsptest.onmicrosoft.com'}
```

Restore the deleted user account

```powershell
    Restore-PCCustomerUser -TenantId $customer.id -UserId $User.Id
```
