Set-StrictMode -Version latest
<#
    © 2018 Microsoft Corporation. All rights reserved. This sample code is not supported under any Microsoft standard support program or service. 
    This sample code is provided AS IS without warranty of any kind. Microsoft disclaims all implied warranties including, without limitation, 
    any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance 
    of the sample code and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, 
    production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business 
    profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the 
    sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
#>
# Load common code
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\commons.ps1"

<#
.SYNOPSIS
Returns the partner's legal business profile.
.DESCRIPTION
The Get-PCLegalBusinessProfile cmdlet returns the partner's legal business profile.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.EXAMPLE
Get-PCLegalBusinessProfile 
.NOTES
#>
function Get-PCLegalBusinessProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/legalbusiness"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Returns the organizational profile.
.DESCRIPTION
The Get-PCOrganizationProfile cmdlet returns the organization profile. 
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.EXAMPLE
Get-PCOrganizationProfile
.NOTES
#>
function Get-PCOrganizationProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/organization"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Return the partner's billing profile.
.DESCRIPTION
The Get-PCBillingProfile cmdlet returns the billing profile for the current partner tenant.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.EXAMPLE
Get-PCBillingProfile
.NOTES
#>
function Get-PCBillingProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/billing"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Returns the specified Mpn profile.
.DESCRIPTION
The Get-PCMpnProfile cmdlet returns the specified Mpn profile.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER MpnId 
Specifies the MPN id used to scope this cmdlet.
.EXAMPLE
Get-PCMpnProfile 
.NOTES
#>
function Get-PCMpnProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$MpnId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    if ($mpnId) {
        $url = "https://api.partnercenter.microsoft.com/v1/profiles/partnernetworkprofile?mpnId={0}" -f $MpnId
    }
    else {
        $url = "https://api.partnercenter.microsoft.com/v1/profiles/mpn"
    }
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile")
}

<#
.SYNOPSIS
Return the partner's support profile.
.DESCRIPTION
The Get-PCSupportProfile cmdlet returns the partner's support profile.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.EXAMPLE
Get-PCSupportProfile 
.NOTES
#>
function Get-PCSupportProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/support"
 
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Updates the partner's legal business profile.
.DESCRIPTION
The Set-PCLegalBusinessProfile cmdlet updates the partner's legal business profile. 
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER Country 
Specifies an updated two letter ISO country code for the legal business profile.
.PARAMETER AddressLine1 
Specifies an updated street address for the legal business profile.
.PARAMETER AddressLine2 
Specifies an updated second address line for the legal business profile.
.PARAMETER City 
Specifies an updated city name for the legal business profile.
.PARAMETER State 
Specifies an updated city name for the legal business profile.
.PARAMETER PostalCode 
Specifies an updated postal code for the legal business profile.
.PARAMETER PrimaryContactFirstName 
Specifies an updated first name for the primary legal business contact.
.PARAMETER PrimaryContactLastName 
Specifies an updated last name for the primary legal business contact.
.PARAMETER PrimaryContactPhoneNumber 
Specifies an updated phone number for the primary legal business contact.
.PARAMETER PrimaryContactEmail 
Specifies an updated e-mail address for the primary legal business contact.
.EXAMPLE
    Set-PCLegalBusinessProfile -PrimaryContactFirstName 'John' -PrimaryContactLastName 'Smith' -PrimaryContactEmail 'john@contoso.com'
