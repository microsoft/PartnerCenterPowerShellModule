# Get-PCSubscription #

## Get a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get all customer subscriptions ##

```powershell
    Get-PCSubscription -tenantid $customer.id -all
```

## Get a customer subscription ##

```powershell
    Get-PCSubscription -tenantid $customer.id -subscriptionid '<subscription id GUID>'
```

## Get all customer subscriptions from an order ##

```powershell
    Get-PCSubscription -tenantid $customer.id -orderid '<order id GUID>'
```

## Get all customer subscriptions from a reseller (available only for Distributor CSP Account) ##

```powershell
    Get-PCSubscription -tenantid $customer.id -partnerid '<MPNID>'
```
