# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterCustomerLicensesUsage ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer licenses usage information**

    Get-PartnerCenterCustomerLicensesUsage -tenantid $customer.id
