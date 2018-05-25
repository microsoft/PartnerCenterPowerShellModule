# Get-PCCustomer #

## Get all customers ##

```powershell
    Get-PCCustomer -all
```

## Get a customer by ID ##

```powershell
    $customer = Get-PCCustomer -tenantId '<tenant id GUID>'
```

## Get customers by company name ##

```powershell
    Get-PCCustomer -startswith '<company name>'
```
