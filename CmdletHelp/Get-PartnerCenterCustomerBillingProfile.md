# Partner Center PowerShell Module #

## Get-PartnerCenterCustomerBillingProfile ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer Billing Profile**

    Get-PartnerCenterCustomerBillingProfile -tenantid $customer.id
