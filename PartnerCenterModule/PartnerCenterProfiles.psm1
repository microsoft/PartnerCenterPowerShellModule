Set-StrictMode -Version latest
<#
    © 2017 Microsoft Corporation. All rights reserved. This sample code is not supported under any Microsoft standard support program or service. 
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

.PARAMETER saToken 

.EXAMPLE

.NOTES
#>
function Get-PCLegalBusinessProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/legalbusiness"
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.EXAMPLE

.NOTES
#>
function Get-PCOrganizationProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/organization"
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.EXAMPLE

.NOTES
#>
function Get-PCBillingProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/billing"
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER mpnId 

.EXAMPLE

.NOTES
#>
function Get-PCMpnProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$mpnId,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    if ($mpnId) {
        $url = "https://api.partnercenter.microsoft.com/v1/profiles/partnernetworkprofile?mpnId={0}" -f $mpnId
    }
    else {
        $url = "https://api.partnercenter.microsoft.com/v1/profiles/mpn"
    }
    
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile")
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.EXAMPLE

.NOTES
#>
function Get-PCSupportProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/support"
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER country 

.PARAMETER addressLine1 

.PARAMETER addressLine2 

.PARAMETER city 

.PARAMETER state 

.PARAMETER postalCode 

.PARAMETER primaryContactFirstName 

.PARAMETER primaryContactLastName 

.PARAMETER primaryContactPhoneNumber 

.PARAMETER primaryContactEmail 

.EXAMPLE

.NOTES
#>
function Set-PCLegalBusinessProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$country,
        [Parameter(Mandatory = $false)][string]$addressLine1,
        [Parameter(Mandatory = $false)][string]$addressLine2,
        [Parameter(Mandatory = $false)][string]$city,
        [Parameter(Mandatory = $false)][string]$state,
        [Parameter(Mandatory = $false)][string]$postalCode,
        [Parameter(Mandatory = $false)][string]$primaryContactFirstName,
        [Parameter(Mandatory = $false)][string]$primaryContactLastName,
        [Parameter(Mandatory = $false)][string]$primaryContactPhoneNumber,
        [Parameter(Mandatory = $false)][string]$primaryContactEmail,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken

        #read-only properties
        #$primarycontactfirstname,#$primarycontactlastname,#$primarycontactphonenumber,
        #companyApproverAddress property
        #$country_approver,#$addressLine1_approver,#$addressLine2_approver,#$city_approver,#$state_approver,#$postalcode_approver,
        #companyApproverEmail property
        #$email_approver
    )
    _testTokenContext($saToken)

    $obj = @()

    $actualLegalBP = Get-PCLegalBusinessProfile -saToken $saToken

    if ($addressLine1) {$actualLegalBP.address.addressLine1 = $addressLine1}
    if ($addressLine2) {$actualLegalBP.address.addressLine2 = $addressLine2}
    if ($country) {$actualLegalBP.address.country = $country}
    if ($city) {$actualLegalBP.address.city = $city}
    if ($state) {$actualLegalBP.address.state = $state}
    if ($postalCode) {$actualLegalBP.address.postalCode = $postalCode}
    if ($primaryContactFirstName) {$actualLegalBP.address.firstName = $primaryContactFirstName}
    if ($primaryContactLastName) {$actualLegalBP.address.lastName = $primaryContactLastName}
    if ($primaryContactPhoneNumber) {$actualLegalBP.address.phoneNumber = $primaryContactPhoneNumber}
    if ($primaryContactEmail) {$actualLegalBP.primaryContact.email = $primaryContactEmail}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/legalbusiness"
    $headers = @{Authorization = "Bearer $saToken"}

    $body = $actualLegalBP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER companyName 

.PARAMETER country 

.PARAMETER addressLine1 

.PARAMETER city 

.PARAMETER state 

.PARAMETER postalCode 

.PARAMETER firstName 

.PARAMETER lastName 

.PARAMETER phoneNumber 

.PARAMETER email 

.PARAMETER language 

.EXAMPLE

