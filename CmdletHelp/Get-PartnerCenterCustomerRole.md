# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterCustomerRole ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer roles**

    Get-PartnerCenterCustomerRole -tenantid $customer.id
