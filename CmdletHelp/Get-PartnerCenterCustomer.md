# Partner Center PowerShell Module #

## Get-PartnerCenterCustomer ##


**Get all customers**

    Get-PartnerCenterCustomer

**Get a customer by ID**

    $customer = Get-PartnerCenterCustomer -tenantid '<tenant id GUID>'

**Get customers by company name**

    Get-PartnerCenterCustomer -startswith '<company name>'
