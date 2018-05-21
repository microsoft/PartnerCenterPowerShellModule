# Partner Center PowerShell Module (preview) #

## Get-PCCustomerCompanyProfile ##

**Get a customer**

```powershell
    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'
```

**Get customer Company Profile**

```powershell
    Get-PCCustomerCompanyProfile -tenantid $customer.id
```