Update the legal business profile to use John Smith with the email address of john@contoso.com.
.NOTES
#>
function Set-PCLegalBusinessProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$Country,
        [Parameter(Mandatory = $false)][string]$AddressLine1,
        [Parameter(Mandatory = $false)][string]$AddressLine2,
        [Parameter(Mandatory = $false)][string]$City,
        [Parameter(Mandatory = $false)][string]$State,
        [Parameter(Mandatory = $false)][string]$PostalCode,
        [Parameter(Mandatory = $false)][string]$PrimaryContactFirstName,
        [Parameter(Mandatory = $false)][string]$PrimaryContactLastName,
        [Parameter(Mandatory = $false)][string]$PrimaryContactPhoneNumber,
        [Parameter(Mandatory = $false)][string]$PrimaryContactEmail,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken

        #read-only properties
        #$primaryContactFirstName,#$primaryContactLastName,#$primaryContactPhoneNumber,
        #companyApproverAddress property
        #$Country_approver,#$AddressLine1_approver,#$AddressLine2_approver,#$city_approver,#$state_approver,#$postalCode_approver,
        #companyApproverEmail property
        #$email_approver
    )
    _testTokenContext($SaToken)

    $obj = @()

    $actualLegalBP = Get-PCLegalBusinessProfile -SaToken $SaToken

    if ($AddressLine1) {$actualLegalBP.address.addressLine1 = $AddressLine1}
    if ($AddressLine2) {$actualLegalBP.address.addressLine2 = $AddressLine2}
    if ($Country) {$actualLegalBP.address.country = $Country}
    if ($City) {$actualLegalBP.address.city = $City}
    if ($State) {$actualLegalBP.address.state = $State}
    if ($PostalCode) {$actualLegalBP.address.postalCode = $PostalCode}
    if ($PrimaryContactFirstName) {$actualLegalBP.PrimaryContact.firstName = $PrimaryContactFirstName}
    if ($PrimaryContactLastName) {$actualLegalBP.PrimaryContact.lastName = $PrimaryContactLastName}
    if ($PrimaryContactPhoneNumber) {$actualLegalBP.PrimaryContact.phoneNumber = $PrimaryContactPhoneNumber}
    if ($PrimaryContactEmail) {$actualLegalBP.primaryContact.email = $PrimaryContactEmail}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/legalbusiness"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $body = $actualLegalBP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Updates the partner's organization profile.
.DESCRIPTION
The Set-PCOrganizationProfile cmdlet sets information on a partner's organizational profile.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER CompanyName 
Specifies an updated company name for the partner's organizational profile.
.PARAMETER Country 
Specifies an updated two letter ISO code for the partner's organizational profile.
.PARAMETER AddressLine1 
Specifies the first address line for the partner's organizational profile.
.PARAMETER AddressLine2
Specifies the second address line for the partner's organizational profile.
.PARAMETER City 
Specifies the second city for the partner's organizational profile.
.PARAMETER State 
Specifies the state for the partner's organizational profile.
.PARAMETER PostalCode 
Specifies the postal code for the partner's organizational profile.
.PARAMETER FirstName 
Specifies the first name of the company contact for the partner's organizational profile.
.PARAMETER LastName 
Specifies the last name of the company contact for the partner's organizational profile.
.PARAMETER PhoneNumber 
Specifies the phone number of the company contact for the partner's organizational profile.
.PARAMETER Email 
Specifies the email address for the company contact.
.PARAMETER Language 
Specifies the two letter ISO code for the language.
.EXAMPLE
    Set-PCOrganizationProfile -FirstName 'John' -LastName 'Smith' -Email 'john@contoso.com'
Sets John Smith with the email address of john@contoso.com as the contact on the partner's organizational profile.
.NOTES
#>
function Set-PCOrganizationProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$CompanyName,
        [Parameter(Mandatory = $false)][string]$Country,
        [Parameter(Mandatory = $false)][string]$AddressLine1,
        [Parameter(Mandatory = $false)][string]$AddressLine2,
        [Parameter(Mandatory = $false)][string]$City,
        [Parameter(Mandatory = $false)][string]$State,
        [Parameter(Mandatory = $false)][string]$PostalCode,
        [Parameter(Mandatory = $false)][string]$FirstName,
        [Parameter(Mandatory = $false)][string]$LastName,
        [Parameter(Mandatory = $false)][string]$PhoneNumber,
        [Parameter(Mandatory = $false)][string]$Email,
        [Parameter(Mandatory = $false)][string]$Language,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $actualOrganizationP = Get-PCOrganizationProfile -SaToken $SaToken

    if ($CompanyName) {$actualOrganizationP.companyName = $CompanyName}
    if ($AddressLine1) {$actualOrganizationP.defaultAddress.addressLine1 = $AddressLine1}
    if ($AddressLine2) {$actualOrganizationP.defaultAddress.addressLine2 = $AddressLine2}
    if ($City) {$actualOrganizationP.defaultAddress.city = $City}
    if ($State) {$actualOrganizationP.defaultAddress.state = $State}
    if ($PostalCode) {$actualOrganizationP.defaultAddress.postalCode = $PostalCode}
    if ($Country) {$actualOrganizationP.defaultAddress.country = $Country}
    if ($FirstName) {$actualOrganizationP.defaultAddress.firstName = $FirstName}
    if ($LastName) {$actualOrganizationP.defaultAddress.lastName = $LastName}
    if ($PhoneNumber) {$actualOrganizationP.defaultAddress.phoneNumber = $PhoneNumber}
    if ($Email) {$actualOrganizationP.email = $Email}
    if ($Language) {$actualOrganizationP.language = $Language}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/organization"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $body = $actualOrganizationP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Updates a partner's billing profile.
