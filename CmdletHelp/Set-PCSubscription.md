# Set-PCSubscription #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get a customer subscription ##

```powershell
    $subscription = Get-PCSubscription -tenantId $customer.id -subscriptionid '<subscription id GUID>'
```

## Update subscription friendly name ##

```powershell
    $subscription | Set-PCSubscription -tenantId $customer.id -friendlyName '<friendly name>'
```

## Update subscription seats (license based only) ##

```powershell
    $subscription | Set-PCSubscription -tenantId $customer.id -quantity <seats number>
```

## Change subscription auto renewal ##

```powershell
    $subscription | Set-PCSubscription -tenantId $customer.id -AutoRenewEnabled disabled
```

## Suspend a subscription ##

```powershell
    $subscription | Set-PCSubscription -tenantId $customer.id -status suspended
```

## Activate a subscription ##

```powershell
    $subscription | Set-PCSubscription -tenantId $customer.id -status active
```
