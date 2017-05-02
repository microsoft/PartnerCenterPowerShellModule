# Partner Center PowerShell Module #

## New-PartnerCenterOrder ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Order a new subscription**

    # Get offer
    Get-PartnerCenterOffer -countryid '<country two digits id>' -offerid '<offer id GUID>'
    
    # Create the OrderLineItem
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $offer.id
    $lineItems[0].Quantity = <quantity>
    
    # Send order
    New-PartnerCenterOrder -tenantid $customer.id -orderid $order.id -LineItems $lineItems
    
**Order an Addon to a subscription**

    # Get subscription
    $subscription = Get-PartnerCenterSubscription -tenantid $customer.id -subscriptionid '<subscription id>'
    
    # Get list of addons available for the subscription offer
    $addons = Get-PartnerCenterOffer -countryid '<country two digits id>' -offerid $subscription.offerId -addons

    # Get addon offer
    $addon = Get-PartnerCenterOffer -countryid 'US' -offerid '<offer id>'
    
    # Get subscription order
    $order = Get-PartnerCenterOrder -tenantid $customer.id -orderid $subscription.orderId
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
    New-PartnerCenterOrder -tenantid $customer.id -orderid $order.id -LineItems $lineItems
