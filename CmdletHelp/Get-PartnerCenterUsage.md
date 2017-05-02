# Partner Center PowerShell Module #

## Get-PartnerCenterUsage ##

**Get a customer**

    Select-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get a subscription**

    Get-PartnerCenterSubscription -all

**Gets the utilization records of a customer's Azure subscription for a specified time period**

    Get-PartnerCenterUsage -subscriptionid $subscription.id -start_time "01-12-1999 00:00:00" -end_time "31-12-1999 00:00:00" -granularity {daily | hourly}-show_details  <bool> -size <int>