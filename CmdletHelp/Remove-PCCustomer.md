# Partner Center PowerShell Module (preview) #

## Remove-PCCustomer ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Delete a customer (integration sandbox only)**

    Remove-PCCustomer -tenantid $customer.id

