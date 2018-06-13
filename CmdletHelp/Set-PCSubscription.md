# Set-PCSubscription

Modifies an existing subscription.

## SYNTAX

```powershell
Set-PCSubscription [[-TenantId] <String>] [-Subscription] <PSObject> [[-Status] <String>] [[-FriendlyName] <String>] [[-AutoRenew] <String>] [[-Quantity] <Int32>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCSubscription cmdlet modifies an existing subscription.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    1
Default value                $GlobalCustomerId
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Subscription &lt;PSObject&gt;

Specifies the subscription object that identifies the subscription you will modified. This object can be retrieved using the Get-PCSubscription cmdlet.

```
Required?                    true
Position?                    2
Default value
Accept pipeline input?       true (ByValue, ByPropertyName)
Accept wildcard characters?  false
```

### -Status &lt;String&gt;

Specifies the status for the subscription. Valid values are: none, active, suspended, and deleted.

```
Required?                    false
Position?                    3
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -FriendlyName &lt;String&gt;

Specifies a friendly name for the subscription.

```
Required?                    false
Position?                    4
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AutoRenew &lt;String&gt;

Specifies as to whether the subscription will auto renew. This is only valid on license-based subscriptions. Valid inputs are: enabled, disabled. This parameter used to be -AutoRenewEnabled in earlier releases.

```
Required?                    false
Position?                    5
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Quantity &lt;Int32&gt;

Specifies the number of licenses included in the subscription. This is valid only on license-based subscriptions.

```
Required?                    false
Position?                    6
Default value                0
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    7
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Update subscription friendly name

Find the tenant information about the customer named Wingtip Toys
```powershell
PS C:\>$customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Find the the customer subscription

```powershell
PS C:\>$subscription = Get-PCSubscription -TenantId $customer.id | Where-Object {$_.FriendlyName -eq 'old friendly name'}
```

Update the subscription with a new friendly name

```powershell
PS C:\>$subscription | Set-PCSubscription -TenantId $customer.id -FriendlyName 'New friendly name'
```

### EXAMPLE 2

Update subscription seats (license based only)

Find the tenant information about the customer named Wingtip Toys

```powershell
PS C:\>$customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Find the the customer subscription

```powershell
PS C:\>$subscription = Get-PCSubscription -TenantId $customer.id | Where-Object {$_.FriendlyName -eq 'Office 365 Enterprise E1'}
```

Update the license quantity for the specified subscription

```powershell
PS C:\>$subscription | Set-PCSubscription -TenantId $customer.id -quantity 100
```

### EXAMPLE 3

Change the subscription auto renewal

Find the tenant information about the customer named Wingtip Toys

```powershell
PS C:\>$customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Find the the customer subscription

```powershell
PS C:\>$subscription = Get-PCSubscription -TenantId $customer.id | Where-Object {$_.FriendlyName -eq 'Office 365 Enterprise E1'}
```

Modify the AutoRenew option for the subscription

```powershell
PS C:\>$subscription | Set-PCSubscription -TenantId $customer.id -AutoRenew disabled
```

### EXAMPLE 4

Suspend a subscription

Find the tenant information about the customer named Wingtip Toys

```powershell
PS C:\>$customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Find the the customer subscription

```powershell
PS C:\>$subscription = Get-PCSubscription -TenantId $customer.id | Where-Object {$_.FriendlyName -eq 'Office 365 Enterprise E1'}
```

Suspend the subscription

```powershell
PS C:\>$subscription | Set-PCSubscription -TenantId $customer.id -Status suspended
```

### EXAMPLE 5

Activate a subscription

Find the tenant information about the customer named Wingtip Toys

```powershell
PS C:\>$customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}
```

Find the the customer subscription

```powershell
PS C:\>$subscription = Get-PCSubscription -TenantId $customer.id | Where-Object {$_.FriendlyName -eq 'Office 365 Enterprise E1'}
$subscription | Set-PCSubscription -TenantId $customer.id -Status active
```
