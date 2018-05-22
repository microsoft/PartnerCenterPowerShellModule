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

function Get-PCSR
{
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName='tenantid', Mandatory = $false)][String]$tenantid,
        [Parameter(ParameterSetName='srid', Mandatory = $false)][String]$serviceRequestId,
        [Parameter(ParameterSetName='all', Mandatory = $true)][switch]$all,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()
    $headers = @{Authorization="Bearer $satoken"}

    switch ($PsCmdlet.ParameterSetName)
    {
        "tenantid" {$url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/servicerequests" -f $tenantid}
        "all"      {$url = "https://api.partnercenter.microsoft.com/v1/servicerequests"}
        "srid"      {$url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $serviceRequestId}
    }

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")
}

function Get-PCSRTopics
{
    [CmdletBinding()]
    param([Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/supporttopics"
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequestTopics")   
}

# Add non-plural version of the cmdlet. The plural version will be removed in future versions.
function Get-PCSRTopic
{
    [CmdletBinding()]
    param([Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/supporttopics"
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequestTopics")   
}


function New-PCSR
{
   [CmdletBinding()]
   param (
        [Parameter(ParameterSetName='byObject', Mandatory = $true)][ServiceRequest]$serviceRequest, 
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][string]$title, 
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][string]$description,
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][ValidateSet("Minimal","Moderate","Critical")][string]$severity,
        [Parameter(ParameterSetName='byParam', Mandatory = $true)][string]$supportTopicID,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][ServiceRequestContact]$serviceRequestContact,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][ServiceRequestNote]$serviceRequestNote,
        [Parameter(Mandatory = $false)][string]$agentLocale = "en-US",
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $agentLocale
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $newSR = [ServiceRequest]::new()
    if ($serviceRequest) { $newSR = $serviceRequest }
    else
    {
        $newSR = [ServiceRequest]::new($title,$description,$severity,$supportTopicID)
        if ($serviceRequestContact) { $newSR.PrimaryContact = $serviceRequestContact }
        if ($serviceRequestNote) { $newSR.NewNote = $serviceRequestNote }
    }

    $body = $newSR | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" # -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")  
}

function Set-PCSR
{
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName='byParam', Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$serviceRequest,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][ValidateSet("open","closed")][string]$status,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$title,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$description,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$addnote,
        [Parameter(ParameterSetName='byParam', Mandatory = $false)][string]$satoken = $GlobalToken
    )
     _testTokenContext($satoken)  

    $obj = @()

    if ($serviceRequest) {$body = $serviceRequest | ConvertTo-Json -Depth 100}
    else
    {
        $actualSR = Get-PCSR -serviceRequestId $serviceRequest.id -satoken $satoken
        if ($status) {$actualSR.status = $status
                        $body = $actualSR | ConvertTo-Json -Depth 100}
        if ($addnote) {
            $newSR = [ServiceRequest]::new($actualSR.title, $actualSR.description,$actualSR.severity,$actualSR.SupportTopicID)
            $newSR.newnote = $addnote
            $body = $newSR | ConvertTo-Json -Depth 100
        }
    }

    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $serviceRequest.id
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}   

    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")
}
