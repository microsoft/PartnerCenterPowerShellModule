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
Returns audit records based on the specified time.

.DESCRIPTION
The Get-PCAuditRecord cmdlet retrieves a list of audit records for the specified time period.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER StartDate 
The date from which you will start retrieving data. Must be formated yyyy-mm-dd.

.PARAMETER EndDate 
The date from which you will stop retrieving data. Must be formated yyyy-mm-dd.

.EXAMPLE
Get-PCAuditRecord
.NOTES
#>
function Get-PCAuditRecord {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)][ValidatePattern("\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])*")][string]$StartDate,
        [Parameter(Mandatory = $false)][ValidatePattern("\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])*")][string]$EndDate,
        #[Parameter(Mandatory = $false)][string]$filter,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    
    # TODO Only 30 days can be returned per request, limit the request to 30 days span before executing request
    
    if ($startDate) { $url = "https://api.partnercenter.microsoft.com/v1/auditrecords?startDate={0}" -f $StartDate }
    if ($endDate) { $url = "https://api.partnercenter.microsoft.com/v1/auditrecords?startDate={0}&endDate={1}" -f $StartDate, $EndDate }
    #if ($filter)
    #{
    #    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    #    $filter = [System.Web.HttpUtility]::UrlEncode($filter)
    #    $url = "https://api.partnercenter.microsoft.com/v1/auditrecords?startDate={0}&endDate={1}&filter={2}" -f $startDate, $endDate, $filter
    #}

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.items
    return (_formatResult -obj $obj -type "AuditRecord")  
}


<#
.SYNOPSIS
Returns a list of indirect resellers.

.DESCRIPTION
The Get-PCIndirectReseller cmdlet.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.EXAMPLE
Get-PCIndirectReseller
.NOTES
#>
function Get-PCIndirectReseller {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/relationships?relationship_type=IsIndirectCloudSolutionProviderOf"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerRelationship")  
}