.DESCRIPTION
The Set-PCBillingProfile cmdlet updates the partner's billing profile. 
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER AddressLine1 
Specifies the first address line for the billing contact.
.PARAMETER AddressLine2
Specifies the second address line for the billing contact.
.PARAMETER City 
Specifies the billing contact's city.
.PARAMETER State 
Specifies the billing contact's state.
.PARAMETER Country 
Specifies the billing contact's country two letter ISO code.
.PARAMETER PostalCode 
Specifies the billing contact's postal code.
.PARAMETER FirstName 
Specifies the billing contact's first name.
.PARAMETER LastName 
Specifies the billing contact's last name.
.PARAMETER PhoneNumber 
Specifies the billing contact's phone number.
.EXAMPLE
Set-PCBillingProfile -FirstName '<first name>' -LastName '<last name>' -PhoneNumber '<phone number>' -AddressLine1 '<address 1>' -AddressLine2 '<address 2>'
.NOTES
#>
function Set-PCBillingProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$Country,
        [Parameter(Mandatory = $false)][string]$AddressLine1,
        [Parameter(Mandatory = $false)][string]$AddressLine2,
        [Parameter(Mandatory = $false)][string]$City,
        [Parameter(Mandatory = $false)][string]$State,
        [Parameter(Mandatory = $false)][string]$PostalCode,
        [Parameter(Mandatory = $false)][string]$FirstName,
        [Parameter(Mandatory = $false)][string]$LastName,
        [Parameter(Mandatory = $false)][string]$PhoneNumber,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken

        #read-only properties
        #$tax_id,$billingCurrency
    )
    _testTokenContext($SaToken)

    $obj = @()

    $actualBillingP = Get-PCBillingProfile -SaToken $SaToken

    if ($AddressLine1) {$actualBillingP.address.addressLine1 = $AddressLine1}
    if ($AddressLine2) {$actualBillingP.address.addressLine2 = $AddressLine2}
    if ($City) {$actualBillingP.address.city = $City}
    if ($State) {$actualBillingP.address.state = $State}
    if ($PostalCode) {$actualBillingP.address.postalCode = $PostalCode}
    if ($Country) {$actualBillingP.address.country = $Country}
    if ($FirstName) {$actualBillingP.primaryContact.firstName = $FirstName}
    if ($LastName) {$actualBillingP.primaryContact.lastName = $LastName}
    if ($PhoneNumber) {$actualBillingP.primaryContact.phoneNumber = $PhoneNumber}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/billing"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $body = $actualBillingP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Modifies the partner's support profile. 
.DESCRIPTION
The Set-PCSupportProfile cmdlet update the partner's support profile.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER Website 
Specifies an updated support website for the partner. Do not include 'http://', specify just the DNS name of the site.
.PARAMETER Email 
Specifies an updated support email address for the partner.
.PARAMETER Phone 
Specifies an updated support phone number for the partner. 
.EXAMPLE
    Set-PCSupportProfile -Website 'support.contoso.com' 
