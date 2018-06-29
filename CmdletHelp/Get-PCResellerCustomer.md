# Get-PCResellerCustomer

Returns a list of reseller customers for the specified indirect provider.

## SYNTAX

```powershell
Get-PCResellerCustomer -ResellerId <String> [-ResultSize <Int32>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCResllerCustomer cmdlet returns a list of reseller customers or a speficied reseller for the current indirect provider.

## PARAMETERS

### -ResellerId &lt;String&gt;

Specifies the reseller id for which to return customers.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ResultSize &lt;Int32&gt;

Specifies the maximum number of results to return. The default value is 200, the maximum allowed value is 500.

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

```powershell
PS C:\>Get-PCResellerCustomer -ResellerId '86f61a80-23de-4071-ba9f-249254da7e95'

Return a list of customers for the specified reseller id
```
