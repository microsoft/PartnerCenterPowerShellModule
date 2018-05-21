# Partner Center PowerShell Module (preview) #

## Get-PCCustomerBillingProfile ##

**Get a customer**

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

**Get customer Billing Profile**

```powershell
    Get-PCCustomerBillingProfile -tenantid $customer.id
```
