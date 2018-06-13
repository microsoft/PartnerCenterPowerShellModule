# New-PCRelationshipRequest

Returns the request text to send to the end customer administrator to initiate a relationship with the partner.

## SYNTAX

```powershell
New-PCRelationshipRequest [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The New-PCRelationshipRequest cmdlet.

## PARAMETERS

### -SaToken &lt;String&gt;

Specifies a security token for authenticating and executing the cmdlet.

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

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>$inviteUrl = (New-PCRelationshipRequest).Url

Get an invitation Url to send to a new customer.
```
