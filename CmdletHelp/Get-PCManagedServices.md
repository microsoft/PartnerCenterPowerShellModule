# Partner Center PowerShell Module (preview) #

## Get-PCManagedServices ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get all managed services for customer**

    Get-PCManagedServices -tenantid $customer.id

