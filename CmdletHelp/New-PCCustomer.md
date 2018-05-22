# New-PCCustomer #

## Create a new customer ##

```powershell
    $newDefaultAddress = New-PCCustomerDefaultAddress -Country '<country code>' -Region '<region>' -City '<city>' -State '<state>' -AddressLine1 '<address1>' -PostalCode '<postal code>' -FirstName '<first name>' -LastName '<last name>' -PhoneNumber '<phone number>'

    $newBillingProfile = New-PCCustomerBillingProfile -FirstName '<first name>' -LastName '<last name>' -Email '<email>' -Culture '<ex: en.us>' -Language '<ex: en>' -CompanyName '<company name>' -DefaultAddress $newDefaultAddress

    $newCompanyProfile = New-PCCustomerCompanyProfile -Domain '<company name>.onmicrosoft.com'

    $newCustomer = New-PCCustomer -BillingProfile $newBillingProfile -CompanyProfile $newCompanyProfile
```
