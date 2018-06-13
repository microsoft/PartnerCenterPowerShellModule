# Get-PCUsage

Retrieve a collection of usage records for the specified date range. Usage records are only available for the last 90 days.

## SYNTAX

```powershell
Get-PCUsage -SubscriptionId <String> -StartTime <String> -EndTime <String> [-Granularity <String>] [-ShowDetail <Boolean>] [-ResultSize <Int32>] [-TenantId <String>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

<<<<<<< HEAD
The Get-PCUsage cmdlet returns the usage records specified by the start and end times.

## PARAMETERS

### -SubscriptionId &lt;String&gt;

Specifies a subscription if for which to return usage information.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -StartTime &lt;String&gt;

Specifies the start time for which to retrieve usage information. Usage is only available for the last 90 days, therefore this value cannot be more than 90 days from the current date.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
=======
```powershell
    Get-PCSubscription -all
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
```

### -EndTime &lt;String&gt;

Specifies the end time for which to retrieve usage information.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Granularity &lt;String&gt;

Specifies the granularity of the data to return. Valid values are: daily or hourly. The default value is daily.

```
Required?                    false
Position?                    named
Default value                daily
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ShowDetail &lt;Boolean&gt;

Default this is set to $true. If set to $true, the utilization records will be split by the resource instance levels. If set to false, the utilization records will be aggregated on the resource level.

```
Required?                    false
Position?                    named
Default value                True
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ResultSize &lt;Int32&gt;

Specifies the maximum number of results to return. The default value and the maximum value is 1000. To retrieve more than 1000 records you must use the continuation link.

```
Required?                    false
Position?                    named
Default value                1000
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    named
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies a authentication token you have created with your Partner Center credentials.

```
Required?                    false
Position?                    named
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Return up to 2000 hourly usage records for the specified date range.

```powershell
<<<<<<< HEAD
PS C:\>Get-PCUsage -TenantId 2a14b164-f983-4048-92e1-4f9591b87445 -SubscriptionId b027a4b3-5487-413b-aa48-ec8733c874d6 -StartTime '06-12-2018 00:00:00' -EndTime '06-31-2018 23:59:59' -Granularity hourly -ResultSize 2000
=======
    Get-PCUsage -subscriptionid $subscription.id -startTime "01-12-1999 00:00:00" -endTime "12-31-1999 00:00:00" -granularity {daily | hourly}-showDetails  <bool> -size <int>
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
```
