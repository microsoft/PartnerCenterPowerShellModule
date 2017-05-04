# Partner Center PowerShell Module (preview) #

## Get-PCCustomerLicensesDeployment ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer licenses deployment information**

    Get-PCCustomerLicensesDeployment -tenantid $customer.id


