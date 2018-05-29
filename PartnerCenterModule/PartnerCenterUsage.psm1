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
.PARAMETER TenantId 

.PARAMETER SubscriptionId 

.PARAMETER StartTime 

.PARAMETER EndTime 

.PARAMETER Granularity 

.PARAMETER ShowDetails 

.PARAMETER Size 

.EXAMPLE

.NOTES
#>
function Get-PCUsage
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $true)][String]$SubscriptionId,
        [Parameter(Mandatory = $true)][String]$StartTime,
        [Parameter(Mandatory = $true)][String]$EndTime,
        [Parameter(Mandatory = $false)][ValidateSet('daily', 'hourly')][String]$Granularity = 'daily',
        [Parameter(Mandatory = $false)][bool]$ShowDetails = $true,
        [Parameter(Mandatory = $false)][ValidateRange(1, 1000)] [int]$Size = 1000,
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $retObject = Get-PCUsage_implementation -Subscriptionid $SubscriptionId -StartTime $startTime -EndTime $endTime -Granularity $granularity -ShowDetails $showDetails -Size $size -TenantId $TenantId -SaToken $SaToken

    return $retObject.Items
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER SubscriptionId 

.PARAMETER StartTime 

.PARAMETER EndTime 

.PARAMETER Granularity 

.PARAMETER ShowDetails 

.PARAMETER Size 

.PARAMETER ContinuationLink 

.EXAMPLE

.NOTES
#>
function Get-PCUsage2
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$SubscriptionId,
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$StartTime,
        [Parameter(Mandatory = $true, ParameterSetName = 'first')][String]$EndTime,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][ValidateSet('daily', 'hourly')][String]$Granularity = 'daily',
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][bool]$ShowDetails = $true,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][ValidateRange(1, 1000)] [int]$Size = 1000,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false, ParameterSetName = 'first')][Parameter(Mandatory = $false, ParameterSetName = 'next')][string]$SaToken = $GlobalToken,
        [Parameter(Mandatory = $true, ParameterSetName = 'next')]$ContinuationLink = $null
        )
    _testTokenContext($SaToken)

    switch ($PsCmdlet.ParameterSetName)
    {
        "first"
        {
            _testTenantContext ($TenantId)
            $retObject = Get-PCUsage_implementation -Subscriptionid $SubscriptionId -StartTime $startTime -EndTime $endTime -Granularity $granularity -ShowDetails $showDetails -Size $size -TenantId $TenantId -SaToken $SaToken
        }
        "next"
        {
            $retObject = Get-PCUsage_implementation -SaToken $SaToken -ContinuationLink $continuationLink
        } 
    }

    return $retObject
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER SubscriptionId 

.PARAMETER StartTime 

.PARAMETER EndTime 

.PARAMETER Granularity 

.PARAMETER ShowDetails 

.PARAMETER Size 

.PARAMETER ContinuationLink 

.EXAMPLE

.NOTES
#>
function Get-PCUsage_implementation
{
    [CmdletBinding()]
    param ( [String]$SubscriptionId,
        [String]$StartTime,
        [String]$EndTime,
        [String]$Granularity,
        [bool]$ShowDetails,
        [int]$Size,
        [String]$TenantId,
        [string]$SaToken,
        $ContinuationLink)
    
    $obj = @()

    $urlParts = @("https://api.partnercenter.microsoft.com/v1/")
    $headers = @{Authorization = "Bearer $SaToken"}

    if ($ContinuationLink -eq $null)
    {
        try
        {
            $s_time = get-date $StartTime -Format s
        }
        catch
        {
            "Start time is not in a valid format. Use '31-12-1999 00:00:00' format"
        }
    
        try
        {
            $e_time = get-date $EndTime -Format s
        }
        catch
        {
            "End time is not in a valid format. Use '31-12-1999 00:00:00' format"
        }

        $urlParts += "Customers/{0}/Subscriptions/{1}/Utilizations/azure?start_time={2}Z&end_time={3}Z&show_details={4}&granularity={5}&size={6}" -f $TenantId, $SubscriptionId, $s_time, $e_time, $showDetails, $granularity, $size
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
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    Write-Warning "  Get-PCSubscriptionMonthlyUsageRecords is deprecated and will not be available in future releases, use Get-PCSubscriptionMonthlyUsageRecord instead."

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $TenantId
    $headers = @{Authorization = "Bearer $SaToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscriptionMonthlyUsageRecord")
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.EXAMPLE

.NOTES
#>
function Get-PCSubscriptionMonthlyUsageRecord
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $TenantId
    $headers = @{Authorization = "Bearer $SaToken"}
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
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId, 
        [string]$SubscriptionId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)
    
    Write-Warning "  Get-PCAzureResourceMonthlyUsageRecords is deprecated and will not be available in future releases, use Get-PCAzureResourceMonthlyUsageRecord instead."

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/usagerecords/resources" -f $TenantId, $SubscriptionId
    $headers = @{Authorization = "Bearer $SaToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER SubscriptionId 

.EXAMPLE

.NOTES
#>
function Get-PCAzureResourceMonthlyUsageRecord
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId, 
        [string]$SubscriptionId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/usagerecords/resources" -f $TenantId, $SubscriptionId
    $headers = @{Authorization = "Bearer $SaToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerUsageSummary
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        
        )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()  

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagesummary" -f $TenantId
    $headers = @{Authorization = "Bearer $SaToken"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUsageSummary") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER BillingPeriod 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerServiceCostSummary
{
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $true)][ValidateSet("MostRecent")][String]$BillingPeriod, #toAdd "Current","none" as soon as they're supported
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )

    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/servicecosts/{1}" -f $TenantId, $BillingPeriod
    $headers = @{Authorization = "Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceCostsSummary") 
}
