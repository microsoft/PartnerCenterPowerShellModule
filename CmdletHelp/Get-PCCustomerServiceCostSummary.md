# Partner Center PowerShell Module (preview) #

## Get-PCCustomerServiceCostSummary ##

### Select a customer ###

```powershell
    Select-PCCustomer -tenantid '<tenant id GUID>'
```

### Get customer Service Cost Summary ###

```powershell
   Get-PCCustomerServiceCostSummary -BillingPeriod  MostRecent
```

   > Other BillingPeriod type will be available in a future release
