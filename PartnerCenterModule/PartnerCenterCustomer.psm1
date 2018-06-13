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
TODO

.DESCRIPTION
The Get-PCCustomer cmdlet retrieves a list of customers, or a specific customer based on the input.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.PARAMETER TenantId 
The tenant Id assigned to the customer you want to retrieve.

.PARAMETER ResultSize 
Specifies the maximum number of results to return. The default value is 200.

.PARAMETER StartsWith 
Specifies a filter for the customer names returned.

.EXAMPLE
Return a list of customers for a partner.

Get-PCCustomer

.EXAMPLE
Return a customer by specifying an Id

$customer = Get-PCCustomer -TenantId '<tenant id GUID>'

.EXAMPLE
Return a customer by specifying part of the company name
Get-PCCustomer -StartsWith '<company name>'

.NOTES
You need to have a authentication credential already established before running this cmdlet.

#>
function Get-PCCustomer {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'TenantId', Mandatory = $false)][String]$TenantId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$StartsWith,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$ResultSize = 200,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken

    )
    _testTokenContext($SaToken)

    function Private:Get-CustomerInner ($SaToken, $TenantId) {
        $obj = @()

        if ($TenantId) {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $TenantId
             
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/customers"
            
        }

        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET"
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Customer")  
    }

    function Private:Search-CustomerInner ($SaToken, $StartsWith, $ResultSize) {
        $obj = @()

        [string]$filter = '{"Field":"CompanyName","Value":"' + $StartsWith + '","Operator":"starts_with"}'
        [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
        $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

        $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $ResultSize, $Encode

        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" 
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Customer")  
    }

    # replace the need to specify -all to retrieve all customers
    if ($PsCmdlet.ParameterSetName -eq "TenantId") {
        $res = Get-CustomerInner -SaToken $SaToken -TenantId $TenantId
        return $res
    }
    elseif ($PsCmdlet.ParameterSetName -eq "filter") {
        $res = Search-CustomerInner -SaToken $SaToken -StartsWith $StartsWith -ResultSize $ResultSize
        return $res
    }

}

<#
.SYNOPSIS
TODO

.DESCRIPTION
The Get-SubscribedSKU cmdlet. 

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.PARAMETER TenantId 
The tenant Id assigned to the customer you want to retrieve.

.EXAMPLE
Get-SubscribedSKU -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c

Return the subscribed SKUs for the specified TenantId
#>
function Get-PCSubscribedSKU {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscribedskus" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscribedSku")  
}

<#
.SYNOPSIS
Retrieves the spending budget for the specified tenant.
.DESCRIPTION
The Get-PCSpendingBudget cmdlet returns the spending budget set for the specified tenant.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.EXAMPLE
Get-PCSpendingBudget -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c
.NOTES
#>
function Get-PCSpendingBudget {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagebudget" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SpendingBudget")  
}

<#
.SYNOPSIS
Updates the spending budget for the specified tenant.
.DESCRIPTION
The Set-PCSpendingBudget cmdlet sets a spending budget for the specified tenant.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant for which to set the spending budget
.PARAMETER SpendingBudget 
Specifies the spending budget in the default currency for the partner.
.EXAMPLE
Set-PCSpendingBudget -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c -SpendingBudget 3000
Sets the spending budget to 3000 USD
.NOTES
#>
function Set-PCSpendingBudget {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $true)][String]$SpendingBudget,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagebudget" -f $TenantId
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $spendingBudget_tmp = [SpendingBudget]::new($spendingBudget)
    $body = $spendingBudget_tmp | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return  (_formatResult -obj $obj -type "CustomerSpendingBudget")  
}

<#
.SYNOPSIS
Creates a new customer.
.DESCRIPTION
The New-PCCustomer cmdlet creates a new customer for the current partner.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.PARAMETER Email 
Specifies the contact email address for the new customer.
.PARAMETER Culture
Specifies the culture for the new customer as an three letter ISO 3 country code.
.PARAMETER Language
Specifies the default language for the new customer.

