# Set-PCSubscription #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get a customer subscription ##

```powershell
    $subscription = Get-PCSubscription -tenantid $customer.id -subscriptionid '<subscription id GUID>'
```

## Update subscription friendly name ##

```powershell
    $subscription | Set-PCSubscription -tenantid $customer.id -friendlyName '<friendly name>'
```

## Update subscription seats (license based only) ##

```powershell
    $subscription | Set-PCSubscription -tenantid $customer.id -quantity <seats number>
```

## Change subscription auto renewal ##

```powershell
    $subscription | Set-PCSubscription -tenantid $customer.id -AutoRenewEnabled disabled
```

## Suspend a subscription ##

```powershell
    $subscription | Set-PCSubscription -tenantid $customer.id -status suspended
```

## Activate a subscription ##

```powershell
    $subscription | Set-PCSubscription -tenantid $customer.id -status active
```
