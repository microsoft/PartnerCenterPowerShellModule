# Get-PCCustomerUsageSummary #

## Select a customer ##

```powershell
    Select-PCCustomer -TenantId '<tenant id GUID>'
```

## Get usage summary for all of a customer's subscriptions ##

```powershell
    Get-PCCustomerUsageSummary -TenantId $customer.id
```
