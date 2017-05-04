# Partner Center PowerShell Module (preview) #

## Test-PCAddress ##

**Test the country rules for an address**

    $address = New-PCAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -country 'two digits country code' -region '<string>'

    Test-PCAddress -Address <DefaultAddress> 

or

    Test-PCAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -country 'two digits country code' -region '<string>'

