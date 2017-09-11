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

function Get-PCAuditRecords
{
    [CmdletBinding()]
    Param(
            [Parameter(Mandatory = $true)][string]$startDate,
            [Parameter(Mandatory = $false)][string]$endDate,
            #[Parameter(Mandatory = $false)][string]$filter,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    if ($startDate) { $url = "https://api.partnercenter.microsoft.com/v1/auditrecords?startDate={0}" -f $startDate }
    if ($endDate)   { $url = "https://api.partnercenter.microsoft.com/v1/auditrecords?startDate={0}&endDate={1}" -f $startDate, $endDate }
    #if ($filter)
    #{
    #    [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
    #    $filter = [System.Web.HttpUtility]::UrlEncode($filter)
    #    $url = "https://api.partnercenter.microsoft.com/v1/auditrecords?startDate={0}&endDate={1}&filter={2}" -f $startDate, $endDate, $filter
    #}

    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AuditRecord")  
}


function Get-PCIndirectResellers
{
    [CmdletBinding()]
    Param(
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/relationships?relationship_type=IsIndirectCloudSolutionProviderOf"
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerRelationship")  
}
