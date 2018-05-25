# Set-PCCustomerBillingProfile #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customer Billing Profile ##

```powershell
    $customerBillingProfile = Get-PCCustomerBillingProfile -tenantId $customer.id
```

## Set customer Billing Profile ##

```powershell
    $customerBillingProfile.firstName = '<first name>'
    $customerBillingProfile.lastName = '<last name>'
    $customerBillingProfile.email = '<email>'
    Set-PCCustomerBillingProfile -tenantId $customer.id -billingprofile $customerBillingProfile
```
