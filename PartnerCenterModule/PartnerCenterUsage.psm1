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

function Get-PCUsage
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $true)][String]$subscriptionid,
        [Parameter(Mandatory = $true)][String]$start_time,
        [Parameter(Mandatory = $true)][String]$end_time,
        [Parameter(Mandatory = $false)][ValidateSet('daily', 'hourly')][String]$granularity = 'daily',
        [Parameter(Mandatory = $false)][bool]$show_details = $true,
        [Parameter(Mandatory = $false)][ValidateRange(1, 1000)] [int]$size = 1000,
        [Parameter(Mandatory = $false)][String]$tenantid = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)

    $retObject = Get-PCUsage_implementation -subscriptionid $subscriptionid -start_time $start_time -end_time $end_time -granularity $granularity -show_details $show_details -size $size -tenantid $tenantid -satoken $satoken

    return $retObject.Items
}

function Get-PCUsage2
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$subscriptionid,
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$start_time,
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$end_time,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][ValidateSet('daily', 'hourly')][String]$granularity = 'daily',
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][bool]$show_details = $true,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][ValidateRange(1, 1000)] [int]$size = 1000,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][String]$tenantid = $GlobalCustomerID,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][Parameter(Mandatory = $false, ParameterSetName = 'next')][string]$satoken = $GlobalToken,
        [Parameter(Mandatory = $true, ParameterSetName = 'next')]$continuationLink = $null)
    _testTokenContext($satoken)

    switch ($PsCmdlet.ParameterSetName)
    {
        "first"
        {
            _testTenantContext ($tenantid)
            $retObject = Get-PCUsage_implementation -subscriptionid $subscriptionid -start_time $start_time -end_time $end_time -granularity $granularity -show_details $show_details -size $size -tenantid $tenantid -satoken $satoken
        }
        "next"
        {
            $retObject = Get-PCUsage_implementation -satoken $satoken -continuationLink $continuationLink
        } 
    }

    return $retObject
}

function Get-PCUsage_implementation
{
    [CmdletBinding()]
    param ( [String]$subscriptionid,
        [String]$start_time,
        [String]$end_time,
        [String]$granularity,
        [bool]$show_details,
        [int]$size,
        [String]$tenantid,
        [string]$satoken,
        $continuationLink)
    
    $obj = @()

    $urlParts = @("https://api.partnercenter.microsoft.com/v1/")
    $headers = @{Authorization = "Bearer $satoken"}

    if ($continuationLink -eq $null)
    {
        try
        {
            $s_time = get-date $start_time -Format s
        }
        catch
        {
            "Start time is not in a valid format. Use '31-12-1999 00:00:00' format"
        }
    
        try
        {
            $e_time = get-date $end_time -Format s
        }
        catch
        {
            "End time is not in a valid format. Use '31-12-1999 00:00:00' format"
        }

        $urlParts += "Customers/{0}/Subscriptions/{1}/Utilizations/azure?start_time={2}Z&end_time={3}Z&show_details={4}&granularity={5}&size={6}" -f $tenantid, $subscriptionid, $s_time, $e_time, $show_details, $granularity, $size
    }
    else
    {
        if (Get-Member -inputobject $continuationLink -name "next" -Membertype Properties)
        {
            $urlParts += $continuationLink.next.uri
            
            foreach ($i in $continuationLink.next.headers)
            {
                $headers.Add($i.Key, $i.Value) 
            }
        }
        else
        {
            throw "Check the Count or Link properties before trying to retrieve the next set of records"
        }
    }

    $url = -join $urlParts    

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose

    $obj += $response.Substring(1) | ConvertFrom-Json

    $properties = @{
        'Count' = $obj[0].totalCount;
        'Items' = _formatResult -obj $obj -type "UtilizationRecord";
        'Links' = $obj[0].Links;
    }
    $retObject = New-Object –TypeName PSObject –Prop $properties
    return $retObject
}

function Get-PCSubscriptionMonthlyUsageRecords
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $tenantid
    $headers = @{Authorization = "Bearer $satoken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscriptionMonthlyUsageRecord")
}

# Adding non-plural noun version of cmdlet. Plural version of the cmdlet will be removed in future versions.
function Get-PCSubscriptionMonthlyUsageRecord
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $tenantid
    $headers = @{Authorization = "Bearer $satoken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscriptionMonthlyUsageRecord")
}

function Get-PCAzureResourceMonthlyUsageRecords
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$tenantid = $GlobalCustomerID, 
        [string]$subscriptionid,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/usagerecords/resources" -f $tenantid, $subscriptionid
    $headers = @{Authorization = "Bearer $satoken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}

# Adding non-plural noun version of cmdlet. Plural version of the cmdlet will be removed in future versions.
function Get-PCAzureResourceMonthlyUsageRecord
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$tenantid = $GlobalCustomerID, 
        [string]$subscriptionid,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/usagerecords/resources" -f $tenantid, $subscriptionid
    $headers = @{Authorization = "Bearer $satoken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}


function Get-PCCustomerUsageSummary
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)][String]$tenantid = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)

    $obj = @()  

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagesummary" -f $tenantid
    $headers = @{Authorization = "Bearer $satoken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUsageSummary") 
}

function Get-PCCustomerServiceCostSummary
{
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $true)][ValidateSet("MostRecent")][String]$BillingPeriod, #toAdd "Current","none" as soon as they're supported
        [Parameter(Mandatory = $false)][String]$tenantid = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )

    _testTokenContext($satoken)
    _testTenantContext ($tenantid)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/servicecosts/{1}" -f $tenantid, $BillingPeriod
    $headers = @{Authorization = "Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceCostsSummary") 
}
