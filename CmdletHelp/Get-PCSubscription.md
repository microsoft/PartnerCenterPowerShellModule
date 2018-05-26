# Get-PCSubscription #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get all customer subscriptions ##

```powershell
    Get-PCSubscription -TenantId $customer.id -all
```

## Get a customer subscription ##

```powershell
    Get-PCSubscription -TenantId $customer.id -subscriptionid '<subscription id GUID>'
```

## Get all customer subscriptions from an order ##

```powershell
    Get-PCSubscription -TenantId $customer.id -OrderId '<order id GUID>'
```

## Get all customer subscriptions from a reseller (available only for Distributor CSP Account) ##

```powershell
    Get-PCSubscription -TenantId $customer.id -partnerid '<MPNID>'
```
