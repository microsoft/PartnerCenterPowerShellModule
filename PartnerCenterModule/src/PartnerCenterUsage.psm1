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

function Get-PCUsage
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $true)][String]$subscriptionid,
            [Parameter(Mandatory = $true)][String]$start_time,
            [Parameter(Mandatory = $true)][String]$end_time,
            [Parameter(Mandatory = $false)][ValidateSet('daily','hourly')][String]$granularity = 'daily',
            [Parameter(Mandatory = $false)][bool]$show_details = $true,
            [Parameter(Mandatory = $false)][ValidateRange(1,1000)] [int]$size = 1000,
            [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    try{
        $s_time = get-date $start_time -Format s
    }
    catch
    {
        "Start time is not in a valid format. Use '31-12-1999 00:00:00' format"
    }

    try{
        $e_time = get-date $end_time -Format s
    }
    catch
    {
        "End time is not in a valid format. Use '31-12-1999 00:00:00' format"
    }

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/Subscriptions/{1}/Utilizations/azure?start_time={2}Z&end_time={3}Z&show_details={4}&granularity={5}&size={6}" -f $tenantid, $subscriptionid,$s_time,$e_time,$show_details,$granularity,$size
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose

    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "UtilizationRecord") 
}


function Get-PCSubscriptionMonthlyUsageRecords
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscriptionMonthlyUsageRecord")
}

function GetPCAzureResourceMonthlyUsageRecords
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID, 
        [string]$subscriptionid,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/usagerecords/resources" -f $tenantid, $subscriptionid
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}

function Get-PCustomerUsageSummary
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()  

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagesummary" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUsageSummary") 
}

function Get-PCCustomerServiceCostSummary
{
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $true)][ValidateSet("MostRecent")][String]$BillingPeriod, #toAdd "Current","none" as soon as they're supported
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )

   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/servicecosts/{1}" -f $tenantid,$BillingPeriod
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceCostsSummary") 
}
