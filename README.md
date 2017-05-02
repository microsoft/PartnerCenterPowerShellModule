# Partner Center PowerShell Module (preview) #

## What is ##
Partner Center Powershell Module is the powershell implementation of the Partner Center API available scenarios. You can manage your customers, offers, subscriptions, usage, etc. Objective is to keep this module as close as possible to the Partner Center SDK functionalities. 

## How to install ##
This module is published via [PowerShell Gallery](https://www.powershellgallery.com/) so it can be installed using Install-Module.

    Install-Module -Name PartnerCenterModule

## How to use ##
### Step 1 ###
   Make sure your [App Management is already configured](https://msdn.microsoft.com/library/partnercenter/mt709136.aspx) to enable access to Partner Center API.

### Step 2 ###
Just like with AzureRM powershell module, the first step to start using it is to provide authentication. In Partner Center PowerShell Module you use [Add-PartnerCenterAuthentication](./CmdletHelp/Add-PartnerCenterAuthentication.md) cmdlet. This will set your CSP account authentication context.

**Set user authentication**

    $credentials = Get-Credential '<username@domain>'
    Add-PartnerCenterAuthentication -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -credential $credentials

or 

**Set app authentication**

    Add-PartnerCenterAuthentication -cspappID '<native app id GUID>' -cspDomain '<csp partner domain>' -cspClientSecret '<key code secret>'  

### Ready ###
After this first steps you are ready to start using bellow cmdlet scenarios. (ex: create customers, create subscriptions, etc)

## Partner Center API scenario -> powershell module matrix ##

| Partner Center API Scenario | | CmdLet |
|:-|:-|:-|
| | | |
| **Manage customer accounts** | | |
| Create a customer | | |
| | [Create a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt634668.aspx) | [New-PartnerCenterCustomer](./CmdletHelp/New-PartnerCenterCustomer.md) |
| | [Request a reseller relationship](https://msdn.microsoft.com/en-us/library/partnercenter/mt712736.aspx) | [New-PartnerCenterRelationshipRequest](./CmdletHelp/New-PartnerCenterRelationshipRequest.md) |
| Look up a customer | | |
| | [Get a customer by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt634680.aspx) | [Get-PartnerCenterCustomer](./CmdletHelp/Get-PartnerCenterCustomer.md) |
| | [Get a customer by company name or domain](https://msdn.microsoft.com/en-us/library/partnercenter/mt634681.aspx) | [Get-PartnerCenterCustomer](./CmdletHelp/Get-PartnerCenterCustomer.md) |
| | [Get a list of customers](https://msdn.microsoft.com/en-us/library/partnercenter/mt634685.aspx) | [Get-PartnerCenterCustomer](./CmdletHelp/Get-PartnerCenterCustomer.md) |
| Manage customer orders and subscriptions | | |
| | [Get all of a customer's orders](https://msdn.microsoft.com/en-us/library/partnercenter/mt634671.aspx) | [Get-PartnerCenterOrder](./CmdletHelp/Get-PartnerCenterOrder.md) |
| | [Get all of a customer's subscriptions](https://msdn.microsoft.com/en-us/library/partnercenter/mt634673.aspx) | [Get-PartnerCenterSubscription](./CmdletHelp/Get-PartnerCenterSubscription.md) |
| | [Update the nickname for a subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt634726.aspx) | [Set-PartnerCenterSubscription](./CmdletHelp/Set-PartnerCenterSubscription.md) |
| Manage customer account details | | |
| | [Get a customer's billing profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634670.aspx) | [Get-PartnerCenterCustomerBillingProfile](./CmdletHelp/Get-PartnerCenterCustomerBillingProfile.md) |
| | [Update a customer's billing profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634718.aspx) | [Set-PartnerCenterCustomerBillingProfile](./CmdletHelp/Set-PartnerCenterCustomerBillingProfile.md) |
| | [Get a customer's company profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634682.aspx) | [Get-PartnerCenterCustomerCompanyProfile](./CmdletHelp/Get-PartnerCenterCustomerCompanyProfile.md) |
| Manage user accounts and assign licenses | | |
| | [Get a user account by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt745139.aspx) | [Get-PartnerCenterCustomerUser](./CmdletHelp/Get-PartnerCenterCustomerUser.md) |
| | [Create user accounts for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt725328.aspx) | [New-PartnerCenterCustomerUser](./CmdletHelp/New-PartnerCenterCustomerUser.md) |
| | [Delete a user account for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt725329.aspx) | [Remove-PartnerCenterCustomerUser](./CmdletHelp/Remove-PartnerCenterCustomerUser.md) |
| | [Update user accounts for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt725337.aspx) | [Set-PartnerCenterCustomerUser](./CmdletHelp/Set-PartnerCenterCustomerUser.md) |
| | [View deleted users for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt744323.aspx) | [Get-PartnerCenterCustomerUser](./CmdletHelp/Get-PartnerCenterCustomerUser.md) |
| | [Restore a deleted user for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt744322.aspx) | [Restore-PartnerCenterCustomerUser](./CmdletHelp/Restore-PartnerCenterCustomerUser.md) |
| | [Get a list of all user accounts for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt725330.aspx) | [Get-PartnerCenterCustomerUser](./CmdletHelp/Get-PartnerCenterCustomerUser.md) |
| | [Reset user password for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt725335.aspx) | [Set-PartnerCenterCustomerUser](./CmdletHelp/Set-PartnerCenterCustomerUser.md) |
| | [Get user roles for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt725334.aspx) | [Get-PartnerCenterCustomerUserRole](./CmdletHelp/Get-PartnerCenterCustomerUserRole.md) |
| | | [Get-PartnerCenterCustomerRole](./CmdletHelp/Get-PartnerCenterCustomerRole.md) |
| | | [Get-PartnerCenterCustomerRoleMember](./CmdletHelp/Get-PartnerCenterCustomerRoleMember.md) |
| | [Set user roles for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt725336.aspx) | [Add-PartnerCenterCustomerRoleMember](./CmdletHelp/Add-PartnerCenterCustomerRoleMember.md) |
| | [Remove a customer user from a role](https://msdn.microsoft.com/en-us/library/partnercenter/mt745131.aspx) | [Remove-PartnerCenterCustomerRoleMember](./CmdletHelp/Remove-PartnerCenterCustomerRoleMember.md) |
| | [Get a list of available licenses](https://msdn.microsoft.com/en-us/library/partnercenter/mt725331.aspx) | [Get-PartnerCenterSubscribedSKUs](./CmdletHelp/Get-PartnerCenterSubscribedSKUs.md) |
| | [Assign licenses to a user](https://msdn.microsoft.com/en-us/library/partnercenter/mt725326.aspx) |  |
| | [Check which licenses are assigned to a user](https://msdn.microsoft.com/en-us/library/partnercenter/mt725327.aspx) | [Get-PartnerCenterCustomerUser](./CmdletHelp/Get-PartnerCenterCustomerUser.md) |
| | | |
| **Place orders** | | |
| Get offers from the catalog | | |
| | [Get a list of offer categories by country and locale](https://msdn.microsoft.com/en-us/library/partnercenter/mt634689.aspx) | [Get-PartnerCenterOfferCategoriesByMarket](./CmdletHelp/Get-PartnerCenterOfferCategoriesByMarket.md) |
| | [Get a list of offers for a market](https://msdn.microsoft.com/en-us/library/partnercenter/mt683488.aspx) | [Get-PartnerCenterOffer](./CmdletHelp/Get-PartnerCenterOffer.md) |
| | [Get an offer by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt634678.aspx) | [Get-PartnerCenterOffer](./CmdletHelp/Get-PartnerCenterOffer.md) |
| | [Get add-ons for an offer ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt634669.aspx) | [Get-PartnerCenterOffer](./CmdletHelp/Get-PartnerCenterOffer.md) |
| Create an order | | |
| | [Create an order](https://msdn.microsoft.com/en-us/library/partnercenter/mt634667.aspx) | [New-PartnerCenterOrder](./CmdletHelp/New-PartnerCenterOrder.md) |
| | [Get an order by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt634679.aspx) | [Get-PartnerCenterOffer](./CmdletHelp/Get-PartnerCenterOffer.md) |
| | [Purchase an add-on to a subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt778903.aspx) | [New-PartnerCenterOrder](./CmdletHelp/New-PartnerCenterOrder.md) |
| Get subscription details | | |
| | [Get a subscription by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt634692.aspx) | [Get-PartnerCenterSubscription](./CmdletHelp/Get-PartnerCenterSubscription.md) |
| | [Get a list of subscriptions by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt683489.aspx) | [Get-PartnerCenterSubscription](./CmdletHelp/Get-PartnerCenterSubscription.md) |
| | [Get a list of subscriptions by order](https://msdn.microsoft.com/en-us/library/partnercenter/mt634690.aspx) | [Get-PartnerCenterSubscription](./CmdletHelp/Get-PartnerCenterSubscription.md) |
| | [Get a list of add-ons for a subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt634684.aspx) | [Get-PartnerCenterSubscription](./CmdletHelp/Get-PartnerCenterSubscription.md) |
| Change, suspend, or reactivate a subscription | | |
| | [Change the quantity of a subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt614218.aspx) | [Set-PartnerCenterSubscription](./CmdletHelp/Set-PartnerCenterSubscription.md) |
| | [Suspend a subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt634716.aspx) | [Set-PartnerCenterSubscription](./CmdletHelp/Set-PartnerCenterSubscription.md) |
| | [Reactivate a suspended subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt634714.aspx) | [Set-PartnerCenterSubscription](./CmdletHelp/Set-PartnerCenterSubscription.md) |
| | [Transition a subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt644395.aspx) | |
| | | |
| **Manage billing** | | |
| Get Azure rates and utilization records | | |
| | [Get prices for Microsoft Azure](https://msdn.microsoft.com/en-us/library/partnercenter/mt774619.aspx) | [Get-PartnerCenterAzureRateCard](./CmdletHelp/Get-PartnerCenterAzureRateCard.md) |
| | [Get a customer's utilization records for Azure](https://msdn.microsoft.com/en-us/library/partnercenter/mt791774.aspx) | [Get-PartnerCenterUsage](./CmdletHelp/Get-PartnerCenterUsage.md) |
| Get invoices | | |
| | [Get the reseller's current account balance](https://msdn.microsoft.com/en-us/library/partnercenter/mt712732.aspx) | [Get-PartnerCenterInvoice](./CmdletHelp/Get-PartnerCenterInvoice.md) |
| | [Get invoice by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt712734.aspx) | [Get-PartnerCenterInvoice](./CmdletHelp/Get-PartnerCenterInvoice.md) |
| | [Get invoice line items](https://msdn.microsoft.com/en-us/library/partnercenter/mt634696.aspx) | [Get-PartnerCenterInvoiceLineItems](./CmdletHelp/Get-PartnerCenterInvoiceLineItems.md) |
| | [Get a collection of invoices](https://msdn.microsoft.com/en-us/library/partnercenter/mt712730.aspx) | [Get-PartnerCenterInvoice](./CmdletHelp/Get-PartnerCenterInvoice.md) |
| Check your Azure spending budget | | |
| | [Get usage data for a subscription](https://msdn.microsoft.com/en-us/library/partnercenter/mt651646.aspx) | [Get-PartnerCenterAzureResourceMonthlyUsageRecords](./CmdletHelp/Get-PartnerCenterAzureResourceMonthlyUsageRecords.md) |
| | [Get usage summary for all of a customer's subscriptions](https://msdn.microsoft.com/en-us/library/partnercenter/mt651643.aspx) | [Get-PartnerCenterCustomerUsageSummary](./CmdletHelp/Get-PartnerCenterCustomerUsageSummary.md) |
| | | |
| **Provide support** | | |
| Admin services for a customer | | |
| | [Get the managed services for a customer by ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt614220.aspx) | [Get-PartnerCenterManagedServices](./CmdletHelp/Get-PartnerCenterManagedServices.md) |
| Manage service requests | | |
| | [Create a service request](https://msdn.microsoft.com/en-us/library/partnercenter/mt805812.aspx) | [New-PartnerCenterSR](./CmdletHelp/New-PartnerCenterSR.md) |
| | [Get service request support topics](https://msdn.microsoft.com/en-us/library/partnercenter/mt634701.aspx) | [Get-PartnerCenterSRTopics](./CmdletHelp/Get-PartnerCenterSRTopics.md) |
| | [Get all service requests for a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt634674.aspx) | [Get-PartnerCenterSR](./CmdletHelp/Get-PartnerCenterSR.md) |
| | [Update a service request](https://msdn.microsoft.com/en-us/library/partnercenter/mt634719.aspx) | [Set-PartnerCenterSR](./CmdletHelp/Set-PartnerCenterSR.md) |
| | | |
| **Manage partner accounts and profiles** | | |
| Work with profiles in Dashboard > Account settings | | |
| | [Get legal business profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634697.aspx) | [Get-PartnerCenterLegalBusinessProfile](./CmdletHelp/Get-PartnerCenterLegalBusinessProfile.md) |
| | [Get partner billing profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt712731.aspx) | [Get-PartnerCenterBillingProfile](./CmdletHelp/Get-PartnerCenterBillingProfile.md) |
| | [Get Microsoft Partner Network profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634699.aspx) | [Get-PartnerCenterMpnProfile](./CmdletHelp/Get-PartnerCenterMpnProfile.md) |
| | [Get support profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634703.aspx) | [Get-PartnerCenterSupportProfile](./CmdletHelp/Get-PartnerCenterSupportProfile.md) |
| | [Update legal business profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634722.aspx) | [Set-PartnerCenterLegalBusinessProfile](./CmdletHelp/Set-PartnerCenterLegalBusinessProfile.md) |
| | [Update a partner's billing profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt712738.aspx) | [Set-PartnerCenterBillingProfile](./CmdletHelp/Set-PartnerCenterBillingProfile.md) |
| | [Update support profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt634725.aspx) | [Set-PartnerCenterSupportProfile](./CmdletHelp/Set-PartnerCenterSupportProfile.md) |
| | [Update an organization profile](https://msdn.microsoft.com/en-us/library/partnercenter/mt712737.aspx) | [Set-PartnerCenterOrganizationProfile](./CmdletHelp/Set-PartnerCenterOrganizationProfile.md) |
| | [Get indirect resellers of a customer](https://msdn.microsoft.com/en-us/library/partnercenter/mt783002.aspx) | [Get-PartnerCenterCustomerRelationships](./CmdletHelp/Get-PartnerCenterCustomerRelationships.md) |
| | [Retrieve a list of indirect resellers](https://msdn.microsoft.com/en-us/library/partnercenter/mt783004.aspx) | [Get-PartnerCenterIndirectResellers](./CmdletHelp/Get-PartnerCenterIndirectResellers.md) |
| | [Get customers of an indirect reseller](https://msdn.microsoft.com/en-us/library/partnercenter/mt808157.aspx) | [Get-PartnerCenterResellerCustomers](./CmdletHelp/Get-PartnerCenterResellerCustomers.md) |
| Work with other partners | | |
| | [Get partner by MPN ID](https://msdn.microsoft.com/en-us/library/partnercenter/mt634698.aspx) | [Get-PartnerCenterMpnProfile](./CmdletHelp/Get-PartnerCenterMpnProfile.md) |
| | [Get all subscriptions by partner](https://msdn.microsoft.com/en-us/library/partnercenter/mt634676.aspx) | [Get-PartnerCenterSubscription](./CmdletHelp/Get-PartnerCenterSubscription.md) |
| | | |
| **Analytics** | | |
| | [Get partner licenses deployment information](https://msdn.microsoft.com/en-us/library/partnercenter/mt797761.aspx) | [Get-PartnerCenterLicensesDeployment](./CmdletHelp/Get-PartnerCenterLicensesDeployment.md) |
| | [Get partner licenses usage information](https://msdn.microsoft.com/en-us/library/partnercenter/mt797762.aspx) | [Get-PartnerCenterLicensesUsage](./CmdletHelp/Get-PartnerCenterLicensesUsage.md) |
| | [Get customer licenses deployment information](https://msdn.microsoft.com/en-us/library/partnercenter/mt797759.aspx) | [Get-PartnerCenterCustomerLicensesDeployment](./CmdletHelp/Get-PartnerCenterCustomerLicensesDeployment.md) |
| | [Get customer licenses usage information](https://msdn.microsoft.com/en-us/library/partnercenter/mt797760.aspx) | [Get-PartnerCenterCustomerLicensesUsage](./CmdletHelp/Get-PartnerCenterCustomerLicensesUsage.md) |
| | | |
| **Utilities** | | |
| | [Get address formatting rules by market](https://msdn.microsoft.com/en-us/library/partnercenter/mt683490.aspx) | [Get-PartnerCenterAddressRulesByMarket](./CmdletHelp/Get-PartnerCenterAddressRulesByMarket.md) |
| | [Verify domain availability](https://msdn.microsoft.com/en-us/library/partnercenter/mt644396.aspx) | [Get-PartnerCenterDomainAvailability](./CmdletHelp/Get-PartnerCenterDomainAvailability.md) |
| | [Delete a customer account from the integration sandbox](https://msdn.microsoft.com/en-us/library/partnercenter/mt712728.aspx) | [Remove-PartnerCenterCustomer](./CmdletHelp/Remove-PartnerCenterCustomer.md) |
| | [Get a record of Partner Center activity by user](https://msdn.microsoft.com/en-us/library/partnercenter/mt725332.aspx) | [Get-PartnerCenterAuditRecords](./CmdletHelp/Get-PartnerCenterAuditRecords.md) |
| | [Validate address format](https://msdn.microsoft.com/en-us/library/partnercenter/mt797658.aspx) | [Test-PartnerCenterAddress](./CmdletHelp/Test-PartnerCenterAddress.md) |
| **Authentication** | | |
| | [Add Partner Center Authentication Token](https://msdn.microsoft.com/en-us/library/partnercenter/mt634709.aspx) | [Add-PartnerCenterAuthentication](./CmdletHelp/Add-PartnerCenterAuthentication.md) |
| | | [New-PartnerCenterSAToken](./CmdletHelp/New-PartnerCenterSAToken.md) |
 

## Telemetry collection ##
To help us to better understand the module utilization and better prioritize development efforts we enabled telemetry collection by default.

What we collect?

-  The CSP account domain
-  The cmdlet name executed (only the name, no data is collected)
-  The module version
 
If you preffer not to send this data use the following command to disable the telemetry collection:

    Set-PartnerCenterModuleTelemetry -enabled $false
