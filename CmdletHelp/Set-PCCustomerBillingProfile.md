# Set-PCCustomerBillingProfile #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

## Get customer Billing Profile ##

```powershell
    $customerBillingProfile = Get-PCCustomerBillingProfile -tenantid $customer.id
```

## Set customer Billing Profile ##

```powershell
    $customerBillingProfile.firstName = '<first name>'
    $customerBillingProfile.lastName = '<last name>'
    $customerBillingProfile.email = '<email>'
    Set-PCCustomerBillingProfile -tenantid $customer.id -billingprofile $customerBillingProfile
```
