# New-PCCustomerUser

Creates a new user in the specified customer Azure Active Directory tenant.

## SYNTAX

```powershell
New-PCCustomerUser [-TenantId <String>] -UsageLocation <String> -UserPrincipalName <String> -FirstName <String> -LastName <String> -DisplayName <String> -Password <SecureString> -ForceChangePassword <Boolean> [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The New-PCCustomerUser cmdlet creates a new user in the tenant Azure Active Directory.

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

### -UsageLocation &lt;String&gt;

Specifies the location the user will be used.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -UserPrincipalName &lt;String&gt;

Specifies the user name including the domain for the new user.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -FirstName &lt;String&gt;

Specifies the first name of the new users.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -LastName &lt;String&gt;

Specifies the last name for the new user.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -DisplayName &lt;String&gt;

Specifies the display name for the new user.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Password &lt;SecureString&gt;

Specifies a secure string to be assigned as the password for the new user.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ForceChangePassword &lt;Boolean&gt;

Specifies whether the new user must change their password during the first logon.

```
Required?                    true
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

```powershell
PS C:\>New-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -UsageLocation US -userPrincipalName 'joe@contoso.onmicrosoft.com' -FirstName 'Joe' -LastName 'Smith' -DisplayName 'Joe Smith' -ForceChangePassword $true -Password $PasswordSecure
```
