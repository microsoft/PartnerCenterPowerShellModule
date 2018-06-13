# Set-PCOrganizationProfile

Updates the partner's organization profile.

## SYNTAX

```powershell
Set-PCOrganizationProfile [[-CompanyName] <String>] [[-Country] <String>] [[-AddressLine1] <String>] [[-AddressLine2] <String>] [[-City] <String>] [[-State] <String>] [[-PostalCode] <String>] [[-FirstName] <String>] [[-LastName] <String>] [[-PhoneNumber] <String>] [[-Email] <String>] [[-Language] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCOrganizationProfile cmdlet sets information on a partner's organizational profile.

## PARAMETERS

### -CompanyName &lt;String&gt;

Specifies an updated company name for the partner's organizational profile.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Country &lt;String&gt;

Specifies an updated two letter ISO code for the partner's organizational profile.

```
Required?                    false
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine1 &lt;String&gt;

Specifies the first address line for the partner's organizational profile.

```
Required?                    false
Position?                    3
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine2 &lt;String&gt;

Specifies the second address line for the partner's organizational profile.

```
Required?                    false
Position?                    4
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -City &lt;String&gt;

Specifies the second city for the partner's organizational profile.

```
Required?                    false
Position?                    5
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -State &lt;String&gt;

Specifies the state for the partner's organizational profile.

```
Required?                    false
Position?                    6
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PostalCode &lt;String&gt;

Specifies the postal code for the partner's organizational profile.

```
Required?                    false
Position?                    7
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -FirstName &lt;String&gt;

Specifies the first name of the company contact for the partner's organizational profile.

```
Required?                    false
Position?                    8
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -LastName &lt;String&gt;

Specifies the last name of the company contact for the partner's organizational profile.

```
Required?                    false
Position?                    9
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PhoneNumber &lt;String&gt;

Specifies the phone number of the company contact for the partner's organizational profile.

```
Required?                    false
Position?                    10
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Email &lt;String&gt;

Specifies the email address for the company contact.

```
Required?                    false
Position?                    11
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Language &lt;String&gt;

Specifies the two letter ISO code for the language.

```
Required?                    false
Position?                    12
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    13
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Sets John Smith with the email address of john@contoso.com as the contact on the partner's organizational profile.

```powershell
PS C:\>Set-PCOrganizationProfile -FirstName 'John' -LastName 'Smith' -Email 'john@contoso.com'
```
