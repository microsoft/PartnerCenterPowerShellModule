# Get-PCCustomerServiceCostSummary

Returns a cost summary for the specified billing period.

## SYNTAX

```powershell
Get-PCCustomerServiceCostSummary [-BillingPeriod] <String> [[-TenantId] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomerServiceCostSummary returns a cost summary for the specified billing period.

## PARAMETERS

### -BillingPeriod &lt;String&gt;

Specifies the billing period
```
Required?                    true
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.
```
Required?                    false
Position?                    2
Default value                $GlobalCustomerId
Accept pipeline input?       false
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

Other BillingPeriod types may be available in a future release.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\>Get-PCCustomerServiceCostSummary
```

### EXAMPLE 2

Get customer service cost summary

```powershell
   Get-PCCustomerServiceCostSummary -BillingPeriod  MostRecent
```
