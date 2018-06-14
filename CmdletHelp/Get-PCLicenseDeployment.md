# Get-PCLicenseDeployment

Returns a list of licenses for the authenticated partner.

## SYNTAX

```powershell
Get-PCLicenseDeployment [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCLicenseDeployment cmdlet retrieves a list of licenses for the authenticated partner.

## PARAMETERS

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    1
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

You need to have a credential before running this cmdlet.

## EXAMPLES

### EXAMPLE 1

Return a list of assigned licenses for the authenticated partner.

```powershell
PS C:\>Get-PCLicenseDeployment
```
