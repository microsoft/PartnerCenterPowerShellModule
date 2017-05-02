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

function Get-CustomerUser
{
    [CmdletBinding()]
    Param(
            [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(ParameterSetName='all', Mandatory = $false)][switch]$all,
            [Parameter(ParameterSetName='activeuser', Mandatory = $false)][String]$userid,
            [Parameter(ParameterSetName='activeuser', Mandatory = $false)][switch]$licenses,
            [Parameter(ParameterSetName='deleteduser', Mandatory = $false)][switch]$deleted,
            [Parameter(ParameterSetName='deleteduser', Mandatory = $false)][int]$size = 200,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    function Private:Get-CustomerAllUserInner ($satoken, $tenantid)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $tenantid
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "CustomerUser")       
    }

    function Private:Get-CustomerUserInner ($satoken, $tenantid, $userid, $licenses)
    {
       $obj = @()
        if ($userid)
        {
            if ($licenses)
            {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}/licenses" -f $tenantid, $userid
                $headers = @{Authorization="Bearer $satoken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "CustomerUserLicenses")       
            }
            else
            {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $tenantid, $userid
                $headers = @{Authorization="Bearer $satoken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "CustomerUser")
            }
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $tenantid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "CustomerUser")       
        }
    }

    function Private:Get-DeletedUsersInner ($satoken, $tenantid, $size)
    {
       $obj = @()
        $filter = '{"Field":"UserStatus","Value":"Inactive","Operator":"equals"}'
        [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
        $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users?size={1}&filter={2}" -f $tenantid,$size,$Encode
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "CustomerUser")        
    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "activeuser" {$res = Get-CustomerUserInner -satoken $satoken -tenantid $tenantid -user $userid -licenses $licenses
                          return $res}

        "deleteduser"{$res = Get-DeletedUsersInner -satoken $satoken -tenantid $tenantid -size $size
                          return $res}

        "all"        {$res = Get-CustomerAllUserInner -satoken $satoken -tenantid $tenantid 
                          return $res}

    }
}

function New-CustomerUser
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
           [Parameter(Mandatory = $true)][string]$usageLocation,
           [Parameter(Mandatory = $true)][string]$userPrincipalName,
           [Parameter(Mandatory = $true)][string]$firstName,
           [Parameter(Mandatory = $true)][string]$lastName,
           [Parameter(Mandatory = $true)][string]$displayName,
           [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$password,
           [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][bool]$forceChangePassword,
           [Parameter(ParameterSetName='ByProfile',Mandatory = $true)][CustomerUserPasswordProfile] $passwordProfile, 
           [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $tenantid
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    switch ($PsCmdlet.ParameterSetName)
    {
        'AllDetails' { $user = [CustomerUser]::new($usageLocation,$userPrincipalName,$firstName,$lastName,$displayName,$password,$forceChangePassword)}
        'ByProfile'  { $user = [CustomerUser]::new($usageLocation,$userPrincipalName,$firstName,$lastName,$displayName,$passwordProfile)}
    }

    $body = $user | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "POST" # -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

function Set-CustomerUser
{
    [CmdletBinding()]
    param (
            [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$user,
            [Parameter(Mandatory = $false)][string]$firstName,
            [Parameter(Mandatory = $false)][string]$lastName,
            [Parameter(Mandatory = $false)][string]$userPrincipalName,
            [Parameter(Mandatory = $false)][string]$location,    
            [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][string]$password,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][bool]$forceChangePassword,
            [Parameter(ParameterSetName='ByProfile',Mandatory = $false)][CustomerUserPasswordProfile] $passwordProfile, 
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $actualUser = Get-CustomerUser -tenantid $tenantid -userid $user.Id -satoken $satoken

    if($firstName) {$actualUser.firstName = $firstName}
    if($lastName) {$actualUser.lastName = $lastName}
    if($userPrincipalName) {$actualUser.userPrincipalName = $userPrincipalName}
    if($location) {$actualUser.location = $location}
    if($location) {$actualUser.location = $location}
    if($password -or $forceChangePassword)
    {
        $passwordProfile = [CustomerUserPasswordProfile]::new($password, $forceChangePassword)
        $actualUser | Add-Member -type NoteProperty -name passwordProfile -Value $passwordProfile
    }

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $tenantid, $user.id
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    $body = $actualUser | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

function Restore-CustomerUser
{
    [CmdletBinding()]
    param (
            [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$user,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid) 
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $tenantid, $user.id
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    $body = "{ ""State"": ""active"", ""Attributes"": { ""ObjectType"": ""CustomerUser"" } }"

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")     
}

function Remove-CustomerUser
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$user,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $tenantid, $user.id
    $headers = @{Authorization="Bearer $satoken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

function Get-CustomerUserRoles
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$user,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}/directoryroles" -f $tenantid, $user.id
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUserDirectoryRoles")  
}
