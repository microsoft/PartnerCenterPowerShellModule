# Partner Center PowerShell Module #

## Remove-PartnerCenterCustomer ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Delete a customer (integration sandbox only)**

    Remove-PartnerCenterCustomer -tenantid $customer.id