Updates the support website to be support.contoso.com.
.NOTES
#>
function Set-PCSupportProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$Website,
        [Parameter(Mandatory = $false)][string]$Email,
        [Parameter(Mandatory = $false)][string]$Phone,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $actualSupportProfile = Get-PCSupportProfile -SaToken $SaToken
    # Check to make sure all of the required properties exist. If not, add them.
    if (!($actualSupportProfile.PSObject.properties.name -match "website")) {
        $actualSupportProfile | Add-Member -MemberType NoteProperty -Name 'website' -Value " "
    }
    if (!($actualSupportProfile.PSObject.properties.name -match "email")) {     
                
        $actualSupportProfile | Add-Member -MemberType NoteProperty -Name 'email' -Value " "
    }
    if (!($actualSupportProfile.PSObject.properties.name -match "telephone"))
    {
        $actualSupportProfile | Add-Member -MemberType NoteProperty -Name 'telephone' -Value " "
    }

    if ($Website) {$actualSupportProfile.website = $Website}
    if ($Email) {$actualSupportProfile.email = $Email}
    if ($Phone) {$actualSupportProfile.telephone = $Phone}
   
    $url = "https://api.partnercenter.microsoft.com/v1/profiles/support"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
    
    $body = $actualSupportProfile | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Returns the specified customer's billing profile.
.DESCRIPTION
The Get-PCCustomerBillingProfile cmdlet returns the billing profile for the specified tenant.
.PARAMETER SaToken 
Specifies an authentication token you have created with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.EXAMPLE
Get-PCCustomerBillingProfile -TenantId <TenantId>
.NOTES
TODO
#>
function Get-PCCustomerBillingProfile {
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )

    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/billing" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Updates the specified customer's billing profile. The cmdlet accepts an updated billing profile object to determine the updates to be made. Use either Get-PCCustomerBillingProfile or New-PCCustomerBillingProfile cmdlet to create the updated customer billing profile object. 
.DESCRIPTION
The Set-PCCustomerBillingProfile cmdlet updates a customer's billing profile.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER BillingProfile 
Specifies a variable that includes the billing profile.
.EXAMPLE
Update the current customer billing profile.

Get customer Billing Profile

$customerBillingProfile = Get-PCCustomerBillingProfile -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536

Update name and email address on the customer billing profile.

    $customerBillingProfile.FirstName = 'Joan'
    $customerBillingProfile.LastName = 'Sullivan'
    $customerBillingProfile.Email = 'joan@wingtiptoyscsptest.onmicrosoft.com'

Complete update for the customer's billing profile

    Set-PCCustomerBillingProfile -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536 -BillingProfile $customerBillingProfile

