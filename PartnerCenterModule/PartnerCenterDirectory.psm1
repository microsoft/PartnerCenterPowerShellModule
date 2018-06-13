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

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\commons.ps1"

<#
.SYNOPSIS
Tests to see if the specified onmicrosoft.com is available to be used for a new tenant.

.DESCRIPTION
The Get-PCDomainAvailability cmdlet tests to see if the specified tenant domain (onmicrosoft.com) is available to create a new tenant.

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER Domain 
Specifies a onmicrosoft.com domain to check as to whether is available for use for a new tenant.

.EXAMPLE
Get-PCDomainAvailability -Domain contoso.onmicrosoft.com

Test to see if contoso.onmicrosoft.com is available for a new tenant.
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
.SYNOPSIS
TODO
.DESCRIPTION
The Get-PCCustomerRole cmdlet. TODO
.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 
Specifies the tenant id for which to return the customer roles. 
.EXAMPLE
Get-PCCustomerRole

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
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRoles")   
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Get-PCCustomerRoleMember cmdlet TODO

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.

.PARAMETER RoleId 
Specifies the role id

.EXAMPLE
Get-PCCustomerRoleMember

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

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)    

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser")
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Add-PCCustomerRoleMember cmdlet adds a customer user account into a role.

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 
Specifies the tenant for which to add the role member.

.PARAMETER RoleId 
Specifies the role id for which to add the member.

.PARAMETER CustomerRoleMember 
Specifies the member to add to the role.

.EXAMPLE
Specify a customer
    $customer = Get-PCCustomer -TenantId '<Tenant Id Guid>'

Get a role

    $role = Get-PCCustomerRole -TenantId $customer.id | Where-Object name -Contains '<role name>'

Get a User

    $user = Get-PCCustomerUser -TenantId $customer.id -UserId '<User id Guid>'

Add a User to a Role

    $customerRoleMember = [DirectoryRoleMember]::new()
    $customerRoleMember.id = $user.id
    Add-PCCustomerRoleMember -TenantId $customer.id -RoleId $role.id -CustomerRoleMember $customerRoleMember

.NOTES
TODO
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

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $body = $CustomerRoleMember | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "POST" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser") 
}

<#
.SYNOPSIS
Removes the specified user id from the specified role id.
.DESCRIPTION
The Remove-PCCustomerRoleMember cmdlet removes the specified user from the specified role.
.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.

.PARAMETER RoleId 
Specifies the role guid for which to remove the user.
.PARAMETER UserId 
Specifies the user id to remove from the role.
.EXAMPLE
Remove a user from a specified role.

Get a customer
    $customer = Get-PCCustomer | Where-Object {$_.CompanyProfile.CompanyName -eq 'Wingtip Toys'}

Get a role named Helpdesk Administrator

    $role = Get-PCCustomerRole -TenantId $c.id | Where-Object {$_.Name -eq 'Helpdesk Administrator'}

Get a User

    $user = Get-PCCustomerUser -TenantId $customer.id | Where-Object {$_.userPrincipalName -eq 'John@wingtiptoyscsptest.onmicrosoft.com'}

Remove a user from a role

    Remove-PCCustomerRoleMember -TenantId $customer.id -RoleId $Role.Id -UserId $User.Id

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
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "DirectoryRolesUser")   
}

<#
.SYNOPSIS
Returns the request text to send to the end customer administrator to initiate a relationship with the partner.

.DESCRIPTION
The New-PCRelationshipRequest cmdlet.

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.EXAMPLE
$inviteUrl = (New-PCRelationshipRequest).Url

Get an invitation Url to send to a new customer.
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
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "RelationshipRequest") 
}