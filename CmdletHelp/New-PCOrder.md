# Partner Center PowerShell Module (preview) #

## New-PCOrder ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Order a new subscription**

    # Get offer
    Get-PCOffer -countryid '<country two digits id>' -offerid '<offer id GUID>'
    
    # Create the OrderLineItem
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $offer.id
    $lineItems[0].Quantity = <quantity>
    
    # Send order
    New-PCOrder -tenantid $customer.id -orderid $order.id -LineItems $lineItems
    
**Order an Addon to a subscription**

    # Get subscription
    $subscription = Get-PCSubscription -tenantid $customer.id -subscriptionid '<subscription id>'
    
    # Get list of addons available for the subscription offer
    $addons = Get-PCOffer -countryid '<country two digits id>' -offerid $subscription.offerId -addons

    # Get addon offer
    $addon = Get-PCOffer -countryid 'US' -offerid '<offer id>'
    
    # Get subscription order
    $order = Get-PCOrder -tenantid $customer.id -orderid $subscription.orderId
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
    New-PCOrder -tenantid $customer.id -orderid $order.id -LineItems $lineItems

