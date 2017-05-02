# Partner Center PowerShell Module #

## Test-PartnerCenterAddress ##

**Test the country rules for an address**

    $address = New-PartnerCenterAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -country 'two digits country code' -region '<string>'

    Test-PartnerCenterAddress -Address <DefaultAddress> 

or

    Test-PartnerCenterAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -country 'two digits country code' -region '<string>'