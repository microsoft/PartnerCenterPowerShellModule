# Partner Center PowerShell Module (preview) #

## Set-PartnerCenterSubscription ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get a customer subscription**

    $subscription = Get-PartnerCenterSubscription -tenantid $customer.id -subscriptionid '<subscription id GUID>'

**Update subscription friendly name**

    $subscription | Set-PartnerCenterSubscription -tenantid $customer.id -friendlyName '<friendly name>'

**Update subscription seats (license based only)**

    $subscription | Set-PartnerCenterSubscription -tenantid $customer.id -quantity <seats number>

**Change subscription auto renewal**

    $subscription | Set-PartnerCenterSubscription -tenantid $customer.id -AutoRenewEnabled disabled

**Suspend a subscription**

    $subscription | Set-PartnerCenterSubscription -tenantid $customer.id -status suspended

**Activate a subscription**

    $subscription | Set-PartnerCenterSubscription -tenantid $customer.id -status active
