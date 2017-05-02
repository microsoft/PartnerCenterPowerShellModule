# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterOrder ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer orders**

    Get-PartnerCenterOrder -tenantid $customer.id

**Get a customer order**

    Get-PartnerCenterOrder -tenantid $customer.id -orderid '<order id guid>'