.PARAMETER CompanyName
Specifies the company name for the new customer.
.PARAMETER Country
Specifies the country name for the new customer. The country must be valid for the current partner.
.PARAMETER Region
Specifies the region for the new customer.
.PARAMETER City
Specifies the city address for the new customer.
.PARAMETER State
Specifies the state address for the new customer.
.PARAMETER AddressLine1
Specifies the first line of the address for the new customer.
.PARAMETER PostalCode
Specifies the postal code, if needed, for the new customer.
.PARAMETER FirstName
Specifies the the new customer's contact's first name.
.PARAMETER LastName
Specifies the the new customer's contact's last name.
.PARAMETER PhoneNumber
Specifies the the new customer's contact's phone number.
.PARAMETER BillingProfile
Specifies the billing profile.
.PARAMETER CompanyProfile
Specifies a company profile.
.PARAMETER Domain
Specifies the onmicrosoft.com for the new customer tenant.
.EXAMPLE
$newDefaultAddress = New-PCCustomerDefaultAddress -Country '<Country code>' -Region '<region>' -City '<City>' -State '<State>' -AddressLine1 '<address1>' -PostalCode '<postal code>' -FirstName '<first name>' -LastName '<last name>' -PhoneNumber '<phone number>'
$newBillingProfile = New-PCCustomerBillingProfile -FirstName '<first name>' -LastName '<last name>' -Email '<Email>' -Culture '<ex: en.us>' -Language '<ex: en>' -CompanyName '<company name>' -DefaultAddress $newDefaultAddress
$newCompanyProfile = New-PCCustomerCompanyProfile -Domain '<company name>.onmicrosoft.com'
$newCustomer = New-PCCustomer -BillingProfile $newBillingProfile -CompanyProfile $newCompanyProfile

Create a new customer.
.NOTES
#>
function New-PCCustomer {
    [CmdletBinding()]

    param ( [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$Email,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Culture,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Language,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $CompanyName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Country, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Region, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $City, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $State, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $AddressLine1,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $PostalCode, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $FirstName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $LastName, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $PhoneNumber,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Domain,
        [Parameter(ParameterSetName = 'ByProfiles', Mandatory = $true)][BillingProfile] $BillingProfile,
        [Parameter(ParameterSetName = 'ByProfiles', Mandatory = $true)][CompanyProfile] $CompanyProfile, 
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers"
   
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
  
    switch ($PsCmdlet.ParameterSetName) {
        'AllDetails' {
            $customer = [Customer]::new($Email, $Culture, $Language, $CompanyName, $Country, $region, $City, $State, $AddressLine1, `
                    $PostalCode, $FirstName, $LastName, $PhoneNumber, $Domain) 
        }
        'ByProfiles' { $customer = [Customer]::new($BillingProfile, $CompanyProfile)}
    }
        
    $body = $customer | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "POST" #-Debug -Verbose    
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")
}

<#
.SYNOPSIS
Removes a customer from the Partner Center integration sandbox.

.DESCRIPTION
The Remove-PCCCustomer cmdlet removes a customer from the integration sandbox.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.

.EXAMPLE
Remove-PCCustomer -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c

.NOTES
#>
function Remove-PCCustomer {
    [CmdletBinding()]
    param (
        $TenantId, 
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = try {
        Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
    }
    catch {
        $_.Exception.Response
    }

    return ($response)  
}

<#
.SYNOPSIS
Returns a list of managed services.
.DESCRIPTION
The Get-PCManagedService cmdlet returns a list of managed services for the specified 
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.EXAMPLE
Get-PCManagedService -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c
Return a list of managed services for the specified tenant.

.NOTES
#>
function Get-PCManagedService {    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/managedservices" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ManagedServices")  
}


<#
.SYNOPSIS
Selects a customer to be used in other cmdlets.
.DESCRIPTION
The Select-PCCustomer cmdlet selects a customer tenant specified by the tenant id.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.EXAMPLE
Select-PCCustomer -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c

.NOTES
#>
function Select-PCCustomer {
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'TenantId', Mandatory = $true)][String]$TenantId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json

    #setting SAToken variable as global
    Set-Variable -Name "GlobalCustomerID" -Value $obj.id -Scope Global

    return (_formatResult -obj $obj -type "Customer") 
}

<#
.SYNOPSIS
Returns the type of relationship the specified tenant has with the current partner for an indirect partner.
.DESCRIPTION
The Get-PCCustomerRelationship cmdlet returns the relationship the specified customer has with the current partner. This cmdlet can only be used for an indirect partner.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.EXAMPLE
Get-PCCustomerRelationship -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c
.NOTES
This can only be used in an indirect model.
#>
function Get-PCCustomerRelationship {    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/relationships" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerRelationship")
}


<#
.SYNOPSIS
Returns a list of reseller customers for the specified indirect provider.

.DESCRIPTION
The Get-PCResellerCustomer cmdlet returns a list of reseller customers or a specified reseller for the current indirect provider.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER ResellerId 
Specifies the reseller id for which to return customers.
.PARAMETER ResultSize 
Specifies the maximum number of results to return. The default value is 200.
.EXAMPLE
Get-PCResellerCustomer -ResellerId '86f61a80-23de-4071-ba9f-249254da7e95'
Return a list of customers for the specified reseller id
.NOTES
#>
function Get-PCResellerCustomer {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$ResellerId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$ResultSize= 200,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    [string]$filter = '{"Field":"IndirectReseller","Value":"' + $ResellerId + '","Operator":"starts_with"}'
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

    $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $ResultSize, $Encode

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")  
}