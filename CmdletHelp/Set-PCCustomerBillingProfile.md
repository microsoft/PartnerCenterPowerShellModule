# Set-PCCustomerBillingProfile #

## Specify a customer ##

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

## Get customer Billing Profile ##

```powershell
    $customerBillingProfile = Get-PCCustomerBillingProfile -TenantId $customer.id
```

## Set customer Billing Profile ##

```powershell
    $customerBillingProfile.FirstName = '<first name>'
    $customerBillingProfile.LastName = '<last name>'
    $customerBillingProfile.Email = '<Email>'
    Set-PCCustomerBillingProfile -TenantId $customer.id -billingprofile $customerBillingProfile
```
