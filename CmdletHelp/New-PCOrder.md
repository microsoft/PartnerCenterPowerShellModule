# New-PCOrder #

## Select a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Order a new subscription ##

```powershell
    # Get offer
    $offer = Get-PCOffer -CountryId '<Country two digits id>' -OfferId '<offer id GUID>'

    # Create the OrderLineItem
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $offer.id
    $lineItems[0].Quantity = <quantity>

    # Send order
    New-PCOrder -TenantId $customer.id -LineItems $lineItems
```

## Order an Addon to a subscription ##

```powershell
    # Get subscription
    $subscription = Get-PCSubscription -TenantId $customer.id -subscriptionid '<subscription id>'

    # Get list of addons available for the subscription offer
    $addons = Get-PCOffer -CountryId '<Country two digits id>' -OfferId $subscription.OfferId -addons

    # Get addon offer
    $addon = Get-PCOffer -CountryId 'US' -OfferId '<offer id>'

    # Get subscription order
    $order = Get-PCOrder -TenantId $customer.id -OrderId $subscription.OrderId
    # Get the next OrderLineItem number
    $newLineItemNumber = $order.lineItems.Count
    # Create the addon OrderLineItem
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $addon.id
    $lineItems[0].ParentSubscriptionId = $subscription.id
    $lineItems[0].Quantity = <quantity>

    # Send order
    New-PCOrder -TenantId $customer.id -OrderId $order.id -LineItems $lineItems
```
