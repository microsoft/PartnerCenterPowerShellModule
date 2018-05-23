# Get-PCOrder #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer orders ##

```powershell
    Get-PCOrder -tenantid $customer.id
```

## Get a customer order ##

```powershell
    Get-PCOrder -tenantid $customer.id -orderid '<order id guid>'
```
