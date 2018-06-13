# Get-PCDomainAvailability

Tests to see if the specified onmicrosoft.com is available to be used for a new tenant.

## SYNTAX

```powershell
Get-PCDomainAvailability [-Domain] <String> [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCDomainAvailability cmdlet tests to see if the specified tenant domain (onmicrosoft.com) is available to create a new tenant.

## PARAMETERS

### -Domain &lt;String&gt;

Specifies an onmicrosoft.com domain to check as to whether is available for use for a new tenant.

```
Required?                    true
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies a security token for authenticating and executing the cmdlet.

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

## EXAMPLES

### EXAMPLE 1

Test to see if contoso.onmicrosoft.com is available for a new tenant.

```powershell
PS C:\>Get-PCDomainAvailabilty -Domain contoso.onmicrosoft.com
```
