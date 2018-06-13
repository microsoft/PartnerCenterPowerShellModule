<#
.SYNOPSIS
Tests all of the cmdlets in the PartnerCenterModule.

.DESCRIPTION
This will test all of the cmdlets in the module.

.PARAMETER saToken 
Specifies an authentication token with your Partner Center credentials.

.EXAMPLE
Return a list of assigned licenses for the partner.

Test-PCCmdlets.ps1

.NOTES
You need to have a authentication credential already established before running this cmdlet.

#>

<#[CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][Securestring]$credentials,
        [Parameter(Mandatory = $false)][string]$cspDomain,
        [Parameter(Mandatory = $false)][Securestring]$cspClientSecret,
        [Parameter(Mandatory = $false)][string]$cspAppId,
        [Parameter(Mandatory = $false)][string]$cspWebAppId
    )
#>

## Get Verbs
# Get-PCCustomerTests

Get-PCCustomer -Verbose | Format-Table -AutoSize
Get-PCCustomer -all -Verbose | Format-Table -AutoSize

$tenant = Get-PCCustomer | Select-Object -Last 1
Get-PCCustomer -tenantid $tenant.id -Verbose | Format-Table -AutoSize

Get-PCCustomer -startswith p -ResultSize 2 -Verbose

# Get-PCAddressRulesByMarket
Get-PCAddressRulesByMarket -CountryId US -Verbose

# Test an invalid country code
Get-PCAddressRulesByMarket -countryid ZZZ -Verbose

# Get-PCAuditRecord
Get-PCAuditRecord -startDate 2018-05-10 -Verbose

#Get-PCAzureRateCard
Get-PCAzureRateCard -Currency USD -Region US -Verbose

Get-PCAzureResourceMonthlyUsageRecord
Get-PCBillingProfile

Get-PCCustomerBillingProfile
Get-PCCustomerCompanyProfile
Get-PCCustomerLicenseDeployment
Get-PCCustomerLicenseUsage
Get-PCCustomerServiceCostSummary
Get-PCCustomerUsageSummary
Get-PCCustomerUser
Get-PCCustomerUserRole
Get-PCCustomerRoleMember
Get-PCCustomerRole
Get-PCCustomerRelationship
Get-PCDomainAvailability
Get-PCInvoice
Get-PCInvoiceLineItem
Get-PCLegalBusinessProfile
Get-PCLicenseDeployment
Get-PCLicenseUsage
Get-PCManagedService
Get-PCMpnProfile
Get-PCOffer
Get-PCOfferCategoriesByMarket
Get-PCOrder
Get-PCOrganizationProfile
Get-PCSaToken
Get-PCSpendingBudget
Get-PCSR
Get-PCSRTopic
Get-PCSubscribedSKU
Get-PCSubscription
Get-PCSupportProfile
Get-PCUsage
Get-PCUsage2
Get-PCManagedServices
Get-PCSRTopics
Get-PCIndirectReseller
Get-PCResellerCustomer

# Deprecated and no longer tested Get- cmdlets
<#
Get-PCCustomerLicensesDeployment
Get-PCCustomerLicensesUsage
Get-PCInvoiceLineItems
Get-PCResellerCustomers
Get-PCAzureResourceMonthlyUsageRecords
Get-PCCustomerRelationships
Get-PCIndirectResellers
Get-PCLicensesUsage
Get-PCLicensesDeployment
Get-PCAuditRecords
Get-PCSubscribedSKUs
#>

# This should be used as part of other cmdlets.
#Select-PCCustomer

# Add tests for these only in the integration sandbox
<#
New-PCAddress

New-PCCustomerBillingProfile
New-PCCustomerCompanyProfile
New-PCCustomerDefaultAddress

New-PCOrder
New-PCOrderLineItem
New-PCRelationshipRequest
New-PCSaToken
New-PCSR

New-PCCustomer
Remove-PCCustomer

New-PCCustomerUser
Remove-PCCustomerUser

Add-PCCustomerRoleMember
Remove-PCCustomerRoleMember

Restore-PCCustomerUser

Set-PCBillingProfile
Set-PCCustomerBillingProfile
Set-PCCustomerUser
Set-PCLegalBusinessProfile
Set-PCOrganizationProfile
Set-PCSpendingBudget
Set-PCSR
Set-PCSubscription
Set-PCSupportProfile

Test-PCAddress
#>