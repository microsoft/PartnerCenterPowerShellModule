# New-PCOrder

Creates a new order.

## SYNTAX

```powershell
New-PCOrder [-TenantId <String>] -OrderId <String> [-LineItems <Array>] [-SaToken <String>] [<CommonParameters>]

New-PCOrder [-TenantId <String>] -LineItems <Array> [-SaToken <String>] [<CommonParameters>]

New-PCOrder [-TenantId <String>] -OfferId <String> -Quantity <UInt16> [-FriendlyName <String>] [-PartnerIdOnRecord <String>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The New-PCOrder cmdlet creates a new order.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    named
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -OrderId &lt;String&gt;

Specifies the order id if this is an add on order.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -LineItems &lt;Array&gt;

Specifies line items to include in the order

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -OfferId &lt;String&gt;

Specifies the offer id guid for the ordered items.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Quantity &lt;UInt16&gt;

Specifies the number of licenses for a license-based subscription or instances for an Azure reservation.

```
Required?                    true
Position?                    named
Default value                0
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -FriendlyName &lt;String&gt;

Specifies a friendly name for the subscription defined by the partner to help disambiguate.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -PartnerIdOnRecord &lt;String&gt;

When an indirect provider places an order on behalf of an indirect reseller, populate this field with the MPN ID of the indirect reseller only (never the ID of the indirect provider). This ensures proper accounting for incentives.

```
Required?                    false
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

#### Order a new subscription

Select a customer

```powershell
PS C:\>$customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

Get an offer id

```powershell
    $offer = Get-PCOffer -CountryId '<Country two digits id>' -OfferId '<offer id GUID>'
```

Create the OrderLineItem

```powershell
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $offer.id
    $lineItems[0].Quantity = <quantity>
````

Send order

```powershell
New-PCOrder -TenantId $customer.id -LineItems $lineItems
```

### EXAMPLE 2

Order an Addon to an existing subscription

Get subscription

```powershell
    $subscription = Get-PCSubscription -TenantId $customer.id -subscriptionid '<subscription id>'
```

Get list of addons available for the subscription offer

```powershell
    $addons = Get-PCOffer -CountryId '<Country two digits id>' -OfferId $subscription.OfferId -addons
```

Get addon offer

```powershell
    $addon = Get-PCOffer -CountryId 'US' -OfferId '<offer id>'
```

Get subscription order

```powershell
    $order = Get-PCOrder -TenantId $customer.id -OrderId $subscription.OrderId
```

Get the next OrderLineItem number

```powershell
    $newLineItemNumber = $order.lineItems.Count
```

Create the addon OrderLineItem

```powershell
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $addon.id
    $lineItems[0].ParentSubscriptionId = $subscription.id
    $lineItems[0].Quantity = <quantity>
```

Send order

```powershell
    New-PCOrder -TenantId $customer.id -OrderId $order.id -LineItems $lineItems
```
