# Set-PCCustomerBillingProfile

Updates the specified customer's billing profile. The cmdlet accepts an updated billing profile object to determine the updates to be made. Use either Get-PCCustomerBillingProfile or New-PCCustomerBillingProfile cmdlet to create the updated customer billing profile object.

## SYNTAX

```powershell
Set-PCCustomerBillingProfile [[-TenantId] <String>] [-BillingProfile] <PSObject> [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCCustomerBillingProfile cmdlet updates a customer's billing profile.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -BillingProfile &lt;PSObject&gt;

Specifies a variable that includes the billing profile.

```
Required?                    true
Position?                    2
Default value
Accept pipeline input?       true (ByValue, ByPropertyName)
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    3
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Update the current customer billing profile.

Get the current customer billing profile.

```powershell
PS C:\>$customerBillingProfile = Get-PCCustomerBillingProfile -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536
```

Update name and email address on the customer billing profile.

```powershell
    $customerBillingProfile.FirstName = 'Joan'
    $customerBillingProfile.LastName = 'Sullivan'
    $customerBillingProfile.Email = 'joan@wingtiptoyscsptest.onmicrosoft.com'
```

Complete update for the customer's billing profile

```powershell
    Set-PCCustomerBillingProfile -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536 -BillingProfile $customerBillingProfile
```
