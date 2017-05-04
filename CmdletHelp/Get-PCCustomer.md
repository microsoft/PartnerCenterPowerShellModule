# Partner Center PowerShell Module (preview) #

## Get-PCCustomer ##


**Get all customers**

    Get-PCCustomer

**Get a customer by ID**

    $customer = Get-PCCustomer -tenantid '<tenant id GUID>'

**Get customers by company name**

    Get-PCCustomer -startswith '<company name>'


