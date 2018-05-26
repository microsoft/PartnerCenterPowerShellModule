# Get-PCOrder #

## Select a customer ##

```powershell
    Select-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer orders ##

```powershell
    Get-PCOrder -TenantId $customer.id
```

## Get a customer order ##

```powershell
    Get-PCOrder -TenantId $customer.id -OrderId '<order id guid>'
```
