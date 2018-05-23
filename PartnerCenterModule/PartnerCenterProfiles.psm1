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

function Get-PCLegalBusinessProfile
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/legalbusiness"
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Get-PCOrganizationProfile
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/organization"
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Get-PCBillingProfile
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/billing"
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Get-PCMpnProfile
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$mpnid,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()

    if($mpnid)
    {
        $url = "https://api.partnercenter.microsoft.com/v1/profiles/partnernetworkprofile?mpnId={0}" -f $mpnid
    }
    else
    {
        $url = "https://api.partnercenter.microsoft.com/v1/profiles/mpn"
    }
    
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile")
}

function Get-PCSupportProfile
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/support"
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Set-PCLegalBusinessProfile
{
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$country,
        [Parameter(Mandatory = $false)][string]$AddressLine1,
        [Parameter(Mandatory = $false)][string]$AddressLine2,
        [Parameter(Mandatory = $false)][string]$city,
        [Parameter(Mandatory = $false)][string]$state,
        [Parameter(Mandatory = $false)][string]$postalcode,
        [Parameter(Mandatory = $false)][string]$primarycontactfirstname,
        [Parameter(Mandatory = $false)][string]$primarycontactlastname,
        [Parameter(Mandatory = $false)][string]$primarycontactphonenumber,
        [Parameter(Mandatory = $false)][string]$primarycontactemail,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken

        #read-only properties
            #$primarycontactfirstname,#$primarycontactlastname,#$primarycontactphonenumber,
        #companyApproverAddress property
            #$country_approver,#$AddressLine1_approver,#$AddressLine2_approver,#$city_approver,#$state_approver,#$postalcode_approver,
        #companyApproverEmail property
            #$email_approver
    )
    _testTokenContext($satoken)

    $obj = @()

    $actualLegalBP = Get-PCLegalBusinessProfile -satoken $satoken

    if($AddressLine1)                  {$actualLegalBP.address.addressLine1 = $AddressLine1}
    if ($AddressLine2)             {$actualLegalBP.address.addressLine2 = $AddressLine2}
    if ($country)                  {$actualLegalBP.address.country = $country}
    if ($city)                     {$actualLegalBP.address.city = $city}
    if ($state)                    {$actualLegalBP.address.state = $state}
    if ($postalcode)               {$actualLegalBP.address.postalCode = $postalcode}
    if ($primarycontactfirstname)  {$actualLegalBP.address.firstName = $primarycontactfirstname}
    if ($primarycontactlastname)   {$actualLegalBP.address.lastName = $primarycontactlastname}
    if ($primarycontactphonenumber){$actualLegalBP.address.phoneNumber = $primarycontactphonenumber}
    if ($primarycontactemail)      {$actualLegalBP.primaryContact.email = $primarycontactemail}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/legalbusiness"
    $headers = @{Authorization="Bearer $satoken"}

    $body = $actualLegalBP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Set-PCOrganizationProfile
{
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$companyName,
        [Parameter(Mandatory = $false)][string]$country,
        [Parameter(Mandatory = $false)][string]$AddressLine1,
        [Parameter(Mandatory = $false)][string]$city,
        [Parameter(Mandatory = $false)][string]$state,
        [Parameter(Mandatory = $false)][string]$postalcode,
        [Parameter(Mandatory = $false)][string]$firstname,
        [Parameter(Mandatory = $false)][string]$lastname,
        [Parameter(Mandatory = $false)][string]$phonenumber,
        [Parameter(Mandatory = $false)][string]$email,
        [Parameter(Mandatory = $false)][string]$language,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()

    $actualOrganizationP = Get-PCOrganizationProfile -satoken $satoken

    if($companyName)     {$actualOrganizationP.companyName = $companyName}
    if($AddressLine1){$actualOrganizationP.defaultAddress.addressLine1 = $AddressLine1}
    if($city)        {$actualOrganizationP.defaultAddress.city = $city}
    if($state)       {$actualOrganizationP.defaultAddress.state = $state}
    if($postalcode)  {$actualOrganizationP.defaultAddress.postalCode = $postalcode}
    if($country)     {$actualOrganizationP.defaultAddress.country = $country}
    if($firstname)   {$actualOrganizationP.defaultAddress.firstName = $firstname}
    if($lastname)    {$actualOrganizationP.defaultAddress.lastName = $lastname}
    if($phonenumber) {$actualOrganizationP.defaultAddress.phoneNumber = $phonenumber}
    if($email)       {$actualOrganizationP.email = $email}
    if($language)    {$actualOrganizationP.language = $language}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/organization"
    $headers = @{Authorization="Bearer $satoken"}

    $body = $actualOrganizationP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Set-PCBillingProfile
{
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$country,
        [Parameter(Mandatory = $false)][string]$AddressLine1,
        [Parameter(Mandatory = $false)][string]$AddressLine2,
        [Parameter(Mandatory = $false)][string]$city,
        [Parameter(Mandatory = $false)][string]$state,
        [Parameter(Mandatory = $false)][string]$postalcode,
        [Parameter(Mandatory = $false)][string]$firstname,
        [Parameter(Mandatory = $false)][string]$lastname,
        [Parameter(Mandatory = $false)][string]$phonenumber,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken

        #read-only properties
        #$tax_id,$billingCurrency
    )
    _testTokenContext($satoken)

    $obj = @()

    $actualBillingP = Get-PCBillingProfile -satoken $satoken

    if($AddressLine1)    {$actualBillingP.address.addressLine1 = $AddressLine1}
    if($AddressLine2){$actualBillingP.address.addressLine2 = $AddressLine2}
    if($city)        {$actualBillingP.address.city = $city}
    if($state)       {$actualBillingP.address.state = $state}
    if($postalcode)  {$actualBillingP.address.postalCode = $postalcode}
    if($country)     {$actualBillingP.address.country = $country}
    if($firstname)   {$actualBillingP.primaryContact.firstName = $firstname}
    if($lastname)    {$actualBillingP.primaryContact.lastName = $lastname}
    if($phonenumber) {$actualBillingP.primaryContact.phoneNumber = $phonenumber}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/billing"
    $headers = @{Authorization="Bearer $satoken"}

    $body = $actualBillingP | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Set-PCSupportProfile
{
    [CmdletBinding()]
    param(
        #write properties
        [Parameter(Mandatory = $false)][string]$website,
        [Parameter(Mandatory = $false)][string]$email,
        [Parameter(Mandatory = $false)][string]$phone,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()

    $actualSupportProfile = Get-PCSupportProfile -satoken $satoken

    if($website){$actualSupportProfile.website = $website}
    if($email){$actualSupportProfile.email = $email}
    if($phone){$actualSupportProfile.telephone = $phone}

    $url = "https://api.partnercenter.microsoft.com/v1/profiles/support"
    $headers = @{Authorization="Bearer $satoken"}

    $body = $actualSupportProfile | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $utf8body #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Get-PCCustomerBillingProfile
{
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )

   _testTokenContext($satoken)
   _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/billing" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Set-PCCustomerBillingProfile
{
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
        [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$billingprofile,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/billing" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}
    $body = $billingprofile | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PUT" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function Get-PCCustomerCompanyProfile
{
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)
   _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/company" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Profile") 
}

function New-PCCustomerBillingProfile
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$FirstName,
        [Parameter(Mandatory = $true)][string]$LastName,
        [Parameter(Mandatory = $true)][string]$Email,
        [Parameter(Mandatory = $true)][string]$Culture,
        [Parameter(Mandatory = $true)][string]$Language,
        [Parameter(Mandatory = $true)][string]$CompanyName,
        [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$Country, 
        [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][string]$Region = $null,
        [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$City, 
        [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$State, 
        [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$AddressLine1,
        [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$PostalCode, 
        [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$PhoneNumber,
        [Parameter(ParameterSetName='DefaultAddress',Mandatory = $true)][DefaultAddress]$DefaultAddress
    )

    switch ($PsCmdlet.ParameterSetName)
    {
        'AllDetails'    { $billingProfile = [BillingProfile]::new($Email,$Culture,$Language,$CompanyName,$Country,$Region,$City,$State,$AddressLine1, `
                                                   $PostalCode, $FirstName, $LastName,  $PhoneNumber) }
        'DefaultAddress'{ $billingProfile = [BillingProfile]::new($FirstName, $LastName, $Email,$Culture,$Language,$CompanyName,$DefaultAddress)}
    }

    return $billingProfile
}

function New-PCCustomerDefaultAddress
{
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
    
    $DefaultAddress = [DefaultAddress]::new($Country, $Region, $City,$State,$AddressLine1,$PostalCode,$FirstName,$LastName,$PhoneNumber)
    return $DefaultAddress
}

function New-PCCustomerCompanyProfile
{   
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Domain
    )

    $companyProfile = [CompanyProfile]::new($Domain)
    return $companyProfile
}

function New-PCAddress
{
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
    
    $Address = [DefaultAddress]::new($Country, $Region, $City,$State,$AddressLine1,$PostalCode)
    if ($AddressLine2) {$Address.AddressLine2 = $AddressLine2}
    return $Address
}

function Test-PCAddress
{
    [CmdletBinding()]
    param ( [Parameter(ParameterSetName='ByObject',Mandatory = $true)][DefaultAddress] $Address,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $AddressLine1,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][string] $AddressLine2,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $City, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $State, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $PostalCode, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $country, 
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/validations/address"
    $headers  = @{"Authorization"="Bearer $satoken"}
    $headers += @{"MS-Contract-Version"="v1"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
  
    switch ($PsCmdlet.ParameterSetName)
    {
        'ByObject'   { $address_tmp = $Address}
        'AllDetails' { $address_tmp = [DefaultAddress]::new($Country, $Region, $City,$State,$AddressLine1,$PostalCode)}
    }
        
    $body = $address_tmp | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" #-Debug -Verbose    
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ValidationAddress")

}