# Get-PCSubscriptionMonthlyUsageRecords #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get usage data for subscriptions ##

```powershell
    Get-PCSubscriptionMonthlyUsageRecords -tenantId $customer.id
```
