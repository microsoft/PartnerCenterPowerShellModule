# Partner Center PowerShell Module (preview) #

## Get-PCSubscription ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get all customer subscriptions**

    Get-PCSubscription -tenantid $customer.id -all

**Get a customer subscription**

    Get-PCSubscription -tenantid $customer.id -subscriptionid '<subscription id GUID>'

**Get all customer subscriptions from an order**

    Get-PCSubscription -tenantid $customer.id -orderid '<order id GUID>'

**Get all customer subscriptions from a reseller (available only for Distributor CSP Account)**

    Get-PCSubscription -tenantid $customer.id -partnerid '<MPNID>'

