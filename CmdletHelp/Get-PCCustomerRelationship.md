# Get-PCCustomerRelationship (indirect model only) #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get all customer subscriptions ##

```powershell
    Get-PCCustomerRelationship -tenantId $customer.id
```
