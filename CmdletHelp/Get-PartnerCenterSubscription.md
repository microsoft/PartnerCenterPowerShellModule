# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterSubscription ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get all customer subscriptions**

    Get-PartnerCenterSubscription -tenantid $customer.id -all

**Get a customer subscription**

    Get-PartnerCenterSubscription -tenantid $customer.id -subscriptionid '<subscription id GUID>'

**Get all customer subscriptions from an order**

    Get-PartnerCenterSubscription -tenantid $customer.id -orderid '<order id GUID>'

**Get all customer subscriptions from a reseller (available only for Distributor CSP Account)**

    Get-PartnerCenterSubscription -tenantid $customer.id -partnerid '<MPNID>'
