# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterCustomerRelationships (indirect model only)##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get all customer subscriptions**

    Get-PartnerCenterCustomerRelationships -tenantid $customer.id
