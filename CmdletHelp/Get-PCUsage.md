# Get-PCUsage #

## Get a customer ##

```powershell
    Select-PCCustomer -tenantId '<tenant id GUID>'
```

## Get a subscription ##

```powershell
    Get-PCSubscription -all
```

## Gets the utilization records of a customer's Azure subscription for a specified period ##

```powershell
    Get-PCUsage -subscriptionid $subscription.id -startTime "01-12-1999 00:00:00" -endTime "12-31-1999 00:00:00" -granularity {daily | hourly}-showDetails  <bool> -size <int>
```
