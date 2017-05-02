# Partner Center PowerShell Module #

## Get-PartnerCenterManagedServices ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get all managed services for customer**

    Get-PartnerCenterManagedServices -tenantid $customer.id