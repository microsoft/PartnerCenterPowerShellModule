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

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.EXAMPLE

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

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
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

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.EXAMPLE

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

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER MpnId 

.EXAMPLE

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

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.EXAMPLE

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

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER Country 

.PARAMETER AddressLine1 

.PARAMETER AddressLine2 

.PARAMETER City 

.PARAMETER State 

.PARAMETER PostalCode 

.PARAMETER PrimaryContactFirstName 

.PARAMETER PrimaryContactLastName 

.PARAMETER PrimaryContactPhoneNumber 

.PARAMETER PrimaryContactEmail 

.EXAMPLE

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
        #$primarycontactfirstname,#$primarycontactlastname,#$primarycontactphonenumber,
        #companyApproverAddress property
        #$Country_approver,#$AddressLine1_approver,#$AddressLine2_approver,#$city_approver,#$state_approver,#$postalcode_approver,
        #companyApproverEmail property
        #$email_approver
    )
    _testTokenContext($SaToken)

    $obj = @()

    $actualLegalBP = Get-PCLegalBusinessProfile -SaToken $SaToken

    if ($AddressLine1) {$actualLegalBP.address.AddressLine1 = $AddressLine1}
    if ($AddressLine2) {$actualLegalBP.address.AddressLine2 = $AddressLine2}
    if ($Country) {$actualLegalBP.address.Country = $Country}
    if ($City) {$actualLegalBP.address.City = $City}
    if ($State) {$actualLegalBP.address.State = $State}
    if ($PostalCode) {$actualLegalBP.address.PostalCode = $PostalCode}
    if ($PrimaryContactFirstName) {$actualLegalBP.address.FirstName = $PrimaryContactFirstName}
    if ($PrimaryContactLastName) {$actualLegalBP.address.LastName = $PrimaryContactLastName}
    if ($PrimaryContactPhoneNumber) {$actualLegalBP.address.PhoneNumber = $PrimaryContactPhoneNumber}
    if ($PrimaryContactEmail) {$actualLegalBP.primaryContact.Email = $PrimaryContactEmail}

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
TODO
.DESCRIPTION
The Set-PCOrganizationProfile cmdlet.
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER CompanyName 

.PARAMETER Country 

.PARAMETER AddressLine1 

.PARAMETER City 

.PARAMETER State 

.PARAMETER PostalCode 

.PARAMETER FirstName 

.PARAMETER LastName 

.PARAMETER PhoneNumber 

.PARAMETER Email 

.PARAMETER Language 

.EXAMPLE

.NOTES
#>
function Set-PCOrganizationProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$CompanyName,
        [Parameter(Mandatory = $false)][string]$Country,
        [Parameter(Mandatory = $false)][string]$AddressLine1,
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

    if ($CompanyName) {$actualOrganizationP.CompanyName = $CompanyName}
    if ($AddressLine1) {$actualOrganizationP.defaultAddress.AddressLine1 = $AddressLine1}
    if ($City) {$actualOrganizationP.defaultAddress.City = $City}
    if ($State) {$actualOrganizationP.defaultAddress.State = $State}
    if ($PostalCode) {$actualOrganizationP.defaultAddress.PostalCode = $PostalCode}
    if ($Country) {$actualOrganizationP.defaultAddress.Country = $Country}
    if ($FirstName) {$actualOrganizationP.defaultAddress.FirstName = $FirstName}
    if ($LastName) {$actualOrganizationP.defaultAddress.LastName = $LastName}
    if ($PhoneNumber) {$actualOrganizationP.defaultAddress.PhoneNumber = $PhoneNumber}
    if ($Email) {$actualOrganizationP.Email = $Email}
    if ($Language) {$actualOrganizationP.Language = $Language}

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
TODO 
.DESCRIPTION
The Set-PCBillingProfile cmdlet. 
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER AddressLine1 

.PARAMETER AddressLine2

.PARAMETER City 

.PARAMETER State 

.PARAMETER PostalCode 

.PARAMETER FirstName 

.PARAMETER LastName 

.PARAMETER PhoneNumber 

.EXAMPLE

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

    if ($AddressLine1) {$actualBillingP.address.AddressLine1 = $AddressLine1}
    if ($AddressLine2) {$actualBillingP.address.AddressLine2 = $AddressLine2}
    if ($City) {$actualBillingP.address.City = $City}
    if ($State) {$actualBillingP.address.State = $State}
    if ($PostalCode) {$actualBillingP.address.PostalCode = $PostalCode}
    if ($Country) {$actualBillingP.address.Country = $Country}
    if ($FirstName) {$actualBillingP.primaryContact.FirstName = $FirstName}
    if ($LastName) {$actualBillingP.primaryContact.LastName = $LastName}
    if ($PhoneNumber) {$actualBillingP.primaryContact.PhoneNumber = $PhoneNumber}

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
TODO 
.DESCRIPTION
The Set-PCSupportProfile cmdlet. 
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.PARAMETER Website 

.PARAMETER Email 

.PARAMETER Phone 

.EXAMPLE

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

    if ($website) {$actualSupportProfile.website = $website}
    if ($Email) {$actualSupportProfile.Email = $Email}
    if ($phone) {$actualSupportProfile.telephone = $phone}

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
TODO
.DESCRIPTION
The Get-PCCustomerBillingProfile cmdlet.
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.EXAMPLE
Get-PCCustomerBillingProfile
.NOTES
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
TODO
.DESCRIPTION
The Set-PCCustomerBillingProfile cmdlet.
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER BillingProfile 

.EXAMPLE

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

    $body = $Billingprofile | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PUT" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Get-PCCustomerCompanyProfile cmdlet. 

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.PARAMETER TenantId 

.EXAMPLE

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
TODO
.DESCRIPTION
The New-PCCustomerBillinghProfile cmdlet.
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER FirstName 

.PARAMETER LastName

.PARAMETER Email 

.PARAMETER Culture 

.PARAMETER Language 

.PARAMETER CompanyName

.PARAMETER Country

.PARAMETER Region 

.PARAMETER City 

.PARAMETER State

.PARAMETER AddressLine1

.PARAMETER PostalCode 

.PARAMETER PhoneNumber 

.PARAMETER DefaultAddress

.EXAMPLE
New-PCCustomerBillingProfile

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
TODO
.DESCRIPTION
The New-PCCustomerDefaultAddress cmdlet. 

.PARAMETER Country 

.PARAMETER Region 

.PARAMETER City 

.PARAMETER State 

.PARAMETER AddressLine1 

.PARAMETER PostalCode 

.PARAMETER FirstName 

.PARAMETER LastName 

.PARAMETER PhoneNumber 

.EXAMPLE

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
TODO
.DESCRIPTION
The New-PCCustomerCompanyProfile cmdlet.

.PARAMETER Domain 

.EXAMPLE
New-PCCustomerCompanyProfile

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
The New-PCAddress cmdlet.
.PARAMETER AddressLine1 

.PARAMETER AddressLine2 

.PARAMETER City 

.PARAMETER State 

.PARAMETER PostalCode 

.PARAMETER Country 

.PARAMETER Region 

.EXAMPLE
New-PCAddress
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
TODO
.DESCRIPTION
The Test-PCAddress cmdlet.
.PARAMETER SaToken 

.PARAMETER Address 

.PARAMETER AddressLine1 

.PARAMETER AddressLine2 

.PARAMETER City 

.PARAMETER State 

.PARAMETER PostalCode 

.PARAMETER Country

.EXAMPLE
Test-PCAddress
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