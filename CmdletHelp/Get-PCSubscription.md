# Get-PCSubscription #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get all customer subscriptions ##

```powershell
    Get-PCSubscription -tenantId $customer.id -all
```

## Get a customer subscription ##

```powershell
    Get-PCSubscription -tenantId $customer.id -subscriptionid '<subscription id GUID>'
```

## Get all customer subscriptions from an order ##

```powershell
    Get-PCSubscription -tenantId $customer.id -orderId '<order id GUID>'
```

## Get all customer subscriptions from a reseller (available only for Distributor CSP Account) ##

```powershell
    Get-PCSubscription -tenantId $customer.id -partnerid '<MPNID>'
```
