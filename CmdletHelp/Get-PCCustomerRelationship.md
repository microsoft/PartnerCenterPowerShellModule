# Partner Center PowerShell Module (preview) #

## Get-PCCustomerRelationship (indirect model only) ##


### Get a customer ###

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

### Get all customer subscriptions ###

```powershell
    Get-PCCustomerRelationship -tenantid $customer.id
```
