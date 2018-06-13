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
Returns either all users for a customer tenant or the specified customer user.
.DESCRIPTION
The Get-PCCustomerUser cmdlet returns either all users or a specified user from the tenant.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER UserId 
Specifies the user id.
.PARAMETER Licenses 
Specifies whether to return the licenses assigned to the specified user.
.PARAMETER Deleted
Specifies whether to return deleted users.
.PARAMETER ResultSize 
Specifies the maximum number of results to return. The default value is 200.
.EXAMPLE
Get all users for the specified tenant.
PS C:\>Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f

.EXAMPLE 
Get a customer user
PS C:\>$user = Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -UserId 'e2e56b09-aac5-4685-947d-29e735ee7ed7'

<<<<<<< HEAD
.EXAMPLE
Get a list of user assigned licenses for the specified user id.
PS C:\>Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -UserId 'e2e56b09-aac5-4685-947d-29e735ee7ed7' -Licenses
=======
.PARAMETER Size 
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.

.EXAMPLE
Get a list of deleted users for the tenant
PS C:\>Get-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -Deleted

.NOTES
#>
function Get-PCCustomerUser {
    [CmdletBinding()]
    Param(
<<<<<<< HEAD
        [Parameter(ParameterSetName = 'activeUser', Mandatory = $false)]
        [parameter(ParameterSetName = "deletedUser")]
        [parameter(ParameterSetName = "all")]
        [string]$TenantId = $GlobalCustomerId,
        [Parameter(ParameterSetName = 'activeUser', Mandatory = $true)][string]$UserId,
        [Parameter(ParameterSetName = 'activeUser', Mandatory = $false)][switch]$Licenses,
        [Parameter(ParameterSetName = 'deletedUser', Mandatory = $true)][switch]$Deleted,
        [Parameter(ParameterSetName = 'deletedUser', Mandatory = $false)][int]$ResultSize = 200,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
=======
            [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(ParameterSetName='all', Mandatory = $false)][switch]$All,
            [Parameter(ParameterSetName='activeuser', Mandatory = $false)][String]$UserId,
            [Parameter(ParameterSetName='activeuser', Mandatory = $false)][switch]$Licenses,
            [Parameter(ParameterSetName='deleteduser', Mandatory = $false)][switch]$Deleted,
            [Parameter(ParameterSetName='deleteduser', Mandatory = $false)][int]$Size = 200,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    function Private:Get-CustomerAllUserInner ($SaToken, $TenantId) {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $TenantId

        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)       

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "CustomerUser")       
    }

    function Private:Get-CustomerUserInner ($SaToken, $TenantId, $UserId, $Licenses) {
        $obj = @()
        if ($UserId) {
            if ($Licenses) {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}/licenses" -f $TenantId, $UserId
                
                $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
                $headers.Add("Authorization", "Bearer $SaToken")
                $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "CustomerUserLicenses")       
            }
            else {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $UserId

                $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
                $headers.Add("Authorization", "Bearer $SaToken")
                $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "CustomerUser")
            }
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $TenantId
            
            $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
            $headers.Add("Authorization", "Bearer $SaToken")
            $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "CustomerUser")       
        }
    }

<<<<<<< HEAD
    function Private:Get-DeletedUsersInner ($SaToken, $TenantId, $ResultSize) {
        $obj = @()
=======
    function Private:Get-DeletedUsersInner ($SaToken, $TenantId, $Size)
    {
       $obj = @()
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
        $filter = '{"Field":"UserStatus","Value":"Inactive","Operator":"equals"}'
        [Reflection.Assembly]::LoadWithPartialName("System.Web") | Out-Null
        $Encode = [System.Web.HttpUtility]::UrlEncode($filter)

<<<<<<< HEAD
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users?size={1}&filter={2}" -f $TenantId, $ResultSize, $Encode
=======
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users?size={1}&filter={2}" -f $TenantId,$Size,$Encode
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.

        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "CustomerUser")        
    }