.NOTES
#>
function Set-PCOrganizationProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$companyName,
        [Parameter(Mandatory = $false)][string]$country,
        [Parameter(Mandatory = $false)][string]$addressLine1,
        [Parameter(Mandatory = $false)][string]$city,
        [Parameter(Mandatory = $false)][string]$state,
        [Parameter(Mandatory = $false)][string]$postalCode,
        [Parameter(Mandatory = $false)][string]$firstName,
        [Parameter(Mandatory = $false)][string]$lastName,
        [Parameter(Mandatory = $false)][string]$phoneNumber,
        [Parameter(Mandatory = $false)][string]$email,
        [Parameter(Mandatory = $false)][string]$language,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    $actualOrganizationP = Get-PCOrganizationProfile -saToken $saToken

    if ($companyName) {$actualOrganizationP.companyName = $companyName}
    if ($addressLine1) {$actualOrganizationP.defaultAddress.addressLine1 = $addressLine1}
    if ($city) {$actualOrganizationP.defaultAddress.city = $city}
    if ($state) {$actualOrganizationP.defaultAddress.state = $state}
    if ($postalCode) {$actualOrganizationP.defaultAddress.postalCode = $postalCode}
    if ($country) {$actualOrganizationP.defaultAddress.country = $country}
    if ($firstName) {$actualOrganizationP.defaultAddress.firstName = $firstName}
    if ($lastName) {$actualOrganizationP.defaultAddress.lastName = $lastName}
    if ($phoneNumber) {$actualOrganizationP.defaultAddress.phoneNumber = $phoneNumber}
    if ($email) {$actualOrganizationP.email = $email}
    if ($language) {$actualOrganizationP.language = $language}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/organization"
    $headers = @{Authorization = "Bearer $saToken"}

    $body = $actualOrganizationP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER addressLine1 

.PARAMETER addressLine2

.PARAMETER city 

.PARAMETER state 

.PARAMETER postalCode 

.PARAMETER firstName 

.PARAMETER lastName 

.PARAMETER phoneNumber 

.EXAMPLE

.NOTES
#>
function Set-PCBillingProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$country,
        [Parameter(Mandatory = $false)][string]$addressLine1,
        [Parameter(Mandatory = $false)][string]$addressLine2,
        [Parameter(Mandatory = $false)][string]$city,
        [Parameter(Mandatory = $false)][string]$state,
        [Parameter(Mandatory = $false)][string]$postalCode,
        [Parameter(Mandatory = $false)][string]$firstName,
        [Parameter(Mandatory = $false)][string]$lastName,
        [Parameter(Mandatory = $false)][string]$phoneNumber,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken

        #read-only properties
        #$tax_id,$billingCurrency
    )
    _testTokenContext($saToken)

    $obj = @()

    $actualBillingP = Get-PCBillingProfile -saToken $saToken

    if ($addressLine1) {$actualBillingP.address.addressLine1 = $addressLine1}
    if ($addressLine2) {$actualBillingP.address.addressLine2 = $addressLine2}
    if ($city) {$actualBillingP.address.city = $city}
    if ($state) {$actualBillingP.address.state = $state}
    if ($postalCode) {$actualBillingP.address.postalCode = $postalCode}
    if ($country) {$actualBillingP.address.country = $country}
    if ($firstName) {$actualBillingP.primaryContact.firstName = $firstName}
    if ($lastName) {$actualBillingP.primaryContact.lastName = $lastName}
    if ($phoneNumber) {$actualBillingP.primaryContact.phoneNumber = $phoneNumber}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/billing"
    $headers = @{Authorization = "Bearer $saToken"}

    $body = $actualBillingP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER website 

.PARAMETER email 

.PARAMETER phoen 

.EXAMPLE

.NOTES
#>
function Set-PCSupportProfile {
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$website,
        [Parameter(Mandatory = $false)][string]$email,
        [Parameter(Mandatory = $false)][string]$phone,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    $actualSupportProfile = Get-PCSupportProfile -saToken $saToken

    if ($website) {$actualSupportProfile.website = $website}
    if ($email) {$actualSupportProfile.email = $email}
    if ($phone) {$actualSupportProfile.telephone = $phone}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/support"
    $headers = @{Authorization = "Bearer $saToken"}

    $body = $actualSupportProfile | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerBillingProfile {
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )

    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/billing" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER billingProfile 

.EXAMPLE

.NOTES
#>
function Set-PCCustomerBillingProfile {
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $true, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)][PSCustomObject]$billingProfile,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/billing" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}
    $body = $billingprofile | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PUT" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerCompanyProfile {
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/company" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER firstName 

.PARAMETER lastName

.PARAMETER email 

.PARAMETER culture 

.PARAMETER language 

.PARAMETER companyName

.PARAMETER country

.PARAMETER region 

.PARAMETER city 

.PARAMETER state

