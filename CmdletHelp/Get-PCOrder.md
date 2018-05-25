# Get-PCOrder #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer orders ##

```powershell
    Get-PCOrder -tenantId $customer.id
```

## Get a customer order ##

```powershell
    Get-PCOrder -tenantId $customer.id -orderId '<order id guid>'
```