.NOTES
#>
function Set-PCCustomerBillingProfile {
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $true, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)][PSCustomObject]$BillingProfile,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/billing" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $body = $BillingProfile | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PUT" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
Returns the specified customer's company profile.
.DESCRIPTION
The Get-PCCustomerCompanyProfile cmdlet returns the customer's company profile.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.PARAMETER TenantId 
Specifies a tenant id to scope this cmdlet.
.EXAMPLE
Get-PCCustomerCompanyProfile -TenantId <TenantId>
Retrieve the customer's company profile for the specified tenant id.
.NOTES
#>
function Get-PCCustomerCompanyProfile {
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/company" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
    
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
This cmdlet is used to create a PowerShell object that can be passed to other cmdlets, such as the the New-PCCustomer cmdlet when creating a new customer.
.DESCRIPTION
The New-PCCustomerBillingProfile cmdlet creates a PowerShell object that includes properties for the customer billing profile.
.PARAMETER SaToken 
Specifies an authentication token you have created with your Partner Center credentials.
.PARAMETER FirstName 
Specifies the first name of the customer company contact.
.PARAMETER LastName
Specifies the last name of the customer company contact.
.PARAMETER Email 
Specifies the email address of the customer company contact.
.PARAMETER Culture 
Specifies the two letter ISO culture of the customer company contact.
.PARAMETER Language 
Specifies the two letter ISO culture of the customer company contact.
.PARAMETER CompanyName
Specifies the name of the customer company.
.PARAMETER Country
Specifies the country for the customer company.
.PARAMETER Region 
Specifies the three letter region for the customer company.
.PARAMETER City 
Specifies the city for the customer's company address.
.PARAMETER State
Specifies the state for the customer's company address.
.PARAMETER AddressLine1
Specifies the first line of the street address for the customer company's address.
.PARAMETER PostalCode 
Specifies the postal code for the customer company's address.
.PARAMETER PhoneNumber 
Specifies the phone number for the customer company's contact.
.PARAMETER DefaultAddress
Specifies a PowerShell object that contains the default address information for the company.
.EXAMPLE
$cBP = New-PCCustomerBillingProfile -FirstName 'Joe' -LastName 'Smith' -Email 'joe@contoso.com' -Country 'US' -City 'Redmond' -State 'WA' -PostalCode 98502 - AddressLine1 '1 Microsoft Way'
Create an object that has the billing profile information for Joe Smith at Contoso.
.NOTES
#>
function New-PCCustomerBillingProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$FirstName,
        [Parameter(Mandatory = $true)][string]$LastName,
        [Parameter(Mandatory = $true)][string]$Email,
        [Parameter(Mandatory = $true)][string]$Culture,
        [Parameter(Mandatory = $true)][string]$Language,
        [Parameter(Mandatory = $true)][string]$CompanyName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$Country, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][string]$Region = $null,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$City, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$State, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$AddressLine1,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$PostalCode, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$PhoneNumber,
        [Parameter(ParameterSetName = 'DefaultAddress', Mandatory = $true)][DefaultAddress]$DefaultAddress
    )

    switch ($PsCmdlet.ParameterSetName) {
        'AllDetails' {
            $billingProfile = [BillingProfile]::new($Email, $Culture, $Language, $CompanyName, $Country, $region, $City, $State, $AddressLine1, `
                    $PostalCode, $FirstName, $LastName, $PhoneNumber) 
        }
        'DefaultAddress' { $billingProfile = [BillingProfile]::new($FirstName, $LastName, $Email, $Culture, $Language, $CompanyName, $DefaultAddress)}
    }

    return $billingProfile
}

<#
.SYNOPSIS
This cmdlet is used to create a PowerShell object that can be passed to other cmdlets, such as the the New-PCCustomerBillingProfile cmdlet.
.DESCRIPTION
The New-PCCustomerDefaultAddress cmdlet returns a PowerShell object with the properties for a default address.

.PARAMETER Country
Specifies the country for the customer company.
.PARAMETER Region 
Specifies the three letter region for the customer company.

.PARAMETER City 
Specifies the city for the customer's company address.
.PARAMETER State
Specifies the state for the customer's company address.

.PARAMETER AddressLine1 
Specifies the first address line for the customer's address.
.PARAMETER PostalCode 
Specifies the postal code for the customer's address.
.PARAMETER FirstName 
Specifies the first name for the customer's contact.
.PARAMETER LastName 
Specifies the last name for the customer's contact.
.PARAMETER PhoneNumber 
Specifies the phone number for the customer's contact.
.EXAMPLE
    $cda = New-PCCustomerDefaultAddress -Country 'US' -Region 'USA' -City 'Redmond' -State 'WA' -AddressLine1 '1 Microsoft Way' -PostalCode '98502' -FirstName 'John' -LastName 'Smith' -PhoneNumber '8005551212'
Create a new PowerShell object that includes the properties for a customer's default address. 
.NOTES
#>
function New-PCCustomerDefaultAddress {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Country, 
        [Parameter(Mandatory = $false)][string]$Region = $null, 
        [Parameter(Mandatory = $true)][string]$City, 
        [Parameter(Mandatory = $true)][string]$State, 
        [Parameter(Mandatory = $true)][string]$AddressLine1,
        [Parameter(Mandatory = $true)][string]$PostalCode, 
        [Parameter(Mandatory = $true)][string]$FirstName,
        [Parameter(Mandatory = $true)][string]$LastName, 
        [Parameter(Mandatory = $true)][string]$PhoneNumber
    )
    
    $DefaultAddress = [DefaultAddress]::new($Country, $Region, $City, $State, $AddressLine1, $PostalCode, $FirstName, $LastName, $PhoneNumber)
    return $DefaultAddress
}

<#
.SYNOPSIS
Returns a PowerShell object that includes the properties for the customer's company properties. The object is passed to the New-PCCustomer cmdlet to create a new customer.
.DESCRIPTION
The New-PCCustomerCompanyProfile cmdlet returns a PowerShell object that includes the properties for the customer's company properties.

.PARAMETER Domain 
Specifies the domain for the company profile
.EXAMPLE
$ccp = New-PCCustomerCompanyProfile -Domain 'contoso.onmicrosoft.com'
Create a new customer profile with the contoso.onmicrosoft.com domain and assign it to $ccp variable.
.NOTES
#>
function New-PCCustomerCompanyProfile {   
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Domain
    )

    $companyProfile = [CompanyProfile]::new($Domain)
    return $CompanyProfile
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The New-PCAddress cmdlet returns a PowerShell object with all of address properties.
.PARAMETER AddressLine1 
Specifies address line 1 for the new address.
.PARAMETER AddressLine2 
Specifies address line 2 for the new address.
.PARAMETER City 
Specifies the city name.
.PARAMETER State 
Specifies the state name.
.PARAMETER PostalCode 
Specifies the postal code.
.PARAMETER Country 
Specifies the country
.PARAMETER Region 
Specifies the region.
.EXAMPLE
    $add = New-PCAddress -AddressLine1 '1 Microsoft Way' -City 'Redmond' -State 'WA' -Country 'US' -PostalCode '95802'
Create a new address object for an address and assign it to the $add variable.
.NOTES
#>
function New-PCAddress {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$AddressLine1,
        [Parameter(Mandatory = $false)][string]$AddressLine2,
        [Parameter(Mandatory = $true)][string]$City, 
        [Parameter(Mandatory = $true)][string]$State, 
        [Parameter(Mandatory = $true)][string]$PostalCode, 
        [Parameter(Mandatory = $true)][string]$Country,
        [Parameter(Mandatory = $false)][string]$Region = $null
    )
    
    $address = [DefaultAddress]::new($Country, $Region, $City, $State, $AddressLine1, $PostalCode)
    if ($AddressLine2) {$address.AddressLine2 = $AddressLine2}
    return $address
}

<#
.SYNOPSIS
Validates the provided address information to determine if it meets the Partner Center validation rules. 
.DESCRIPTION
The Test-PCAddress cmdlet validates the provided the address information as to whether it conforms to the Partner Center address rules.
.PARAMETER SaToken 
Specifies an partner center access token.
.PARAMETER Address 
Specifies a variable object that includes all of the address information. This object can be created by using the New-PCAddress cmdlet.
.PARAMETER AddressLine1 
Specifies the first address line.
.PARAMETER AddressLine2 
Specifies the second address line.
.PARAMETER City 
Specifies the city.
.PARAMETER State 
Specifies the state.
.PARAMETER PostalCode 
Specifies the postal code.
.PARAMETER Country
Specifies a two letter ISO code to define the country.
.EXAMPLE
$address = New-PCAddress -AddressLine1 '<string>' -AddressLine2 '<string>' -City '<string>' -State '<string>' -PostalCode '<string>' -Country 'two digits Country code' -region '<string>'    
Test-PCAddress -Address $add
Validate an address by passing an object variable named $add that was created using the New-PCAddress cmdlet.
.EXAMPLE
Test-PCAddress -AddressLine1 '1 Microsoft Way' -City 'Redmond' -State 'WA' -Country 'US' -PostalCode '95802'
Validate an address by passing the address information to the cmdlet.
.NOTES
#>
function Test-PCAddress {
    [CmdletBinding()]
    param ( 
        [Parameter(ParameterSetName = 'ByObject', Mandatory = $true)][DefaultAddress] $Address,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $AddressLine1,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][string] $AddressLine2,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $City, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $State, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $PostalCode, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Country, 
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/validations/address"
    $headers = @{"Authorization" = "Bearer $SaToken"}
    $headers += @{"MS-Contract-Version" = "v1"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}
  

    # TODO $Region is listed below, but it doesn't appear to be assigned from anywhere.
    switch ($PsCmdlet.ParameterSetName) {
        'ByObject' { $address_tmp = $address}
        'AllDetails' { $address_tmp = [DefaultAddress]::new($Country, $Region, $City, $State, $AddressLine1, $PostalCode)}
    }
        
    $body = $address_tmp | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" #-Debug -Verbose    
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ValidationAddress")

}