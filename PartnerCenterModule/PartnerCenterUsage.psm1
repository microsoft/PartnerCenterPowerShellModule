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
Retrieve a collection of usage records for the specified date range. Usage records are only available for the last 90 days.
.DESCRIPTION
The Get-PCUsage cmdlet returns the usage records specified by the start and end times.
.PARAMETER SaToken 
Specifies a authentication token you have created with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER SubscriptionId 
Specifies a subscription if for which to return usage information.
.PARAMETER StartTime 
Specifies the start time for which to retrieve usage information. Usage is only available for the last 90 days, therefore this value cannot be more than 90 days from the current date.
.PARAMETER EndTime 
Specifies the end time for which to retrieve usage information.
.PARAMETER Granularity 
Specifies the granularity of the data to return. Valid values are: daily or hourly. The default value is daily.
.PARAMETER ShowDetail 
Default this is set to $true. If set to $true, the utilization records will be split by the resource instance levels. If set to false, the utilization records will be aggregated on the resource level.
.PARAMETER ResultSize 
Specifies the maximum number of results to return. The default value and the maximum value is 1000. To retrieve more than 1000 records you must use the continuation link. 
.PARAMETER ContinuationLink 
Specifies a variable to save the URL to retrieve additional results.
.EXAMPLE
     Get-PCUsage -TenantId 2a14b164-f983-4048-92e1-4f9591b87445 -SubscriptionId b027a4b3-5487-413b-aa48-ec8733c874d6 -StartTime '06-12-2018 00:00:00' -EndTime '06-31-2018 23:59:59' -Granularity hourly -ResultSize 2000
Return up to 2000 hourly usage records for the specified date range. 
.NOTES
#>
function Get-PCUsage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][String]$SubscriptionId,
        [Parameter(Mandatory = $true)][String]$StartTime,
        [Parameter(Mandatory = $true)][String]$EndTime,
        [Parameter(Mandatory = $false)][ValidateSet('daily', 'hourly')][String]$Granularity = 'daily',
        [Parameter(Mandatory = $false)][bool]$ShowDetail = $true,
        [Parameter(Mandatory = $false)][ValidateRange(1, 100000)][int]$ResultSize = 1000,
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][Parameter(Mandatory = $false, ParameterSetName = 'next')][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)
    
    if ($ResultSize -ge 1000) {
   
        $retObject = Get-PCUsage_implementation -SubscriptionId $SubscriptionId -StartTime $startTime -EndTime $endTime -Granularity $granularity -ShowDetail $ShowDetail -ResultSize 1000 -TenantId $TenantId -SaToken $SaToken
        $returnItems = $retObject.Items

        if ($retObject.Count -ge 1000) {
            
            do {
            
                $r = Get-PCUsage_implementation -SaToken $SaToken -ContinuationLink $retObject.links
                #foreach ($i in $r)
                #{
                $returnItems += $r.Items

                #}    
                #$retObject += $retObject2
            }
            until(!($r.links.PsObject.Properties.Name -match 'next'))
        }
    }
    else {
        
        $retObject = Get-PCUsage_implementation -SubscriptionId $SubscriptionId -StartTime $startTime -EndTime $endTime -Granularity $granularity -ShowDetail $ShowDetail -ResultSize $ResultSize -TenantId $TenantId -SaToken $SaToken
        $returnItems = $retObject.Items
    }
             
    ##        $retObject = Get-PCUsage_implementation -SaToken $SaToken -ContinuationLink $continuationLink

    return $returnItems
}

function Get-PCUsage_implementation {
    [CmdletBinding()]
    param ( [String]$SubscriptionId,
        [String]$StartTime,
        [String]$EndTime,
        [String]$Granularity,
        [bool]$ShowDetail,
        [int]$ResultSize,
        [String]$TenantId,
        [string]$SaToken,
        $ContinuationLink)
    
    $obj = @()

    $urlParts = @("https://api.partnercenter.microsoft.com/v1/")

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    if ($ContinuationLink -eq $null) {
        try {
            $s_time = get-date $StartTime -Format s
        }
        catch {
            "Start time is not in a valid format. Use '01-06-2018 00:00:00' format"
        }
    
        try {
            $e_time = get-date $EndTime -Format s
        }
        catch {
            "End time is not in a valid format. Use '01-06-2018 23:59:00' format"
        }

        $urlParts += "Customers/{0}/Subscriptions/{1}/Utilizations/azure?start_time={2}Z&end_time={3}Z&show_details={4}&granularity={5}&size={6}" -f $TenantId, $SubscriptionId, $s_time, $e_time, $ShowDetail, $granularity, $ResultSize
    }
    else {
        if (Get-Member -InputObject $continuationLink -name "next" -MemberType Properties) {
            $urlParts += $continuationLink.next.uri
            
            foreach ($i in $continuationLink.next.headers) {
                $headers.Add($i.Key, $i.Value) 
            }
        }
        else {
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

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Get-PCSubscriptionMonthlyUsageRecord returns a usage record for the specified tenant
.PARAMETER SaToken 
Specified an authentication token you have created with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant id for which to return a usage record
.EXAMPLE
Get-PCSubscriptionMonthlyUsageRecord

.NOTES
TODO
#>
function Get-PCSubscriptionMonthlyUsageRecord {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/usagerecords" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "SubscriptionMonthlyUsageRecord")
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Get-PCAzureResourceMonthlyUsageRecord cmdlet returns Azure usage for the specified tenant.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER SubscriptionId 
Specifies the subscription id for which to return usage.
.EXAMPLE
 Get-PCAzureResourceMonthlyUsageRecord 
.NOTES
TODO
#>
function Get-PCAzureResourceMonthlyUsageRecord {
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

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureResourceMonthlyUsageRecord") 
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Get-PCCustomerUsageSummary cmdlet returns a summary of usage for the specified tenant.
.PARAMETER SaToken 
Specifies an authentication token created with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.EXAMPLE
    Get-PCCustomerUsageSummary -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f
Get the usage summary for all subscriptions for the specified tenant id.

.NOTES

#>
function Get-PCCustomerUsageSummary {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()  

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/usagesummary" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUsageSummary") 
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Get-PCCustomerServiceCostSummary returns a cost summary for the specified billing period
.PARAMETER SaToken 
Specifies an authentication token created with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER BillingPeriod 
Specifies the billing period. The only valid value is MostRecent. Current and None may be added in the future. 
.EXAMPLE
Get-PCCustomerServiceCostSummary
.NOTES
TODO
#>
function Get-PCCustomerServiceCostSummary {
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
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceCostsSummary") 
}