<<<<<<< HEAD
    if ($PsCmdlet.ParameterSetName -eq "activeUser") {
        $res = Get-CustomerUserInner -SaToken $SaToken -TenantId $TenantId -user $UserId -licenses $Licenses
        return $res
    }
    elseif ($PsCmdlet.ParameterSetName -eq "deletedUser") {
        $res = Get-DeletedUsersInner -SaToken $SaToken -TenantId $TenantId -ResultSize $ResultSize
        return $res
=======
    switch ($PsCmdlet.ParameterSetName)
    {
        "activeuser" {$res = Get-CustomerUserInner -SaToken $SaToken -TenantId $TenantId -user $UserId -licenses $Licenses
                          return $res}

        "deleteduser"{$res = Get-DeletedUsersInner -SaToken $SaToken -TenantId $TenantId -size $Size
                          return $res}

        "all"        {$res = Get-CustomerAllUserInner -SaToken $SaToken -TenantId $TenantId 
                          return $res}

>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
    }
    else {
        $res = Get-CustomerAllUserInner -SaToken $SaToken -TenantId $TenantId 
        return $res
    }

}

<#
.SYNOPSIS
Creates a new user in the specified customer Azure Active Directory tenant.
.DESCRIPTION
The New-PCCustomerUser cmdlet creates a new user in the tenant Azure Active Directory.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER UsageLocation 
Specifies the location the user will be used.
.PARAMETER UserPrincipalName
Specifies the user name including the domain for the new user.
.PARAMETER FirstName 
Specifies the first name of the new users.
.PARAMETER LastName 
Specifies the last name for the new user.
.PARAMETER DisplayName 
Specifies the display name for the new user.
.PARAMETER Password
Specifies a secure string to be assigned as the password for the new user.
.PARAMETER ForceChangePassword 
Specifies whether the new user must change their password during the first logon.
.EXAMPLE
 New-PCCustomerUser -TenantId 45916f92-e9c3-4ed2-b8c2-d87aa129905f -UsageLocation US -userPrincipalName 'joe@contoso.onmicrosoft.com' -FirstName 'Joe' -LastName 'Smith' -DisplayName 'Joe Smith' -ForceChangePassword $true -Password $PasswordSecure
.NOTES
#>
function New-PCCustomerUser {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $true)][string]$UsageLocation,
        [Parameter(Mandatory = $true)][string]$UserPrincipalName,
        [Parameter(Mandatory = $true)][string]$FirstName,
        [Parameter(Mandatory = $true)][string]$LastName,
        [Parameter(Mandatory = $true)][string]$DisplayName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][SecureString]$Password,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][bool]$ForceChangePassword,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $user = [CustomerUser]::new($UsageLocation, $UserPrincipalName, $FirstName, $LastName, $DisplayName, $Password, $ForceChangePassword)
    $body = $user | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" # -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

<#
.SYNOPSIS
Updates the specified customer user account.
.DESCRIPTION
The Set-PCustomerUser cmdlet modifies a customer user account.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER UserId 
Specifies the user id to modify.
.PARAMETER FirstName
Specifies the modified first name for the user.
.PARAMETER LastName 
Specifies the modified last name for the user.
.PARAMETER userPrincipalName 
Specifies a modified user name including the domain name.
.PARAMETER Location 
Specifies a modified location for the user.
.PARAMETER Password
Specifies an updated password as a secure string to set for the user.
.PARAMETER forceChangePassword
Specifies whether the user will need to change their password the next time they sign in.
.EXAMPLE
Update a customer user's last name

Find the tenant information about the customer named Wingtip Toys

    $customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}

Find the user with the joan@wingtiptoyscsptest.onmicrosoft.com

    $user = Get-PCCustomerUser -TenantId $customer.id | Where-Object {$_.userPrincipalName -eq 'joan@wingtiptoyscsptest.onmicrosoft.com'}

Modify the user's last name

    Set-PCCustomerUser -TenantId $customer.id -userId $user.id -LastName 'Sullivan'

.EXAMPLE
Reset a customer user's password

Find the tenant information about the customer named Wingtip Toys

    $customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}

Find the user with the joan@wingtiptoyscsptest.onmicrosoft.com

    $user = Get-PCCustomerUser -TenantId $customer.id | Where-Object {$_.userPrincipalName -eq 'joan@wingtiptoyscsptest.onmicrosoft.com'}

