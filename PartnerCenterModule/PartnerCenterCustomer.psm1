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
Import-Module -FullyQualifiedName "$here\PartnerCenterTelemetry.psm1"

function Get-PCCustomer
{
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName='all', Mandatory = $false)][switch]$all,
        [Parameter(ParameterSetName='tenantid', Mandatory = $false)][String]$tenantid,
        [Parameter(ParameterSetName='filter', Mandatory = $true)][String]$startswith,
        [Parameter(ParameterSetName='filter',Mandatory = $false)][int]$size = 200,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
   _testTokenContext($satoken)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    function Private:Get-CustomerAllInner ($satoken)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers"
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Customer")      
    }

    function Private:Get-CustomerInner ($satoken,$tenantid)
    {
        $obj = @()

        if ($tenantid)
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $tenantid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Customer")  
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers"
            $headers = @{Authorization="Bearer $satoken"}
    
            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Customer")  
        }
    }

    function Private:Search-CustomerInner ($satoken, $startswith, $size)
    {
        $obj = @()

        [string]$filter = '{"Field":"CompanyName","Value":"' + $startswith + '","Operator":"starts_with"}'
        [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
        $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

        $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $size,$Encode
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Customer")  
    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "tenantid" {$res = Get-CustomerInner -satoken $satoken -tenantid $tenantid
                    return $res}

        "filter"  {$res = Search-CustomerInner -satoken $satoken -startswith $startswith -size $size
                   return $res}
        "all"     {$res = Get-CustomerAllInner -satoken $satoken
                    return $res}
    }
}

function Get-PCSubscribedSKUs
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscribedskus" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscribedSku")  
}

function Get-PCSpendingBudget
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagebudget" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SpendingBudget")  
}
function Set-PCSpendingBudget
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            $spendingbudget,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagebudget" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}
    $spendingbudget_tmp = [SpendingBudget]::new($spendingbudget)
    $body = $spendingbudget_tmp | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return  (_formatResult -obj $obj -type "CustomerSpendingBudget")  
}

function New-PCCustomer
{
    [CmdletBinding()]

    param ( [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$Email,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $Culture,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $Language,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $CompanyName,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $Country, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $Region, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $City, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $State, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $AddressLine1,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $PostalCode, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $FirstName,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $LastName, 
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $PhoneNumber,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string] $Domain,
            [Parameter(ParameterSetName='ByProfiles',Mandatory = $true)][BillingProfile] $BillingProfile,
            [Parameter(ParameterSetName='ByProfiles',Mandatory = $true)][CompanyProfile] $CompanyProfile, 
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers"
    $headers  = @{"Authorization"="Bearer $satoken"}
    $headers += @{"MS-Contract-Version"="v1"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    
    switch ($PsCmdlet.ParameterSetName)
    {
        'AllDetails' { $customer = [Customer]::new($Email, $Culture, $Language, $CompanyName, $Country, $Region, $City, $State, $AddressLine1, `
                                                   $PostalCode, $FirstName, $LastName, $PhoneNumber, $Domain) }
        'ByProfiles' { $customer = [Customer]::new($BillingProfile, $CompanyProfile)}
    }
        
    $body = $customer | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "POST" #-Debug -Verbose    
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")
}

function Remove-PCCustomer 
{
    [CmdletBinding()]
    param ($tenantid,         [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $tenantid
    $headers  = @{"Authorization"="Bearer $satoken"}

    $response = try
                {
                    Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
                }
                catch
                {
                    $_.Exception.Response
                }

    return ($response)  
}

function Get-PCManagedServices
{    
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/managedservices" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ManagedServices")  
}


function Select-PCCustomer
{
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName='tenantid', Mandatory = $true)][String]$tenantid,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
      _testTokenContext($satoken)
      Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json

    #setting SAToke variable as global
    Set-Variable -Name "GlobalCustomerID" -Value $obj.id -Scope Global

    return (_formatResult -obj $obj -type "Customer") 
}



function Get-PCCustomerRelationships
{    
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/relationships" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $obj = @()
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerRelationship")
}



function Get-PCResellerCustomers
{
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName='filter', Mandatory = $true)][String]$resellerId,
        [Parameter(ParameterSetName='filter', Mandatory = $false)][int]$size = 200,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
   _testTokenContext($satoken)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    [string]$filter = '{"Field":"IndirectReseller","Value":"' + $resellerId + '","Operator":"starts_with"}'
    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

    $url = "https://api.partnercenter.microsoft.com/v1/customers?size={0}&filter={1}" -f $size,$Encode
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Customer")  
}
