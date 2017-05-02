# Partner Center PowerShell Module (preview) #

## Set-PartnerCenterCustomerBillingProfile ##

**Get a customer**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customer Billing Profile**

    $customerBillingProfile = Get-PartnerCenterCustomerBillingProfile -tenantid $customer.id

**Set customer Billing Profile**
    $customerBillingProfile.firstName = '<first name>'
    $customerBillingProfile.lastName = '<last name>'
    $customerBillingProfile.email = '<email>'
    Set-PartnerCenterCustomerBillingProfile -tenantid $customer.id -billingprofile $customerBillingProfile
