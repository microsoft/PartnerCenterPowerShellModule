# Get-PCCustomerUserRole

TODO

## SYNTAX

```powershell
Get-PCCustomerUserRole [[-TenantId] <String>] [[-UserId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerUserRoles cmdlet returns a list of roles for a specified tenant or user.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant is used for scoping this cmdlet.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -UserId &lt;String&gt;

Specifies the user id for which to retrieve the roles.

```
Required?                    false
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

Get a list of all roles for the specified tenant.

```powershell
PS C:\>Get-PCCustomerUserRole -TenantId a7bc20f7-6041-4165-8bef-59d0e7e8d67b
```

### EXAMPLE 2

Get a list of all the roles for the specified tenant id and user id.

```powershell
PS C:\>Get-PCCustomerUserRole -TenantId a7bc20f7-6041-4165-8bef-59d0e7e8d67b -UserId e2e56b09-aac5-4685-947d-29e735ee7ed7
```
