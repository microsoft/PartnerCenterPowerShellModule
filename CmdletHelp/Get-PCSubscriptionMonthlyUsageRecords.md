# Get-PCSubscriptionMonthlyUsageRecords #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get usage data for subscriptions ##

```powershell
    Get-PCSubscriptionMonthlyUsageRecords -TenantId $customer.id
```
