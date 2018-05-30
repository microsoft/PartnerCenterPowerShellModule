@{
# Script module or binary module file associated with this manifest
RootModule = 'PartnerCenterModule.psm1'

# Version number of this module.
ModuleVersion = '0.10.0.0'

# ID used to uniquely identify this module
GUID = '4a0bfb55-926c-4c31-8d05-50813b31c712'

# Author of this module
Author = 'Microsoft Corporation'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = 'Microsoft Corporation. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Partner Center Powershell Module (preview)'

# Script files (.ps1) that are run in the caller's environment prior to importing this module

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess

# Functions to export from this module
FunctionsToExport = @('Add-PCAuthentication',
                    'Add-PCCustomerRoleMember',
                    'Get-PCAddressRulesByMarket',
                    'Get-PCAuditRecord',
                    'Get-PCAzureRateCard',
                    'Get-PCAzureResourceMonthlyUsageRecord',
                    'Get-PCBillingProfile',
                    'Get-PCCustomer',
                    'Get-PCCustomerBillingProfile',
                    'Get-PCCustomerCompanyProfile',
                    'Get-PCCustomerLicenseDeployment',
                    'Get-PCCustomerLicenseUsage',
                    'Get-PCCustomerServiceCostSummary',
                    'Get-PCCustomerUsageSummary',
                    'Get-PCCustomerUser',
                    'Get-PCCustomerUserRole',
                    'Get-PCCustomerRoleMember',
                    'Get-PCCustomerRole',
                    'Get-PCCustomerRelationship',
                    'Get-PCDomainAvailability',
                    'Get-PCInvoice',
                    'Get-PCInvoiceLineItem',
                    'Get-PCLegalBusinessProfile',
                    'Get-PCLicenseDeployment',
                    'Get-PCLicenseUsage',
                    'Get-PCManagedService',
                    'Get-PCMpnProfile',
                    'Get-PCOffer',
                    'Get-PCOfferCategoriesByMarket',
                    'Get-PCOrder',
                    'Get-PCOrganizationProfile',
                    'Get-PCSAToken',
                    'Get-PCSpendingBudget',
                    'Get-PCSR',
                    'Get-PCSRTopic',
                    'Get-PCSubscribedSKU',
                    'Get-PCSubscription',
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
                    'Set-PCLegalBusinessProfile',
                    'Set-PCOrganizationProfile',
                    'Get-PCIndirectReseller',
                    'Get-PCResellerCustomer',
                    'Set-PCSpendingBudget',
                    'Set-PCSR',
                    'Set-PCSubscription',
                    'Set-PCSupportProfile',
                    'Test-PCAddress'
                    )

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'CSP','PartnerCenter','Azure','Office','Customer','Subscription'

        # A URL to the license for this module.
        LicenseUri = 'https://raw.githubusercontent.com/Microsoft/PartnerCenterPowerShellModule/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Microsoft/PartnerCenterPowerShellModule'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '* Added non-plural cmdlets names to comply with PowerShell standards'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'http://aka.ms/PartnerCenterModule'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
#DefaultCommandPrefix = ''
}