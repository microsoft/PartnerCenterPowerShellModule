# Set-PCSupportProfile

Modifies the partner's support profile.

## SYNTAX

```powershell
Set-PCSupportProfile [[-Website] <String>] [[-Email] <String>] [[-Phone] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCSupportProfile cmdlet update the partner's support profile.

## PARAMETERS

### -Website &lt;String&gt;

Specifies an updated support website for the partner. Do not include 'http://', specify just the DNS name of the site.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Email &lt;String&gt;

Specifies an updated support email address for the partner.

```
Required?                    false
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Phone &lt;String&gt;

Specifies an updated support phone number for the partner.

```
Required?                    false
Position?                    3
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    4
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Updates the support website to be support.contoso.com.

```powershell
PS C:\>Set-PCSupportProfile -Website 'support.contoso.com'
```
