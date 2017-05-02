# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterCustomerLicensesDeployment ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer licenses deployment information**

    Get-PartnerCenterCustomerLicensesDeployment -tenantid $customer.id
