# Test-PCAddress #

## Test the Country rules for an address ##

```powershell
    $address = New-PCAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -Country 'two digits Country code' -region '<string>'

    Test-PCAddress -Address <DefaultAddress>
```

or

```powershell
    Test-PCAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -Country 'two digits Country code' -region '<string>'
```
