# Partner Center PowerShell Module (preview) #

## Get-PCSubscriptionMonthlyUsageRecords ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get usage data for subscriptions**

    Get-PCSubscriptionMonthlyUsageRecords -tenantid $customer.id


