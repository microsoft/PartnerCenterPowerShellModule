# Get-PCUsage #

## Get a customer ##

```powershell
    Select-PCCustomer -TenantId '<tenant id GUID>'
```

## Get a subscription ##

```powershell
    Get-PCSubscription -all
```

## Gets first page of utilization records of a customer's Azure subscription for a specified period ##

```powershell
    $usageData = Get-PCUsage2 -SubscriptionId $subscription.id -StartTime "01-12-1999 00:00:00" -EndTime "31-12-1999 00:00:00" -Granularity {daily | hourly}-ShowDetails  <bool> -Limit <int>
```

## Gets the next page of utilization records of a customer's Azure subscription for a specified period ##

```powershell
    # Check the Links data includes a 'next' member
    $usageData = Get-PCUsage2 -ContinuationLink $usageData.Links
```
