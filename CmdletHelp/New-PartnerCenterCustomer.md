# Partner Center PowerShell Module (preview) #

## New-PartnerCenterCustomer ##

**Create new customer**

    $newDefaultAddress = New-PartnerCenterCustomerDefaultAddress -Country '<country code>' -Region '<region>' -City '<city>' -State '<state>' -AddressLine1 '<address1>' -PostalCode <postal code> -FirstName '<first name>' -LastName '<last name>' -PhoneNumber <phone number>

    $newBillingProfile = New-PartnerCenterCustomerBillingProfile -Email '<email>' -Culture '<ex: en.us>' -Language '<ex: en>' -CompanyName '<company name>' -DefaultAddress $newDefaultAddress

    $newCompanyProfile = New-PartnerCenterCustomerCompanyProfile -Domain '<company name>.onmicrosoft.com'

    $newCustomer = New-PartnerCenterCustomer -BillingProfile $newBillingProfile -CompanyProfile $newCompanyProfile
