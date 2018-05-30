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
Blank

.DESCRIPTION
The Get-PCCustomer cmdlet retrieves a list of customers, or a specific customer based on the input.

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.PARAMETER TenantId 
The tenant Id assigned to the customer you want to retrieve.

.PARAMETER Filter 
A filter specified to limit the number of customers returned.

.PARAMETER StartsWith 
This switch does not do anything, but is still included for backward compatability.
.PARAMETER All 
This switch does not do anything, but is still included for backward compatability.

.EXAMPLE
Get-PCCustomer

Return a list of customers for a partner.

.NOTES
You need to have a authentication Credential already established before running this cmdlet.

#>
function Get-PCCustomer {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'TenantId', Mandatory = $false)][String]$TenantId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$StartsWith,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$Size = 200,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken, 
        [Parameter(Mandatory = $false)][switch]$All
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

    function Private:Search-CustomerInner ($SaToken, $StartsWith, $Size) {
        $obj = @()

        [string]$filter = '{"Field":"CompanyName","Value":"' + $StartsWith + '","Operator":"starts_with"}'
        [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
        $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

        $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $Size, $Encode

        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" 
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Customer")  
    }

    if ($all) { Write-Warning "  The All switch is no longer required to return a list of all the customers. It is included for backward compatiblity and will be removed in future versions."}

    # replace the need to specify -all to retrieve all customers
    if ($PsCmdlet.ParameterSetName -eq "TenantId") {
        $res = Get-CustomerInner -SaToken $SaToken -TenantId $TenantId
        return $res
    }
    elseif ($PsCmdlet.ParameterSetName -eq "filter") {
        $res = Search-CustomerInner -SaToken $SaToken -StartsWith $StartsWith -Size $Size
        return $res
    }

}

function Get-PCSubscribedSKUs {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    Write-Warning "  Get-PCSubscribedSKUs is deprecated and will not be available in future releases, use Get-PCSubscribedSKU instead."

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
Blank

.DESCRIPTION
The Get-SusbscribedSKU cmdlet. 

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.PARAMETER TenantId 
The tenant Id assigned to the customer you want to retrieve.

.EXAMPLE
Get-SubscribedSKU -TenantId XXXXXXXXXXXXXXXX

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


.DESCRIPTION

.PARAMETER SaToken 
Specifies the authentication token you have created with your Partner Center credentials.

.PARAMETER TenantId 

.EXAMPLE

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
Blank
.DESCRIPTION
The Set-PCSpendingBudget cmdlet sets a spending budged for the specified tenant.
.PARAMETER SaToken 
Specifies the authentication token you have created with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant for which to set the spending budget
.PARAMETER SpendingBudget 
Specifies the spending budget in the default currency for the partner.
.EXAMPLE
Set-PCSpendingBudget -TenantId XXXXXXXXXXXXXXXX -SpendingBudge 3000

Sets the spending budget to 3000 USD
.NOTES
None
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
Specifies the authentication token you have created with your Partner Center credentials.

.PARAMETER Email 

.PARAMETER Culture

.PARAMETER Language

.PARAMETER Culture

.PARAMETER CompanyName

.PARAMETER Country

.PARAMETER Region

.PARAMETER City

.PARAMETER State

.PARAMETER AddressLine1

.PARAMETER PostalCode

.PARAMETER FirstName

.PARAMETER LastName

.PARAMETER PhoneNumber

.PARAMETER BillingProfile

.PARAMETER CompanyProfile

.EXAMPLE

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
Removes a customer from partner center

.DESCRIPTION
The Remove-PCCCustomer cmdlet removes a customer from being managed from the current partner.

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 


.EXAMPLE
Remove-PCCustomer

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

function Get-PCManagedServices {    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    Write-Warning "  Get-PCManagedServices is deprecated and will not be available in future releases, use Get-PCManagedService instead."

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
Returns a list of managed services
.DESCRIPTION
The Get-PCManagedService 
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.EXAMPLE
Get-PCManagedService

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
Selectes a customer to be used in other cmdlets.
.DESCRIPTION
The Select-PCCustomer cmdlet selects a customer tenant specified by the tenant id.
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.EXAMPLE
Select-PCCustomer -TenantId XXXXXXXXXX

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

function Get-PCCustomerRelationships {    
    [CmdletBinding()]
    param ([
        Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    Write-Warning "  Get-PCCustomerRelationships is deprecated and will not be available in future releases, use Get-PCCustomerRelationship instead."

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
Returns the type of relationship the specified tenant has with the current partner.
.DESCRIPTION
The Get-PCCustomerRelationship cmdlet returns the relationship the specified customer has with the current partner.
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.EXAMPLE
Get-PCCustomerRelationship -TenantId XXXXXXXXXXXXX


.NOTES
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

function Get-PCResellerCustomers {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$ResellerId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$Size = 200,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    Write-Warning "  Get-PCResellerCustomers is deprecated and will not be available in future releases, use Get-PCResellerCustomer instead."
    $obj = @()

    [string]$filter = '{"Field":"IndirectReseller","Value":"' + $ResellerId + '","Operator":"starts_with"}'
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

    $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $Size, $Encode

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")  
}

<#
.SYNOPSIS
Returns a list of reseller customers for the current indirect provider.

.DESCRIPTION
The Get-PCResllerCustomer cmdlet returns a list of reseller customers or a speficied reseller for the current indirect provider.
.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER ResellerId 

.PARAMETER Size 

.EXAMPLE

.NOTES
#>
function Get-PCResellerCustomer {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$ResellerId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$Size = 200,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    [string]$filter = '{"Field":"IndirectReseller","Value":"' + $ResellerId + '","Operator":"starts_with"}'
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

    $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $Size, $Encode

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")  
}