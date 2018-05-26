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

.PARAMETER SaToken 

.PARAMETER TenantId 

.PARAMETER ServiceRequestId 

.PARAMETER All 

.EXAMPLE

.NOTES
#>
function Get-PCSR
{
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName='TenantId', Mandatory = $false)][String]$TenantId,
        [Parameter(ParameterSetName='srid', Mandatory = $false)][String]$ServiceRequestId,
        [Parameter(ParameterSetName='all', Mandatory = $true)][switch]$All,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    $headers = @{Authorization="Bearer $SaToken"}

    switch ($PsCmdlet.ParameterSetName)
    {
        "TenantId" {$url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/servicerequests" -f $TenantId}
        "all"      {$url = "https://api.partnercenter.microsoft.com/v1/servicerequests"}
        "srid"      {$url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $ServiceRequestId}
    }

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")
}

function Get-PCSRTopics
{
    [CmdletBinding()]
    param([Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

    Write-Warning "    Get-PCSRTopics is deprecated and will not be available in future releases, use Get-PCSRTopic instead."

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/supporttopics"
    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequestTopics")   
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 

.EXAMPLE

.NOTES
#>
function Get-PCSRTopic
{
    [CmdletBinding()]
    param([Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

    $obj = @()
    
    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/supporttopics"
    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequestTopics")   
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 

.PARAMETER ServiceRequest 

.PARAMETER Title 

.PARAMETER Description 

.PARAMETER Severity 

.PARAMETER SupportTopicId 

.PARAMETER ServiceRequestContact 

.PARAMETER ServiceRequestNote 

.PARAMETER AgentLocale 

.EXAMPLE

.NOTES
#>
function New-PCSR
{
   [CmdletBinding()]
   param (
        [Parameter(ParameterSetName='byObject', Mandatory = $true)][ServiceRequest]$ServiceRequest, 
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][string]$Title, 
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][string]$Description,
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][ValidateSet("Minimal","Moderate","Critical")][string]$Severity,
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][string]$SupportTopicID,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][ServiceRequestContact]$ServiceRequestContact,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][ServiceRequestNote]$ServiceRequestNote,
        [Parameter(Mandatory = $false)][string]$AgentLocale = "en-US",
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $AgentLocale
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $newSR = [ServiceRequest]::new()
    if ($serviceRequest) { $newSR = $serviceRequest }
    else
    {
        $newSR = [ServiceRequest]::new($Title,$Description,$Severity,$SupportTopicID)
        if ($ServiceRequestContact) { $newSR.PrimaryContact = $ServiceRequestContact }
        if ($ServiceRequestNote) { $newSR.NewNote = $ServiceRequestNote }
    }

    $body = $newSR | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" # -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 

.PARAMETER ServiceRequest 

.PARAMETER Status 

.PARAMETER Description 

.PARAMETER AddNote 

.EXAMPLE

.NOTES
#>
function Set-PCSR
{
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName='byParam', Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$ServiceRequest,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][ValidateSet("open","closed")][string]$Status,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$Title,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$Description,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$AddNote,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$SaToken = $GlobalToken
    )
     _testTokenContext($SaToken)  

    $obj = @()

    if ($ServiceRequest) {$body = $ServiceRequest | ConvertTo-Json -Depth 100}
    else
    {
        $actualSR = Get-PCSR -serviceRequestId $serviceRequest.id -SaToken $SaToken
        if ($Status) {$actualSR.status = $Status
                        $body = $actualSR | ConvertTo-Json -Depth 100}
        if ($AddNote) {
            $newSR = [ServiceRequest]::new($actualSR.title, $actualSR.description,$actualSR.severity,$actualSR.SupportTopicID)
            $newSR.newnote = $AddNote
            $body = $newSR | ConvertTo-Json -Depth 100
        }
    }

    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $ServiceRequest.id
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}   

    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")
}
