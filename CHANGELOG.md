# Partner Center PowerShell Module Changelog

## 0.9.0.21 (2018-05-22)

### Features

* Removed telemetry functions
* Added non-plural cmdlets names to comply with PowerShell standards
  * Get-PCAuditRecord
  * Get-PCCustomerLicenseDeployment
  * Get-PCCustomerLicenseUsage
  * Get-PCCustomerRelationship
  * Get-PCIndirectReseller
  * Get-PCLicenseUsage
  * Get-PCLicenseDeployment
  * Get-PCManagedSerice
  * Get-PCResellerCustomer
  * Get-PCSRTopic
  * Get-PCSubscribedSKU

### Bug Fixes

* Addressed an issue with the New-PCCustomer cmdlet that was preventing customers currently.
* Addressed an issue where Get-PCOfferCategoriesByMarket did not require the countryId, however the API does require this.

### Breaking Changes

* No breaking changes with this release