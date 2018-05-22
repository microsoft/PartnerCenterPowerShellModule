#
# Module manifest for module 'PartnerCenterModule'
# https://msdn.microsoft.com/en-us/library/dd878337(v=vs.85).aspx
#
<#
    © 2017 Microsoft Corporation. All rights reserved. This sample code is not supported under any Microsoft standard support program or service. 
    This sample code is provided AS IS without warranty of any kind. Microsoft disclaims all implied warranties including, without limitation, 
    any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance 
    of the sample code and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, 
    production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business 
    profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the 
    sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
#>

@{

# Script module or binary module file associated with this manifest
RootModule = 'PartnerCenterModule.psm1'

# Version number of this module.
ModuleVersion = '0.9.0.21'

# ID used to uniquely identify this module
GUID = '4a0bfb55-926c-4c31-8d05-50813b31c712'

# Author
Author = "Microsoft Corporation"

# Company
CompanyName = "Microsoft Corporation"

# Copyright
Copyright = "Copyright (c) 2018 Microsoft Corporation. Licensed under MIT license."

# Description of the functionality provided by this module
Description = 'Partner Center Powershell Module (preview)'

# Script files (.ps1) that are run in the caller's environment prior to importing this module

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess

# Functions to export from this module
FunctionsToExport = @('Add-PCAuthentication',
                    'Add-PCCustomerRoleMember',
                    'Get-PCAddressRulesByMarket',
                    'Get-PCAuditRecords',
                    'Get-PCAuditRecord',
                    'Get-PCAzureRateCard',
                    'Get-PCAzureResourceMonthlyUsageRecords',
                    'Get-PCAzureResourceMonthlyUsageRecord',
                    'Get-PCBillingProfile',
                    'Get-PCCustomer',
                    'Get-PCCustomerBillingProfile',
                    'Get-PCCustomerCompanyProfile',
                    'Get-PCCustomerLicensesDeployment',
                    'Get-PCCustomerLicensesUsage',
                    'Get-PCCustomerLicenseDeployment',
                    'Get-PCCustomerLicenseUsage',
                    'Get-PCCustomerServiceCostSummary',
                    'Get-PCCustomerUsageSummary',
                    'Get-PCCustomerUser',
                    'Get-PCCustomerUserRole',
                    'Get-PCCustomerRoleMember',
                    'Get-PCCustomerRole',
                    'Get-PCCustomerRelationships',
                    'Get-PCCustomerRelationship',
                    'Get-PCDomainAvailability',
                    'Get-PCGraphUser',
                    'Get-PCGraphUsers',
                    'Get-PCInvoice',
                    'Get-PCInvoiceLineItems',
                    'Get-PCInvoiceLineItem',
                    'Get-PCLegalBusinessProfile',
                    'Get-PCLicensesDeployment',
                    'Get-PCLicenseDeployment',
                    'Get-PCLicenseUsage',
                    'Get-PCLicensesUsage',
                    'Get-PCManagedServices',
                    'Get-PCManagedService',
                    'Get-PCMpnProfile',
                    'Get-PCOffer',
                    'Get-PCOfferCategoriesByMarket',
                    'Get-PCOrder',
                    'Get-PCOrganizationProfile',
                    'Get-PCSAToken',
                    'Get-PCSpendingBudget',
                    'Get-PCSR',
                    'Get-PCSRTopics',
                    'Get-PCSRTopic',
                    'Get-PCSubscribedSKUs',
                    'Get-PCSubscribedSKU',
                    'Get-PCSubscription',
                    'Get-PCAzureResourceMonthlyUsageRecords',
                    'Get-PCAzureResourceMonthlyUsageRecord',
                    'Get-PCSupportProfile',
                    'Get-PCUsage',
                    'Get-PCUsage2',
                    'New-PCAddress',
                    'New-PCCustomer',
                    'New-PCCustomerBillingProfile',
                    'New-PCCustomerCompanyProfile',
                    'New-PCCustomerDefaultAddress',
                    'New-PCCustomerUser',
                    'New-PCOrder',
                    'New-PCOrderLineItem',
                    'New-PCRelationshipRequest',
                    'New-PCSAToken',
                    'New-PCSR',
                    'Remove-PCCustomer',
                    'Remove-PCCustomerUser',
                    'Remove-PCCustomerRoleMember',
                    'Restore-PCCustomerUser',
                    'Select-PCCustomer',
                    'Set-PCBillingProfile',
                    'Set-PCCustomerBillingProfile',
                    'Set-PCCustomerUser',
                    'Set-PCGraphUserPassword',
                    'Set-PCLegalBusinessProfile',
                    'Set-PCOrganizationProfile',
                    'Get-PCIndirectResellers',
                    'Get-PCIndirectReseller',
                    'Get-PCResellerCustomers',
                    'Get-PCResellerCustomer',
                    'Set-PCSpendingBudget',
                    'Set-PCSR',
                    'Set-PCSubscription',
                    'Set-PCSupportProfile',
                    'Test-PCAddress'
                    )



# HelpInfo URI of this module
HelpInfoURI = 'http://aka.ms/PartnerCenterModule'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
#DefaultCommandPrefix = ''

}
