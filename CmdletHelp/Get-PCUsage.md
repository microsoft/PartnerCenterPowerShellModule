# Partner Center PowerShell Module (preview) #

## Get-PCUsage ##

**Get a customer**

    Select-PCCustomer -tenantid '<tenant id GUID>'

**Get a subscription**

    Get-PCSubscription -all

**Gets the utilization records of a customer's Azure subscription for a specified time period**

    Get-PCUsage -subscriptionid $subscription.id -start_time "01-12-1999 00:00:00" -end_time "31-12-1999 00:00:00" -granularity {daily | hourly}-show_details  <bool> -size <int>

