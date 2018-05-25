# Get-PCUsage #

## Get a customer ##

```powershell
    Select-PCCustomer -tenantId '<tenant id GUID>'
```

## Get a subscription ##

```powershell
    Get-PCSubscription -all
```

## Gets first page of utilization records of a customer's Azure subscription for a specified period ##

```powershell
    $usageData = Get-PCUsage2 -subscriptionid $subscription.id -startTime "01-12-1999 00:00:00" -endTime "31-12-1999 00:00:00" -granularity {daily | hourly}-showDetails  <bool> -size <int>
```

## Gets the next page of utilization records of a customer's Azure subscription for a specified period ##

```powershell
    # Check the Links data includes a 'next' member
    $usageData = Get-PCUsage2 -continuationLink $usageData.Links
```
