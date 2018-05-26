# Get-PCCustomerRelationship (indirect model only) #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get all customer subscriptions ##

```powershell
    Get-PCCustomerRelationship -TenantId $customer.id
```
