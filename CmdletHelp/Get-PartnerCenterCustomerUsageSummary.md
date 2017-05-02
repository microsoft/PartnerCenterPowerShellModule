# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterCustomerUsageSummary ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get usage summary for all of a customer's subscriptions**

    Get-PartnerCenterCustomerUsageSummary -tenantid $customer.id
