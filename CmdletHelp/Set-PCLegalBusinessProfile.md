# Set-PCLegalBusinessProfile

Updates the partner's legal business profile.

## SYNTAX

```powershell
Set-PCLegalBusinessProfile [[-Country] <String>] [[-AddressLine1] <String>] [[-AddressLine2] <String>] [[-City] <String>] [[-State] <String>] [[-PostalCode] <String>] [[-PrimaryContactFirstName] <String>] [[-PrimaryContactLastName] <String>] [[-PrimaryContactPhoneNumber] <String>] [[-PrimaryContactEmail] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCLegalBusinessProfile cmdlet updates the partner's legal business profile.

## PARAMETERS

### -Country &lt;String&gt;

Specifies an updated two letter ISO country code for the legal business profile.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine1 &lt;String&gt;

Specifies an updated street address for the legal business profile.

```
Required?                    false
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine2 &lt;String&gt;

Specifies an updated second address line for the legal business profile.

```
Required?                    false
Position?                    3
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -City &lt;String&gt;

Specifies an updated city name for the legal business profile.

```
Required?                    false
Position?                    4
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -State &lt;String&gt;

Specifies an updated city name for the legal business profile.

```
Required?                    false
Position?                    5
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PostalCode &lt;String&gt;

Specifies an updated postal code for the legal business profile.

```
Required?                    false
Position?                    6
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PrimaryContactFirstName &lt;String&gt;

Specifies an updated first name for the primary legal business contact.

```
Required?                    false
Position?                    7
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PrimaryContactLastName &lt;String&gt;

Specifies an updated last name for the primary legal business contact.

```
Required?                    false
Position?                    8
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PrimaryContactPhoneNumber &lt;String&gt;

Specifies an updated phone number for the primary legal business contact.

```
Required?                    false
Position?                    9
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PrimaryContactEmail &lt;String&gt;

Specifies an updated e-mail address for the primary legal business contact.

```
Required?                    false
Position?                    10
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    11
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Update the legal business profile to use John Smith with the email address of john@contoso.com.

```powershell
PS C:\>Set-PCLegalBusinessProfile -PrimaryContactFirstName 'John' -PrimaryContactLastName 'Smith' -PrimaryContactEmail 'john@contoso.com'
```
