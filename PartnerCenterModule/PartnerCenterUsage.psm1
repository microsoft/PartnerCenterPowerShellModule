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

.PARAMETER tenantId 

.PARAMETER subscriptionId 

.PARAMETER startTime 

.PARAMETER endTime 

.PARAMETER granularity 

.PARAMETER showDetails 

.PARAMETER size 

.EXAMPLE

.NOTES
#>
function Get-PCUsage
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $true)][String]$subscriptionId,
        [Parameter(Mandatory = $true)][String]$startTime,
        [Parameter(Mandatory = $true)][String]$endTime,
        [Parameter(Mandatory = $false)][ValidateSet('daily', 'hourly')][String]$granularity = 'daily',
        [Parameter(Mandatory = $false)][bool]$showDetails = $true,
        [Parameter(Mandatory = $false)][ValidateRange(1, 1000)] [int]$size = 1000,
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $retObject = Get-PCUsage_implementation -subscriptionid $subscriptionId -startTime $startTime -endTime $endTime -granularity $granularity -showDetails $showDetails -size $size -tenantId $tenantId -saToken $saToken

    return $retObject.Items
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER subscriptionId 

.PARAMETER startTime 

.PARAMETER endTime 

.PARAMETER granularity 

.PARAMETER showDetails 

.PARAMETER size 

.PARAMETER continuationLink 

.EXAMPLE

.NOTES
#>
function Get-PCUsage2
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$subscriptionId,
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$startTime,
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$endTime,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][ValidateSet('daily', 'hourly')][String]$granularity = 'daily',
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][bool]$showDetails = $true,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][ValidateRange(1, 1000)] [int]$size = 1000,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][Parameter(Mandatory = $false, ParameterSetName = 'next')][string]$saToken = $GlobalToken,
        [Parameter(Mandatory = $true, ParameterSetName = 'next')]$continuationLink = $null
        )
    _testTokenContext($saToken)

    switch ($PsCmdlet.ParameterSetName)
    {
        "first"
        {
            _testTenantContext ($tenantId)
            $retObject = Get-PCUsage_implementation -subscriptionid $subscriptionId -startTime $startTime -endTime $endTime -granularity $granularity -showDetails $showDetails -size $size -tenantId $tenantId -saToken $saToken
        }
        "next"
        {
            $retObject = Get-PCUsage_implementation -saToken $saToken -continuationLink $continuationLink
        } 
    }

    return $retObject
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER subscriptionId 

.PARAMETER startTime 

.PARAMETER endTime 

.PARAMETER granularity 

.PARAMETER showDetails 

.PARAMETER size 

.PARAMETER continuationLink 

.EXAMPLE

.NOTES
#>
function Get-PCUsage_implementation
{
    [CmdletBinding()]
    param ( [String]$subscriptionId,
        [String]$startTime,
        [String]$endTime,
        [String]$granularity,
        [bool]$showDetails,
        [int]$size,
        [String]$tenantId,
        [string]$saToken,
        $continuationLink)
    
    $obj = @()

    $urlParts = @("https://api.partnercenter.microsoft.com/v1/")
    $headers = @{Authorization = "Bearer $saToken"}

    if ($continuationLink -eq $null)
    {
        try
        {
            $s_time = get-date $startTime -Format s
        }
        catch
        {
            "Start time is not in a valid format. Use '31-12-1999 00:00:00' format"
        }
    
        try
        {
            $e_time = get-date $endTime -Format s
        }
        catch
        {
            "End time is not in a valid format. Use '31-12-1999 00:00:00' format"
        }

        $urlParts += "Customers/{0}/Subscriptions/{1}/Utilizations/azure?start_time={2}Z&end_time={3}Z&show_details={4}&granularity={5}&size={6}" -f $tenantId, $subscriptionId, $s_time, $e_time, $showDetails, $granularity, $size
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
    param ([Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    Write-Warning "  Get-PCSubscriptionMonthlyUsageRecords is deprecated and will not be available in future releases, use Get-PCSubscriptionMonthlyUsageRecord instead."

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscriptionMonthlyUsageRecord")
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCSubscriptionMonthlyUsageRecord
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
        )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}
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
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID, 
        [string]$subscriptionId,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken)
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)
    
    Write-Warning "  Get-PCAzureResourceMonthlyUsageRecords is deprecated and will not be available in future releases, use Get-PCAzureResourceMonthlyUsageRecord instead."

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/usagerecords/resources" -f $tenantId, $subscriptionId
    $headers = @{Authorization = "Bearer $saToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER subscriptionId 

.EXAMPLE

.NOTES
#>
function Get-PCAzureResourceMonthlyUsageRecord
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID, 
        [string]$subscriptionId,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
        )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/usagerecords/resources" -f $tenantId, $subscriptionId
    $headers = @{Authorization = "Bearer $saToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerUsageSummary
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
        
        )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()  

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagesummary" -f $tenantId
    $headers = @{Authorization = "Bearer $saToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUsageSummary") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER billingPeriod 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerServiceCostSummary
{
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $true)][ValidateSet("MostRecent")][String]$billingPeriod, #toAdd "Current","none" as soon as they're supported
        [Parameter(Mandatory = $false)][String]$tenantId = $GlobalCustomerID,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )

    _testTokenContext($saToken)
    _testTenantContext ($tenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/servicecosts/{1}" -f $tenantId, $billingPeriod
    $headers = @{Authorization = "Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceCostsSummary") 
}
