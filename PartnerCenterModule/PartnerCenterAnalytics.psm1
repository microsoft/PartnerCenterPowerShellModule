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
TODO
.DESCRIPTION
The Get-PCLicenseDeployment cmdlet retrieves a list of licenses for the authenticated partner.

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.EXAMPLE
Get-PCLicenseDeployment

Return a list of assigned licenses for the authenticated partner.

.NOTES
You need to have a authentication Credential already established before running this cmdlet.

#>
function Get-PCLicenseDeployment
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $url = "https://api.partnercenter.microsoft.com/v1/analytics/licenses/deployment"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj = @() + $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerLicensesDeploymentInsights")      
}

<#
.SYNOPSIS
Retrieves a list of licenses being used for the partner account.

.DESCRIPTION
The Get-PCLicenseUsage cmdlet retrieves a list of licenses assigned for the authenticated partner.

.PARAMETER SaToken 
The authentication token you have created with your Partner Center credentials.

.EXAMPLE
Get-PCLicenseUsage

Return a list of assigned licenses for the authenticated partner.

.NOTES
You need to have a authentication Credential already established before running this cmdlet.

#>
function Get-PCLicenseUsage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $url = "https://api.partnercenter.microsoft.com/v1/analytics/licenses/usage"

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj = @() + $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "PartnerLicensesUsageInsights")      
}

<#
.SYNOPSIS
TODO

.DESCRIPTION
The Get-PCCustomerLicenseDeployment cmdlet retrieves a list of licenses deployed by a partner for a specifc tenant.

.PARAMETER SaToken 
Specifies the authentication token you have created with your Partner Center credentials.

.PARAMETER TenantId 
Specifies the tenant id.

.EXAMPLE
Get-PCCustomerLicenseDeployment -TenantId XXXXXXXXXXXXXXXXXXXX

Retrieve a list of deployed liceses for the specified tenant.

#>
function Get-PCCustomerLicenseDeployment
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/analytics/licenses/deployment" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj = @() + $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerLicensesDeploymentInsights")      
}

<#
.SYNOPSIS
TODO

.DESCRIPTION
The Get-PCCustomerLicenseUsage cmdlet retrieves a list of licenses deployed and assigned by a partner for a specifc tenant.

.PARAMETER SaToken 
Specifies the authentication token you have created with your Partner Center credentials.

.PARAMETER TenantId 
Specifies the tenant id.

.EXAMPLE
Get-PCCustomerLicenseDeployment -TenantId XXXXXXXXXXXXXXXXXXXX

Retrieve a list of assigned liceses for the specified tenant

#>
function Get-PCCustomerLicenseUsage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/analytics/licenses/usage" -f $TenantId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj = @() + $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "CustomerLicensesUsageInsights")      
}