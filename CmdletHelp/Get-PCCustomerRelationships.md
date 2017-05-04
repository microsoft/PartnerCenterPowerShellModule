# Partner Center PowerShell Module (preview) #

## Get-PCCustomerRelationships (indirect model only)##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get all customer subscriptions**

    Get-PCCustomerRelationships -tenantid $customer.id


