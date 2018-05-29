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

<#
.DESCRIPTION
The Get-PCDomainAvailability cmdlet tests to see if the specified tenant domain (onmicrosoft.com) is available to create a new tenant.

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER Domain 
Specifies a onmicrosoft.com domain to check as to whether is available for use for a new tenant.

.EXAMPLE
Test to see if contoso.onmicrosoft.com is available

Get-PCDomainAvailabilty -Domain contoso.onmicrosocft.com

.NOTES
#>
function Get-PCDomainAvailability
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)][string]$Domain,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken) 

    try
    {
        $url = "https://api.partnercenter.microsoft.com/v1/domains/{0}" -f $Domain
        $headers = @{Authorization="Bearer $GlobalToken"}
        $null = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "HEAD" #-Debug -Verbose
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

<#


.DESCRIPTION

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerRole
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
           [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
   _testTokenContext($SaToken)
   _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles" -f $TenantId
    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRoles")   
}

<#


.DESCRIPTION

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 

.PARAMETER RoleId 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerRoleMember
{
    [CmdletBinding()]
    param ( 
           [Parameter(Mandatory = $true)][string]$RoleId,
           [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
           [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
   _testTokenContext($SaToken)
   _testTenantContext ($TenantId)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles/{1}/usermembers" -f $TenantId, $RoleId
    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser")
}

<#


.DESCRIPTION

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 

.PARAMETER RoleId 

.PARAMETER CustomerRoleMember 

.EXAMPLE

.NOTES
#>
function Add-PCCustomerRoleMember
{    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
        [Parameter(Mandatory = $true)][string]$RoleId,
        [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$CustomerRoleMember,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        )
   _testTokenContext($SaToken)
   _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles/{1}/usermembers" -f $TenantId, $RoleId
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    $body = $customerrolemember | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "POST" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser") 
}

<#


.DESCRIPTION

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 

.PARAMETER roleId 

.PARAMETER userId 

.EXAMPLE

.NOTES
#>
function Remove-PCCustomerRoleMember
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(Mandatory = $true)][string]$RoleId,
            [Parameter(Mandatory = $true)][string]$UserId,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
   _testTokenContext($SaToken)
   _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles/{1}/usermembers/{2}" -f $TenantId, $RoleId, $UserId
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser")   
}

<#
.DESCRIPTION
The New-PCRelationshipRequest cmdlet.

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.EXAMPLE

#>
function New-PCRelationshipRequest
{    
    [CmdletBinding()]
    param  (
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        )
   _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/relationshiprequests"
    $headers  = @{"Authorization"="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "RelationshipRequest") 
}