# Set-PCBillingProfile

Updates a partner's billing profile.

## SYNTAX

```powershell
Set-PCBillingProfile [[-Country] <String>] [[-AddressLine1] <String>] [[-AddressLine2] <String>] [[-City] <String>] [[-State] <String>] [[-PostalCode] <String>] [[-FirstName] <String>] [[-LastName] <String>] [[-PhoneNumber] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCBillingProfile cmdlet updates the partner's billing profile.

## PARAMETERS

### -Country &lt;String&gt;

Specifies the billing contact's country two letter ISO code.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine1 &lt;String&gt;

Specifies the first address line for the billing contact.

```
Required?                    false
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine2 &lt;String&gt;

Specifies the second address line for the billing contact.

```
Required?                    false
Position?                    3
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -City &lt;String&gt;

Specifies the billing contact's city.

```
Required?                    false
Position?                    4
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -State &lt;String&gt;

Specifies the billing contact's state.

```
Required?                    false
Position?                    5
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PostalCode &lt;String&gt;

Specifies the billing contact's postal code.

```
Required?                    false
Position?                    6
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -FirstName &lt;String&gt;

Specifies the billing contact's first name.

```
Required?                    false
Position?                    7
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -LastName &lt;String&gt;

Specifies the billing contact's last name.

```
Required?                    false
Position?                    8
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PhoneNumber &lt;String&gt;

Specifies the billing contact's phone number.

```
Required?                    false
Position?                    9
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    10
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
Set-PCBillingProfile -FirstName '<first name>' -LastName '<last name>' -PhoneNumber '<phone number>' -AddressLine1 '<address 1>' -AddressLine2 '<address 2>'
```
