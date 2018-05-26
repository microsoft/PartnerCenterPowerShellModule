# New-PCCustomer #

## Create a new customer ##

```powershell
    $newDefaultAddress = New-PCCustomerDefaultAddress -Country '<Country code>' -Region '<region>' -City '<City>' -State '<State>' -AddressLine1 '<address1>' -PostalCode '<postal code>' -FirstName '<first name>' -LastName '<last name>' -PhoneNumber '<phone number>'

    $newBillingProfile = New-PCCustomerBillingProfile -FirstName '<first name>' -LastName '<last name>' -Email '<Email>' -Culture '<ex: en.us>' -Language '<ex: en>' -CompanyName '<company name>' -DefaultAddress $newDefaultAddress

    $newCompanyProfile = New-PCCustomerCompanyProfile -Domain '<company name>.onmicrosoft.com'

    $newCustomer = New-PCCustomer -BillingProfile $newBillingProfile -CompanyProfile $newCompanyProfile
```
