# Partner Center PowerShell Module Changelog

## 0.10.0.1 (2018-06-22)

### Features

* None

### Bug Fixes

* Fixed issues with missing locales, countries, and currencies for Get-PCAzureRateCard, Get-PCOffer, Get-PCAddressRulesByMarket, and Get-PCOfferCategoriesByMarket

### Breaking Changes

* None

## 0.10.0.0 (2018-06-13)

### Features

* Added an application id to send as part of the REST request to identify the application traffic.
* Enabled Get-PCUsage to return more than 1000 usage records.

### Bug Fixes

* Removed inoperable export of Set-PCGraphUserPassword
* Made the CountryId parameter mandatory for the Get-PCAddressRulesByMarket, otherwise an error was thrown.
* Fixed an issue where Set-PCLegalBusinessProfile could not update the primary contact information.
* Fixed an issue where Set-PCSupportProfile could not set information, if any of the default properties were missing.

* Added validation for the -Currency and -Region parameters on Get-PCAzureRatecard
* Added regex validation for the -StartDate and -EndDate parameters of Get-PCAuditRecord
* Added regex validation for the -CountryId parameter for all cmdlets.

### Breaking Changes

* Removed the Get-PCUsage2 cmdlet, replaced by Get-PCUsage functionality.
* Renamed -start_time, -end_time, -show_details parameters to -StartTime, -EndTime, and -ShowDetail respectively for the following cmdlets:
  * Get-PCUsage
* Renamed the -Size parameter to -ResultSize on the following cmdlets:
  * Get-PCUsage
* Removed the All parameter from the following cmdlets:
  * Get-PCCustomer
  * Get-PCSR
  * Get-PCSubscription
  * Get-PCCustomerUser
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
* Modified the -AutoRenewEnabled parameter for Set-PCSubscription to be -AutoRenew
* Get-PCCustomerRole, Remove-PCCustomerUser, Set-PCCustomerUser now require the user id to be passed instead of a PowerShell object containing all of the user information. The parameter was also renamed from -User to -UserId to better reflect this change.