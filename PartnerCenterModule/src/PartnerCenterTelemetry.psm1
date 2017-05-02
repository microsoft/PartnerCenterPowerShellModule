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

function Send-ModuleTelemetry
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][string]$functionName
    )

    if ($global:GlobalPCPSTelemetry)
    {
        $body = New-Object System.Object
        $body | Add-Member -type NoteProperty -name CSPDomain -value $global:GlobalPCPSCSPDomain
        $body | Add-Member -type NoteProperty -name FunctionName -value $functionName
        $body | Add-Member -type NoteProperty -name ExecutionId -value $global:GlobalPCPSExecutionId
        $body | Add-Member -type NoteProperty -name SourceVersion -value $global:GlobalPCPSModuleVersion
        $body = $body | ConvertTo-Json -Depth 100
        $result = Invoke-RestMethod -Method Post -Uri "https://api.migaz.tools/v1/telemetry/PCPSModule" -Body $body -ContentType "application/json"
    }
}

function Update-ModuleTelemetry
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][string]$cspDomain
    )

    $global:GlobalPCPSCSPDomain     = $cspDomain
    $global:GlobalPCPSExecutionId   = ([Guid]::NewGuid()).Guid
    $global:GlobalPCPSModuleVersion = ((Get-Module -Name PartnerCenterModule).Version | Where-Object {$_ -GT '0.0'}).ToString()
    $latestModuleVersion = Invoke-RestMethod -Method Get -Uri "https://api.migaz.tools/v1/version/PCPSModule"

    if ($global:GlobalPCPSModuleVersion -ne $latestModuleVersion)
    {
        Write-Host "A new Partner Center PowerShell Module version ($latestModuleVersion) is available" -ForegroundColor Yellow
    }
}  

function Set-ModuleTelemetry
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)][bool]$enabled
    )
    $global:GlobalPCPSTelemetry = $enabled
}

function Get-ModuleTelemetry
{
    return $global:GlobalPCPSTelemetry
}


