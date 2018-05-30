# Get-PCUsage #

## Get a customer ##

```powershell
    Select-PCCustomer -TenantId '<tenant id GUID>'
```

## Get a subscription ##

```powershell
    Get-PCSubscription
```

## Gets the utilization records of a customer's Azure subscription for a specified period ##

```powershell
    Get-PCUsage -SubscriptionId $subscription.id -StartTime "01-12-1999 00:00:00" -EndTime "12-31-1999 00:00:00" -Granularity {daily | hourly} -ShowDetails  <bool> -Limit <int>
```
