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
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\commons.ps1"
Import-Module -FullyQualifiedName "$here\PartnerCenterTelemetry.psm1"

function Get-DomainAvailability
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]$domain,
        
        [Parameter(Mandatory = $false)]
        [string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken) 
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    try
    {
        $url = "https://api.partnercenter.microsoft.com/v1/domains/{0}" -f $domain
        $headers = @{Authorization="Bearer $GlobalToken"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "HEAD" #-Debug -Verbose
        return $false
    } 
    catch [System.Net.WebException] 
    {
        $statusCode = [int]$_.Exception.Response.StatusCode
        $html = $_.Exception.Response.StatusDescription
        if ($statusCode -eq 404)
        { return $true }
        else
        { return ($statusCode+' - '+$html) }
    }
}

function Get-CustomerRole
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRoles")   
}

function Get-CustomerRoleMember
{
    [CmdletBinding()]
    param ( 
           [Parameter(Mandatory = $true)][string]$roleid,
           [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles/{1}/usermembers" -f $tenantid, $roleid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser")
}

function Add-CustomerRoleMember
{    
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(Mandatory = $true)][string]$roleid,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$customerrolemember,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles/{1}/usermembers" -f $tenantid, $roleid
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    $body = $customerrolemember | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "POST" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser") 
}

function Remove-CustomerRoleMember
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(Mandatory = $true)][string]$roleid,
            [Parameter(Mandatory = $true)][string]$userid,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles/{1}/usermembers/{2}" -f $tenantid, $roleid, $userid
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser")   
}

function New-RelationshipRequest
{    
    [CmdletBinding()]
    param  ([Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/relationshiprequests"
    $headers  = @{"Authorization"="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "RelationshipRequest") 
}