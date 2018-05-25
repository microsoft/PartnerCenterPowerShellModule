# Get-PCCustomerUsageSummary #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantId '<tenant id GUID>'
```

## Get usage summary for all of a customer's subscriptions ##

```powershell
    Get-PCCustomerUsageSummary -tenantId $customer.id
```
