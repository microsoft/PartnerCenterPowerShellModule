# Get-PCSubscriptionMonthlyUsageRecords #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get usage data for subscriptions ##

```powershell
    Get-PCSubscriptionMonthlyUsageRecords -tenantid $customer.id
```
