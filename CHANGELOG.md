# Partner Center PowerShell Module Changelog

## 0.9.0.22 (2018-05-24)

### Features

* None

### Bug Fixes

* Removed inoperable export of Set-PCGraphUserPassword
* Made the countryId parameter mandatory for the Get-PCAddressRulesByMarket, otherwise an error was thrown.
* Removed the requirement to specify -All for Get-PCCustomer when you want to list all of the customers. However, to keep from breaking older scripts, you can still use it, however it generates a warning message.
* Added validation for the -currency and -region parameters on Get-PCAzureRatecard
* Added regex validation for the -startdate and -enddate parameters of Get-PCAuditRecord

### Breaking Changes

* For Get-PCUsage and Get-PCUsage2 the -startTime, -endTime, -showDetails parameters were renamed -startTime, -endTime, and -showDetails respectively.