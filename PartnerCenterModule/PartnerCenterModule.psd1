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
ModuleVersion = '0.9.0.2'

# ID used to uniquely identify this module
GUID = '4a0bfb55-926c-4c31-8d05-50813b31c712'

# Author
Author = "Microsoft Corporation"

# Company
CompanyName = "Microsoft Corporation"

# Copyright
Copyright = "Copyright (c) 2017 Microsoft Corporation. Licensed under MIT license."

# Description of the functionality provided by this module
Description = 'Partner Center Powershell Module (preview)'

# Script files (.ps1) that are run in the caller's environment prior to importing this module
ScriptsToProcess = @("PartnerCenterModule.ps1")

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('src\PartnerCenterAnalytics.psm1',
                'src\PartnerCenterAuthentication.psm1',
                'src\PartnerCenterCustomer.psm1',
                'src\PartnerCenterDirectory.psm1',
                'src\PartnerCenterInvoice.psm1',
                'src\PartnerCenterOffer.psm1',
                'src\PartnerCenterOrder.psm1',
                'src\PartnerCenterProfiles.psm1',
                'src\PartnerCenterServiceRequest.psm1',
                'src\PartnerCenterSubscription.psm1',
                'src\PartnerCenterTelemetry.psm1',
                'src\PartnerCenterUsage.psm1',
                'src\PartnerCenterPartner.psm1',
                'src\PartnerCenterUser.psm1')

# Functions to export from this module
FunctionsToExport = @('Add-Authentication',
                    'Add-CustomerRoleMember',
                    'Get-AddressRulesByMarket',
                    'Get-AuditRecords',
                    'Get-AzureRateCard',
                    'Get-AzureResourceMonthlyUsageRecords',
                    'Get-BillingProfile',
                    'Get-Customer',
                    'Get-CustomerBillingProfile',
                    'Get-CustomerCompanyProfile',
                    'Get-CustomerLicensesDeployment',
                    'Get-CustomerLicensesUsage',
                    'Get-CustomerServiceCostSummary',
                    'Get-CustomerUsageSummary',
                    'Get-CustomerUser',
                    'Get-CustomerUserRole',
                    'Get-CustomerRoleMember',
                    'Get-CustomerRole',
                    'Get-CustomerRelationships',
                    'Get-DomainAvailability',
                    'Get-GraphUser',
                    'Get-GraphUsers',
                    'Get-Invoice',
                    'Get-InvoiceLineItems',
                    'Get-LegalBusinessProfile',
                    'Get-LicensesDeployment',
                    'Get-LicensesUsage',
                    'Get-ManagedServices',
                    'Get-MpnProfile',
                    'Get-Offer',
                    'Get-OfferCategoriesByMarket',
                    'Get-Order',
                    'Get-OrganizationProfile',
                    'Get-SAToken',
                    'Get-SpendingBudget',
                    'Get-SR',
                    'Get-SRTopics',
                    'Get-SubscribedSKUs',
                    'Get-Subscription',
                    'Get-AzureResourceMonthlyUsageRecords',
                    'Get-SupportProfile',
                    'Get-Usage',
                    'New-Address',
                    'New-Customer',
                    'New-CustomerBillingProfile',
                    'New-CustomerCompanyProfile',
                    'New-CustomerDefaultAddress',
                    'New-CustomerUser',
                    'New-Order',
                    'New-OrderLineItem',
                    'New-RelationshipRequest',
                    'New-SAToken',
                    'New-SR',
                    'Remove-Customer',
                    'Remove-CustomerUser',
                    'Remove-CustomerRoleMember',
                    'Restore-CustomerUser',
                    'Select-Customer',
                    'Set-ModuleTelemetry',
                    'Get-ModuleTelemetry'
                    'Set-BillingProfile',
                    'Set-CustomerBillingProfile',
                    'Set-CustomerUser',
                    'Set-GraphUserPassword',
                    'Set-LegalBusinessProfile',
                    'Set-OrganizationProfile',
                    'Get-IndirectResellers',
                    'Get-ResellerCustomers',
                    'Set-SpendingBudget',
                    'Set-SR',
                    'Set-Subscription',
                    'Set-SupportProfile',
                    'Test-Address'
                    )



# HelpInfo URI of this module
HelpInfoURI = 'http://aka.ms/PartnerCenterPowerShellModule'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
DefaultCommandPrefix = 'PartnerCenter'

}