Set the password for the user account and require the user to change the password during the next sign on.

    $password = '<password>'
    $passwordSecure = $password | ConvertTo-SecureString -AsPlainText -Force
    Set-PCCustomerUser -TenantId $customer.id -UserId $user.Id -Password $passwordSecure -ForceChangePassword $true

.NOTES
#>
function Set-PCCustomerUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $true)][String]$UserId,
        [Parameter(Mandatory = $false)][string]$FirstName,
        [Parameter(Mandatory = $false)][string]$LastName,
        [Parameter(Mandatory = $false)][string]$UserPrincipalName,
        [Parameter(Mandatory = $false)][string]$Location,    
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][SecureString]$Password,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][bool]$ForceChangePassword,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $actualUser = Get-PCCustomerUser -TenantId $TenantId -UserId $UserId -SaToken $SaToken

    if ($FirstName) {$actualUser.firstName = $FirstName}
    if ($LastName) {$actualUser.lastName = $LastName}
    if ($UserPrincipalName) {$actualUser.userPrincipalName = $UserPrincipalName}
    if ($Location) {$actualUser.location = $Location}
    if ($Password -or $ForceChangePassword) {
        $passwordProfile = [CustomerUserPasswordProfile]::new($Password, $ForceChangePassword)
        $actualUser | Add-Member -type NoteProperty -name PasswordProfile -Value $passwordProfile
    }

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $UserId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $body = $actualUser | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

<#
.SYNOPSIS
Restores the specified customer user.
.DESCRIPTION
The Restore-PCCustomerUser cmdlet restore a deleted customer  user.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER UserId 
Specifies the user id to restore.
.EXAMPLE
Find the deleted account

    $user = Get-PCCustomerUser -Deleted -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536 | Where-Object {$_.userPrincipalName -eq 'John@wingtiptoyscsptest.onmicrosoft.com'}

Restore the deleted user account

    Restore-PCCustomerUser -TenantId $customer.id -UserId $User.Id

.NOTES

#>
function Restore-PCCustomerUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $true)][string]$UserId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId) 

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $UserId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $body = "{ ""State"": ""active"", ""Attributes"": { ""ObjectType"": ""CustomerUser"" } }"
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")     
}

<#
.SYNOPSIS
Deletes a user from the customer's tenant.
.DESCRIPTION
The Remove-PCCustomerUser cmdlet removes the specified user from the customer tenant.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER UserId 
Specifies the user id to remove.
.EXAMPLE
Retrieve the user id for the customer user you want to delete.

    $user = Get-PCCustomerUser -TenantId db8ea5b4-a69b-45f3-abd3-dca19e87c536 | Where-Object {$_.userPrincipalName -eq 'John@wingtiptoyscsptest.onmicrosoft.com'}

Delete the specified customer user

    Remove-PCCustomerUser -TenantId $customer.id -UserId $user.id

.NOTES
#>
function Remove-PCCustomerUser {
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $true)][String]$UserId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}" -f $TenantId, $UserId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUser")       
}

<#
.SYNOPSIS
Returns the a list of roles for a specified tenant or user.
.DESCRIPTION
The Get-PCCustomerUserRoles cmdlet returns a list of roles for a specified tenant or user.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant is used for scoping this cmdlet.
.PARAMETER UserId
Specifies the user id for which to retrieve the roles.
.EXAMPLE
Get a list of all roles for the specified tenant.

Get-PCCustomerUserRole -TenantId a7bc20f7-6041-4165-8bef-59d0e7e8d67b

.EXAMPLE
Get a list of all the roles for the specified tenant id and user id.

Get-PCCustomerUserRole -TenantId a7bc20f7-6041-4165-8bef-59d0e7e8d67b -UserId e2e56b09-aac5-4685-947d-29e735ee7ed7

.NOTES
#>
function Get-PCCustomerUserRole {
    [CmdletBinding()]
    param ( [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$UserId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    if ($TenantId) {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/directoryroles" -f $TenantId, $UserId
    
        if ($UserId) {

            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/users/{1}/directoryroles" -f $TenantId, $UserId
        }

    }

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerUserDirectoryRoles")  
}
