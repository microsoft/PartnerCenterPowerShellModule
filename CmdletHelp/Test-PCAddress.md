# Test-PCAddress

Validates the provided address information to determine if it meets the Partner Center validation rules.

## SYNTAX

```powershell
Test-PCAddress -Address <DefaultAddress> [-SaToken <String>] [<CommonParameters>]

Test-PCAddress -AddressLine1 <String> [-AddressLine2 <String>] -City <String> -State <String> -PostalCode <String> -Country <String> [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Test-PCAddress cmdlet validates the provided the address information as to whether it conforms to the Partner Center address rules.

## PARAMETERS

### -Address &lt;DefaultAddress&gt;

Specifies a variable object that includes all of the address information. This object can be created by using the New-PCAddress cmdlet.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine1 &lt;String&gt;

Specifies the first address line.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddressLine2 &lt;String&gt;

Specifies the second address line.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -City &lt;String&gt;

Specifies the city.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -State &lt;String&gt;

Specifies the state.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PostalCode &lt;String&gt;

Specifies the postal code.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Country &lt;String&gt;

Specifies a two letter ISO code to define the country.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an partner center access token.

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

Validate an address by passing an object variable named $add that was created using the New-PCAddress cmdlet.

```powershell
PS C:\>$address = New-PCAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -Country 'two digits Country code' -region '<string>'
PS C:\>Test-PCAddress -Address $add
```

### EXAMPLE 2

Validate an address by passing the address information to the cmdlet.

```powershell
PS C:\>Test-PCAddress -AddressLine1 '1 Microsoft Way' -City 'Redmond' -State 'WA' -Country 'US' -PostalCode '95802'
```
