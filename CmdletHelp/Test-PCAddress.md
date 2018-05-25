# Test-PCAddress #

## Test the country rules for an address ##

```powershell
    $address = New-PCAddress -addressLine1 '<string>' -addressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -country 'two digits country code' -region '<string>'

    Test-PCAddress -Address <DefaultAddress>
```

or

```powershell
    Test-PCAddress -addressLine1 '<string>' -addressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -country 'two digits country code' -region '<string>'
```
