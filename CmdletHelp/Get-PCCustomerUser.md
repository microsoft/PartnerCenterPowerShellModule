# Get-PCCustomerUser

Returns a list of all customer users or a specified user for the tenant.

## SYNTAX

```powershell
Get-PCCustomerUser [-TenantId <String>] [-SaToken <String>] [<CommonParameters>]

Get-PCCustomerUser [-TenantId <String>] -Deleted [-ResultSize <Int32>] [-SaToken <String>] [<CommonParameters>]

Get-PCCustomerUser [-TenantId <String>] -UserId <String> [-Licenses] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerUser cmdlet returns either all users or a specified user from the tenant.

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

Specifies the user id.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Licenses &lt;SwitchParameter&gt;

Specifies whether to return the licenses assigned to the specified user.

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Deleted &lt;SwitchParameter&gt;

Specifies whether to return deleted users.

```
Required?                    true
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ResultSize &lt;Int32&gt;

Specifies the maximum number of results to return. The default value is 200.

```
Required?                    false
Position?                    named
Default value                200
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

Get all users for the specified tenant.

```powershell
PS C:\>Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f
```

### EXAMPLE 2

Get a customer user

```powershell
PS C:\>$user = Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -userid 'e2e56b09-aac5-4685-947d-29e735ee7ed7'
```

### EXAMPLE 3

Get a list of user assigned licenses for the specified user id.

```powershell
PS C:\>Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -UserId 'e2e56b09-aac5-4685-947d-29e735ee7ed7' -Licenses
```

### EXAMPLE 4

Get a list of deleted users for the tenant

```powershell
PS C:\>Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -Deleted
```
