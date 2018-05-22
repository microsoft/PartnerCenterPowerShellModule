# Get-PCCustomerRelationship (indirect model only) #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get all customer subscriptions ##

```powershell
    Get-PCCustomerRelationship -tenantid $customer.id
```
