# Partner Center PowerShell Module (preview) #

## Set-PCSubscription ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get a customer subscription**

    $subscription = Get-PCSubscription -tenantid $customer.id -subscriptionid '<subscription id GUID>'

**Update subscription friendly name**

    $subscription | Set-PCSubscription -tenantid $customer.id -friendlyName '<friendly name>'

**Update subscription seats (license based only)**

    $subscription | Set-PCSubscription -tenantid $customer.id -quantity <seats number>

**Change subscription auto renewal**

    $subscription | Set-PCSubscription -tenantid $customer.id -AutoRenewEnabled disabled

**Suspend a subscription**

    $subscription | Set-PCSubscription -tenantid $customer.id -status suspended

**Activate a subscription**

    $subscription | Set-PCSubscription -tenantid $customer.id -status active

