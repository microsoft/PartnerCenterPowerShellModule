# Set-PCCustomerUser

Updates the specified customer user account.

## SYNTAX

```powershell
Set-PCCustomerUser [-TenantId <String>] -UserId <String> [-FirstName <String>] [-LastName <String>] [-UserPrincipalName <String>] [-Location <String>] [-Password <SecureString>] [-ForceChangePassword <Boolean>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCustomerUser cmdlet modifies a customer user account.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    named
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -UserId &lt;String&gt;

Specifies the user id to modify.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -FirstName &lt;String&gt;

Specifies the modified first name for the user.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -LastName &lt;String&gt;

Specifies the modified last name for the user.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -UserPrincipalName &lt;String&gt;

Specifies a modified user name including the domain name.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Location &lt;String&gt;

Specifies a modified location for the user.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Password &lt;SecureString&gt;

Specifies an updated password as a secure string to set for the user.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ForceChangePassword &lt;Boolean&gt;

Specifies whether the user will need to change their password the next time they sign in.

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    named
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Update a customer user's last name
Find the tenant information about the customer named Wingtip Toys

```powershell
PS C:\>$customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Find the user with the joan@wingtiptoyscsptest.onmicrosoft.com

```powershell
PS C:\>$user = Get-PCCustomerUser -TenantId $customer.id | Where-Object {$_.userPrincipalName -eq 'joan@wingtiptoyscsptest.onmicrosoft.com'}
```

Modify the user's last name

```powershell
PS C:\>Set-PCCustomerUser -TenantId $customer.id -userId $user.id -LastName 'Sullivan'
```

### EXAMPLE 2

Reset a customer user's password
Find the tenant information about the customer named Wingtip Toys

```powershell
PS C:\>$customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Find the user with the joan@wingtiptoyscsptest.onmicrosoft.com

```powershell
PS C:\>$user = Get-PCCustomerUser -TenantId $customer.id | Where-Object {$_.userPrincipalName -eq 'joan@wingtiptoyscsptest.onmicrosoft.com'}
```

Set the password for the user account and require the user to change the password during the next sign on.

```powershell
PS C:\>$password = '<password>'
PS C:\>$passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force
PS C:\>Set-PCCustomerUser -TenantId $customer.id -UserId $user.Id -Password $passwordSecure -ForceChangePassword $true
```
