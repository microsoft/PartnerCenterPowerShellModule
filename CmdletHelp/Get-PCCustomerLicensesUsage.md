# Partner Center PowerShell Module (preview) #

## Get-PCCustomerLicensesUsage ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer licenses usage information**

    Get-PCCustomerLicensesUsage -tenantid $customer.id


