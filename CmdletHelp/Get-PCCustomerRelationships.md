# Get-PCCustomerRelationships (indirect model only) #

## Deprecated: Please use Get-PCCustomerRelationship instead ##

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get all customer subscriptions ##

```powershell
    Get-PCCustomerRelationships -TenantId $customer.id
```
