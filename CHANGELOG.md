# Partner Center PowerShell Module Changelog

## 0.9.0.22 (2018-05-24)

### Features

* Add application id as part of the REST request.

### Bug Fixes

* Removed inoperable export of Set-PCGraphUserPassword
* Made the CountryId parameter mandatory for the Get-PCAddressRulesByMarket, otherwise an error was thrown.

* Added validation for the -currency and -region parameters on Get-PCAzureRatecard
* Added regex validation for the -startdate and -enddate parameters of Get-PCAuditRecord

### Breaking Changes

* Renamed -startTime, -endTime, -showDetails parameters to -startTime, -endTime, and -showDetails respectively for the following cmdlets:
  * Get-PCUsage
  * Get-PCUsage2
* Renamed the -Size parameter to -Limit on the following cmdlets:
  * Get-PCUsage
  * Get-PCUsage2
* Removed the requirement to specify -All for the following cmdlets:
  * Get-PCCustomer
  * Get-PCSR
* Removed the following cmdlets, instead use the new cmdlet name:
  * Get-PCCustomerLicensesDeployment use Get-PCCustomerLicenseDeployment
  * Get-PCCustomerLicensesUsage use Get-PCCustomerLicenseUsage
  * Get-PCInvoiceLineItems use Get-PCInvoiceLineItem
  * Get-PCResellerCustomers use Get-PCResellerCustomer
  * Get-PCAzureResourceMonthlyUsageRecords use Get-PCAzureResourceMonthlyUsageRecord
  * Get-PCCustomerRelationships use Get-PCCustomerRelationship
  * Get-PCIndirectResellers use Get-PCIndirectReseller
  * Get-PCLicensesUsage use Get-PCLicenseUsage
  * Get-PCLicensesDeployment use Get-PCLicenseDeployment
  * Get-PCAuditRecords use Get-PCAuditRecord
  * Get-PCSubscribedSKUs use Get-PCSubscribedSKU