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

.PARAMETER UserId 

.PARAMETER All 

.PARAMETER Licenses 

.PARAMETER Deleted

.PARAMETER Size 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerUser
{
    [CmdletBinding()]
    Param(
            [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(ParameterSetName='all', Mandatory = $false)][switch]$All,
            [Parameter(ParameterSetName='activeuser', Mandatory = $false)][String]$UserId,
            [Parameter(ParameterSetName='activeuser', Mandatory = $false)][switch]$Licenses,
            [Parameter(ParameterSetName='deleteduser', Mandatory = $false)][switch]$Deleted,
            [Parameter(ParameterSetName='deleteduser', Mandatory = $false)][int]$Size = 200,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    function Private:Get-CustomerAllUserInner ($SaToken, $TenantId)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $TenantId
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "CustomerUser")       
    }

    function Private:Get-CustomerUserInner ($SaToken, $TenantId, $UserId, $Licenses)
    {
       $obj = @()
        if ($UserId)
        {
            if ($Licenses)
            {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}/licenses" -f $TenantId, $UserId
                $headers = @{Authorization="Bearer $SaToken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "CustomerUserLicenses")       
            }
            else
            {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $UserId
                $headers = @{Authorization="Bearer $SaToken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "CustomerUser")
            }
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $TenantId
            $headers = @{Authorization="Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "CustomerUser")       
        }
    }

    function Private:Get-DeletedUsersInner ($SaToken, $TenantId, $Size)
    {
       $obj = @()
        $filter = '{"Field":"UserStatus","Value":"Inactive","Operator":"equals"}'
        [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
        $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users?size={1}&filter={2}" -f $TenantId,$Size,$Encode
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "CustomerUser")        
    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "activeuser" {$res = Get-CustomerUserInner -SaToken $SaToken -TenantId $TenantId -user $UserId -licenses $Licenses
                          return $res}

        "deleteduser"{$res = Get-DeletedUsersInner -SaToken $SaToken -TenantId $TenantId -size $Size
                          return $res}

        "all"        {$res = Get-CustomerAllUserInner -SaToken $SaToken -TenantId $TenantId 
                          return $res}

    }
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER UsageLocation 

.PARAMETER UserPrincipalName

.PARAMETER FirstName 

.PARAMETER LastName 

.PARAMETER DisplayName 

.PARAMETER Password

.PARAMETER ForceChangePassword 

.EXAMPLE
New-PCCustomerUser 
.NOTES
#>
function New-PCCustomerUser
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
           [Parameter(Mandatory = $true)][string]$UsageLocation,
           [Parameter(Mandatory = $true)][string]$UserPrincipalName,
           [Parameter(Mandatory = $true)][string]$FirstName,
           [Parameter(Mandatory = $true)][string]$LastName,
           [Parameter(Mandatory = $true)][string]$DisplayName,
           [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][SecureString]$Password,
           [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][bool]$ForceChangePassword,
           [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $TenantId
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $user = [CustomerUser]::new($UsageLocation,$UserPrincipalName,$FirstName,$LastName,$DisplayName,$Password,$ForceChangePassword)
    $body = $user | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" # -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER user 

.PARAMETER FirstName

.PARAMETER LastName 

.PARAMETER userPrincipalName 

.PARAMETER location 

.PARAMETER password

.PARAMETER forceChangePassword

.EXAMPLE
Set-PCCustomerUser
.NOTES
#>
function Set-PCCustomerUser
{
    [CmdletBinding()]
    param (
            [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$User,
            [Parameter(Mandatory = $false)][string]$FirstName,
            [Parameter(Mandatory = $false)][string]$LastName,
            [Parameter(Mandatory = $false)][string]$UserPrincipalName,
            [Parameter(Mandatory = $false)][string]$Location,    
            [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][SecureString]$Password,
            [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][bool]$ForceChangePassword,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $actualUser = Get-PCCustomerUser -TenantId $TenantId -UserId $User.Id -SaToken $SaToken

    if($FirstName) {$actualUser.FirstName = $FirstName}
    if($LastName) {$actualUser.LastName = $LastName}
    if($UserPrincipalName) {$actualUser.userPrincipalName = $UserPrincipalName}
    if($Location) {$actualUser.location = $Location}
    if($Password -or $ForceChangePassword)
    {
        $passwordProfile = [CustomerUserPasswordProfile]::new($Password, $ForceChangePassword)
        $actualUser | Add-Member -type NoteProperty -name PasswordProfile -Value $passwordProfile
    }

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $User.id
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    $body = $actualUser | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER user 

.EXAMPLE
Restore-PCCustomerUser
.NOTES
#>
function Restore-PCCustomerUser
{
    [CmdletBinding()]
    param (
            [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$User,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId) 

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $User.id
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    $body = "{ ""State"": ""active"", ""Attributes"": { ""ObjectType"": ""CustomerUser"" } }"
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")     
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER user 

.EXAMPLE
Remove-PCCustomerUser
.NOTES
#>
function Remove-PCCustomerUser
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$user,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $user.id
    $headers = @{Authorization="Bearer $SaToken"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}


function Get-PCCustomerUserRoles
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$user,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    Write-Warning "  Get-PCCustomerUserRoles is deprecated and will not be available in future releases, use Get-PCCustomerUserRole instead."

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}/directoryroles" -f $TenantId, $user.id
    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUserDirectoryRoles")  
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER User 

.EXAMPLE

.NOTES
#>
function Get-PCCustomerUserRole
{
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$User,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}/directoryroles" -f $TenantId, $User.id
    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUserDirectoryRoles")  
}
