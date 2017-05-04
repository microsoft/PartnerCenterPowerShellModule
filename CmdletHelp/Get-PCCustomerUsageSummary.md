# Partner Center PowerShell Module (preview) #

## Get-PCCustomerUsageSummary ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get usage summary for all of a customer's subscriptions**

    Get-PCCustomerUsageSummary -tenantid $customer.id

