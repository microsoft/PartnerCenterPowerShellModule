# Partner Center PowerShell Module Changelog

## 0.10.0.0 (2018-06-13)

### Features

<<<<<<< HEAD
* Added an application id to send as part of the REST request to identify the application traffic.
* Enabled Get-PCUsage to return more than 1000 usage records.
=======
* None
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.

### Bug Fixes

* Removed inoperable export of Set-PCGraphUserPassword
* Made the CountryId parameter mandatory for the Get-PCAddressRulesByMarket, otherwise an error was thrown.
<<<<<<< HEAD
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
=======
* Removed the requirement to specify -All for Get-PCCustomer when you want to list all of the customers. However, to keep from breaking older scripts, you can still use it, however it generates a warning message.
* Added validation for the -currency and -region parameters on Get-PCAzureRatecard
* Added regex validation for the -startdate and -enddate parameters of Get-PCAuditRecord

### Breaking Changes

* For Get-PCUsage and Get-PCUsage2 the -startTime, -endTime, -showDetails parameters were renamed -startTime, -endTime, and -showDetails respectively.
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
