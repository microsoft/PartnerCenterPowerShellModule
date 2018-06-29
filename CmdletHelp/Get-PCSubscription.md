# Get-PCSubscription

Returns a list of subscriptions for the specified tenant.

## SYNTAX

```powershell
Get-PCSubscription [-TenantId <String>] [-SaToken <String>] [-SubscriptionId <String>] [-AddOns] [<CommonParameters>]

Get-PCSubscription [-TenantId <String>] [-SaToken <String>] -PartnerId <String> [-ResultSize <Int32>] [<CommonParameters>]

Get-PCSubscription [-TenantId <String>] [-SaToken <String>] [-OrderId <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCSubscription cmdlet returns a list of subscriptions for a specified customer tenant or MPN partner id.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet. The tenant must be specified either using this parameter or by using the Select-PCCustomer cmdlet.

```
Required?                    false
Position?                    named
Default value                $GlobalCustomerId
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

### -SubscriptionId &lt;String&gt;

Specifies a subscription id for which to return detailed information.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddOns &lt;SwitchParameter&gt;

Specifies whether you want to return any addons for the subscription.

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PartnerId &lt;String&gt;

Specifies the Mpn partner id for which to list the subscriptions.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -OrderId &lt;String&gt;

Specifies an order id to for which to return a list of subscriptions.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Return a list of all subscriptions for the specified partner id

```powershell
PS C:\>Get-PCSubscription  -PartnerId '46662300'
```

### EXAMPLE 2

Return information about the specified subscription.

```powershell
PS C:\>Get-PCSubscription -TenantId 99ed2a33-e3ea-34df-bade-30997e2413e5 -SubscriptionId 335c4cad-b235-4a31-8273-e73da43e7817
```

### EXAMPLE 3

Return a list of subscriptions from an order.

```powershell
PS C:\>Get-PCSubscription -TenantId 99ed2a33-e3ea-34df-bade-30997e2413e5 -OrderId 335c4cad-b235-4a31-8273-e73da43e7817
```

### EXAMPLE 4

Return a list of customer subscriptions from a reseller (Only available in an Indirect Provider tenant)

```powershell
PS C:\>Get-PCSubscription -TenantId 99ed2a33-e3ea-34df-bade-30997e2413e5 -PartnerId '46662300'
```
