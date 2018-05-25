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
Retrieves a list of customers.

.DESCRIPTION
The Get-PCCustomer cmdlet retrieves a list of customers, or a specific customer based on the input.

.PARAMETER saToken 
The authentication token you have created with your Partner Center credentials.

.PARAMETER tenantId 
The tenant Id assigned to the customer you want to retrieve.

.PARAMETER filter 
A filter specified to limit the number of customers returned.

.PARAMETER all 
This switch does not do anything, but is still included for backward compatability.

.EXAMPLE
Return a list of customers for a partner.

Get-PCCustomer

.NOTES
You need to have a authentication credential already established before running this cmdlet.

#>
function Get-PCCustomer {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'tenantId', Mandatory = $false)][String]$tenantId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$startswith,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$size = 200,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken, 
        [Parameter(Mandatory = $false)][switch]$all
    )
    _testTokenContext($saToken)

    function Private:Get-CustomerInner ($saToken, $tenantId) {
        $obj = @()

        if ($tenantId) {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $tenantId
            $headers = @{Authorization = "Bearer $saToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Customer")  
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/customers"
            $headers = @{Authorization = "Bearer $saToken"}
    
            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Customer")  
        }
    }

    function Private:Search-CustomerInner ($saToken, $startswith, $size) {
        $obj = @()

        [string]$filter = '{"Field":"CompanyName","Value":"' + $startswith + '","Operator":"starts_with"}'
        [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
        $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

        $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $size, $Encode
        $headers = @{Authorization = "Bearer $saToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Customer")  
    }

    if ($all) { Write-Warning "  The All switch is no longer required to return a list of all the customers. It is included for backward compatiblity and will be removed in future versions."}

    # replace the need to specify -all to retrieve all customers
    if ($PsCmdlet.ParameterSetName -eq "tenantId") {
        $res = Get-CustomerInner -saToken $saToken -tenantId $tenantId
        return $res
    }
    elseif ($PsCmdlet.ParameterSetName -eq "filter") {
        $res = Search-CustomerInner -saToken $saToken -startswith $startswith -size $size
        return $res
    }

}

function Get-PCSubscribedSKUs {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    Write-Warning "  Get-PCSubscribedSKUs is deprecated and will not be available in future releases, use Get-PCSubscribedSKU instead."

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscribedskus" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscribedSku")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCSubscribedSKU {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscribedskus" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscribedSku")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCSpendingBudget {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagebudget" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SpendingBudget")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER spendingBudget 

.EXAMPLE

.NOTES
#>
function Set-PCSpendingBudget {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        $spendingBudget,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagebudget" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}
    $spendingBudget_tmp = [SpendingBudget]::new($spendingBudget)
    $body = $spendingBudget_tmp | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return  (_formatResult -obj $obj -type "CustomerSpendingBudget")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER email 

.PARAMETER culture

.PARAMETER language

.PARAMETER culture

.PARAMETER companyName

.PARAMETER country

.PARAMETER region

.PARAMETER city

.PARAMETER state

.PARAMETER addressLine1

.PARAMETER postalCode

.PARAMETER firstName

.PARAMETER lastName

.PARAMETER phoneNumber

.PARAMETER billingProfile

.PARAMETER companyProfile

.EXAMPLE

.NOTES
#>
function New-PCCustomer {
    [CmdletBinding()]

    param ( [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$Email,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Culture,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Language,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $CompanyName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $country, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $region, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $city, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $state, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $addressLine1,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $postalCode, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $FirstName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $LastName, 
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $PhoneNumber,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string] $Domain,
        [Parameter(ParameterSetName = 'ByProfiles', Mandatory = $true)][BillingProfile] $BillingProfile,
        [Parameter(ParameterSetName = 'ByProfiles', Mandatory = $true)][CompanyProfile] $CompanyProfile, 
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers"
    $headers = @{"Authorization" = "Bearer $saToken"}
    $headers += @{"MS-Contract-Version" = "v1"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}
    
    switch ($PsCmdlet.ParameterSetName) {
        'AllDetails' {
            $customer = [Customer]::new($Email, $Culture, $Language, $CompanyName, $country, $region, $city, $state, $addressLine1, `
                    $postalCode, $FirstName, $LastName, $PhoneNumber, $Domain) 
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

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 


.EXAMPLE

.NOTES
#>
function Remove-PCCustomer {
    [CmdletBinding()]
    param (
        $tenantId, 
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
        )
    _testTokenContext($saToken)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $tenantId
    $headers = @{"Authorization" = "Bearer $saToken"}

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
    param ([Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    Write-Warning "  Get-PCManagedServices is deprecated and will not be available in future releases, use Get-PCManagedService instead."

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/managedservices" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ManagedServices")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCManagedService {    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/managedservices" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ManagedServices")  
}


<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Select-PCCustomer {
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'tenantId', Mandatory = $true)][String]$tenantId,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json

    #setting SAToken variable as global
    Set-Variable -Name "GlobalCustomerID" -Value $obj.id -Scope Global

    return (_formatResult -obj $obj -type "Customer") 
}

function Get-PCCustomerRelationships {    
    [CmdletBinding()]
    param ([
        Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    Write-Warning "  Get-PCCustomerRelationships is deprecated and will not be available in future releases, use Get-PCCustomerRelationship instead."

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/relationships" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerRelationship")
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerRelationship {    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
        )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/relationships" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerRelationship")
}

function Get-PCResellerCustomers {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$resellerId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$size = 200,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    Write-Warning "  Get-PCResellerCustomers is deprecated and will not be available in future releases, use Get-PCResellerCustomer instead."
    $obj = @()

    [string]$filter = '{"Field":"IndirectReseller","Value":"' + $resellerId + '","Operator":"starts_with"}'
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

    $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $size, $Encode
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER resellerId 

.PARAMETER size 

.EXAMPLE

.NOTES
#>
function Get-PCResellerCustomer {
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName = 'filter', Mandatory = $true)][String]$resellerId,
        [Parameter(ParameterSetName = 'filter', Mandatory = $false)][int]$size = 200,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)

    $obj = @()

    [string]$filter = '{"Field":"IndirectReseller","Value":"' + $resellerId + '","Operator":"starts_with"}'
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

    $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $size, $Encode
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")  
}