# New-PCOrder #

## Select a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Order a new subscription ##

```powershell
    # Get offer
    $offer = Get-PCOffer -countryId '<country two digits id>' -offerId '<offer id GUID>'

    # Create the OrderLineItem
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $offer.id
    $lineItems[0].Quantity = <quantity>

    # Send order
    New-PCOrder -tenantId $customer.id -LineItems $lineItems
```

## Order an Addon to a subscription ##

```powershell
    # Get subscription
    $subscription = Get-PCSubscription -tenantId $customer.id -subscriptionid '<subscription id>'

    # Get list of addons available for the subscription offer
    $addons = Get-PCOffer -countryId '<country two digits id>' -offerId $subscription.offerId -addons

    # Get addon offer
    $addon = Get-PCOffer -countryId 'US' -offerId '<offer id>'

    # Get subscription order
    $order = Get-PCOrder -tenantId $customer.id -orderId $subscription.orderId
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
    New-PCOrder -tenantId $customer.id -orderId $order.id -LineItems $lineItems
```
