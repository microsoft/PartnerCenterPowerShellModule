# Get-PCCustomerLicenseUsage

Returns a list of licenses deployed and assigned by a partner for a specified tenant.

## SYNTAX

```powershell
Get-PCCustomerLicenseUsage [[-TenantId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerLicenseUsage cmdlet retrieves a list of licenses deployed and assigned by a partner for a specified tenant.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant id.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    2
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

This cmdlet requires App+User authentication.

## EXAMPLES

### EXAMPLE 1

Retrieve a list of assigned licenses for the specified tenant

```powershell
PS C:\>Get-PCCustomerLicenseDeployment -TenantId '97037612-799c-4fa6-8c40-68be72c6b83c'
```
