# Partner Center PowerShell Module (preview) #

## Get-PCCustomerRelationships (indirect model only) ##

Deprecated: Please use Get-PCCustomerRelationship instead.

### Get a customer ###

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

### Get all customer subscriptions ###

```powershell
    Get-PCCustomerRelationships -tenantid $customer.id
```
