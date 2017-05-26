# Partner Center PowerShell Module (preview) #

## Set-PCCustomerBillingProfile ##

**Get a customer**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customer Billing Profile**

    $customerBillingProfile = Get-PCCustomerBillingProfile -tenantid $customer.id

**Set customer Billing Profile**
   
    $customerBillingProfile.firstName = '<first name>'
    $customerBillingProfile.lastName = '<last name>'
    $customerBillingProfile.email = '<email>'
    Set-PCCustomerBillingProfile -tenantid $customer.id -billingprofile $customerBillingProfile

