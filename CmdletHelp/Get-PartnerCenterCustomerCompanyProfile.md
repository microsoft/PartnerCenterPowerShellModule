# Partner Center PowerShell Module #

## Get-PartnerCenterCustomerCompanyProfile ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer Company Profile**

    Get-PartnerCenterCustomerCompanyProfile -tenantid $customer.id
