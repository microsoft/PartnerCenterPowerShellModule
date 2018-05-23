# Get-PCCustomerUsageSummary #

## Select a customer ##

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

## Get usage summary for all of a customer's subscriptions ##

```powershell
    Get-PCCustomerUsageSummary -tenantid $customer.id
```