.PARAMETER addressline1

.PARAMETER postalCode 

.PARAMETER phoneNumber 

.PARAMETER defaultAddress

.EXAMPLE

.NOTES
#>
function New-PCCustomerBillingProfile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$firstName,
        [Parameter(Mandatory = $true)][string]$lastName,
        [Parameter(Mandatory = $true)][string]$email,
        [Parameter(Mandatory = $true)][string]$culture,
        [Parameter(Mandatory = $true)][string]$language,
        [Parameter(Mandatory = $true)][string]$companyName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$country, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][string]$region = $null,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$city, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$state, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$addressLine1,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$postalCode, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$phoneNumber,
        [Parameter(ParameterSetName = 'DefaultAddress', Mandatory = $true)][DefaultAddress]$defaultAddress
    )

    switch ($PsCmdlet.ParameterSetName) {
        'AllDetails' {
            $billingProfile = [BillingProfile]::new($email, $culture, $language, $companyName, $country, $region, $city, $state, $addressLine1, `
                    $postalCode, $firstName, $lastName, $phoneNumber) 
        }
        'DefaultAddress' { $billingProfile = [BillingProfile]::new($firstName, $lastName, $email, $culture, $language, $companyName, $defaultAddress)}
    }

    return $billingProfile
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER country 

.PARAMETER region 

.PARAMETER city 

.PARAMETER state 

.PARAMETER addressLine1 

.PARAMETER postalCode 

.PARAMETER firstName 

.PARAMETER lastName 

.PARAMETER phoneNumber 

.EXAMPLE

.NOTES
#>
function New-PCCustomerDefaultAddress {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$country, 
        [Parameter(Mandatory = $false)][string]$region = $null, 
        [Parameter(Mandatory = $true)][string]$city, 
        [Parameter(Mandatory = $true)][string]$state, 
        [Parameter(Mandatory = $true)][string]$addressLine1,
        [Parameter(Mandatory = $true)][string]$postalCode, 
        [Parameter(Mandatory = $true)][string]$firstName,
        [Parameter(Mandatory = $true)][string]$lastName, 
        [Parameter(Mandatory = $true)][string]$phoneNumber
    )
    
    $DefaultAddress = [DefaultAddress]::new($country, $region, $city, $state, $addressLine1, $postalCode, $firstName, $lastName, $phoneNumber)
    return $DefaultAddress
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER domain 

.EXAMPLE

.NOTES
#>
function New-PCCustomerCompanyProfile {   
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$domain
    )

    $companyProfile = [CompanyProfile]::new($domain)
    return $companyProfile
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER addressLine1 

.PARAMETER addressLine2 

.PARAMETER city 

.PARAMETER state 

.PARAMETER postalCode 

.PARAMETER country 

.PARAMETER region 

.EXAMPLE

.NOTES
#>
function New-PCAddress {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$addressLine1,
        [Parameter(Mandatory = $false)][string]$addressLine2,
        [Parameter(Mandatory = $true)][string]$city, 
        [Parameter(Mandatory = $true)][string]$state, 
        [Parameter(Mandatory = $true)][string]$postalCode, 
        [Parameter(Mandatory = $true)][string]$country,
        [Parameter(Mandatory = $false)][string]$region = $null
    )
    
    $address = [DefaultAddress]::new($country, $region, $city, $state, $addressLine1, $postalCode)
    if ($addressLine2) {$address.addressLine2 = $addressLine2}
    return $address
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER address 

.PARAMETER addressLine1 

.PARAMETER addressLine2 

.PARAMETER city 

.PARAMETER state 

.PARAMETER postalCode 

.PARAMETER country

.EXAMPLE

.NOTES
#>
function Test-PCAddress {
    [CmdletBinding()]
    param ( 
        [Parameter(ParameterSetName = 'ByObject', Mandatory = $true)][DefaultAddress] $address,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $addressLine1,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][string] $addressLine2,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $city, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $state, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $postalCode, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $country, 
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/validations/address"
    $headers = @{"Authorization" = "Bearer $saToken"}
    $headers += @{"MS-Contract-Version" = "v1"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}
  
    switch ($PsCmdlet.ParameterSetName) {
        'ByObject' { $address_tmp = $address}
        'AllDetails' { $address_tmp = [DefaultAddress]::new($country, $region, $city, $state, $addressLine1, $postalCode)}
    }
        
    $body = $address_tmp | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" #-Debug -Verbose    
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ValidationAddress")

}