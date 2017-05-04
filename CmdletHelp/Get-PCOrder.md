# Partner Center PowerShell Module (preview) #

## Get-PCOrder ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer orders**

    Get-PCOrder -tenantid $customer.id

**Get a customer order**

    Get-PCOrder -tenantid $customer.id -orderid '<order id guid>'

