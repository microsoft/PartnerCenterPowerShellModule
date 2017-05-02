# Partner Center PowerShell Module #

## Get-PartnerCenterSubscribedSKUs ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get a list of available licenses**

    Get-PartnerCenterSubscribedSKUs -tenantid $customer.id

