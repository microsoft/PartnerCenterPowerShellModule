# New-PCCustomer

Creates a new customer.

## SYNTAX

```powershell
New-PCCustomer -Email <String> -Culture <String> -Language <String> -CompanyName <String> -Country <String> -Region <String> -City <String> -State <String> -AddressLine1 <String> -PostalCode <String> -FirstName <String> -LastName <String> -PhoneNumber <String> -Domain <String> [-SaToken <String>] [<CommonParameters>]

New-PCCustomer -BillingProfile <BillingProfile> -CompanyProfile <CompanyProfile> [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The New-PCCustomer cmdlet creates a new customer for the current partner.

## PARAMETERS

### -Email &lt;String&gt;

Specifies the contact email address for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Culture &lt;String&gt;

Specifies the culture for the new customer as an three letter ISO 3 country code.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Language &lt;String&gt;

Specifies the default language for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -CompanyName &lt;String&gt;

Specifies the company name for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Country &lt;String&gt;

Specifies the country name for the new customer. The country must be valid for the current partner.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Region &lt;String&gt;

Specifies the region for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -City &lt;String&gt;

Specifies the city address for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -State &lt;String&gt;

Specifies the state address for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine1 &lt;String&gt;

Specifies the first line of the address for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PostalCode &lt;String&gt;

Specifies the postal code, if needed, for the new customer.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -FirstName &lt;String&gt;

Specifies the the new customer's contact's first name.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -LastName &lt;String&gt;

Specifies the the new customer's contact's last name.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PhoneNumber &lt;String&gt;

Specifies the the new customer's contact's phone number.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Domain &lt;String&gt;

Specifies the onmicrosoft.com for the new customer tenant.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -BillingProfile &lt;BillingProfile&gt;

Specifies the billing profile.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -CompanyProfile &lt;CompanyProfile&gt;

Specifies a company profile.

```
Required?                    true
Position?                    named
Default value
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

Create a new customer.

```powershell
$newDefaultAddress = New-PCCustomerDefaultAddress -Country '<Country code>' -Region '<region>' -City '<City>' -State '<State>' -AddressLine1 '<address1>' -PostalCode '<postal code>' -FirstName '<first name>' -LastName '<last name>' -PhoneNumber '<phone number>'
$newBillingProfile = New-PCCustomerBillingProfile -FirstName '<first name>' -LastName '<last name>' -Email '<Email>' -Culture '<ex: en.us>' -Language '<ex: en>' -CompanyName '<company name>' -DefaultAddress $newDefaultAddress
$newCompanyProfile = New-PCCustomerCompanyProfile -Domain '<company name>.onmicrosoft.com'
$newCustomer = New-PCCustomer -BillingProfile $newBillingProfile -CompanyProfile $newCompanyProfile
```
