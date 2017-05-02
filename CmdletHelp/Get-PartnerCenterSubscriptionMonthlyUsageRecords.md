# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterSubscriptionMonthlyUsageRecords ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get usage data for subscriptions**

    Get-PartnerCenterSubscriptionMonthlyUsageRecords -tenantid $customer.id

