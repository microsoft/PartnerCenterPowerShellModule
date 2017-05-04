# Partner Center PowerShell Module (preview) #

## Get-PCSubscribedSKUs ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get a list of available licenses**

    Get-PCSubscribedSKUs -tenantid $customer.id


