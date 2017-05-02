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

function Get-Offer
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string]$countryid,
        [Parameter(Mandatory = $false)][string]$offerid,
        [Parameter(Mandatory = $false)][string]$localeid,
        [Parameter(Mandatory = $false)][switch]$addons,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()
    if ($offerid)
    {
        if ($addons)
        {
            $url = "https://api.partnercenter.microsoft.com/v1/offers/{0}/addons?country={1}" -f $offerid, $countryid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "OfferAddons")   
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/offers/{0}?country={1}&locale={2}" -f $offerid, $countryid, $localeid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")     
        }
    }
    else
    {
        if ($localeid)
        {
            $url = "https://api.partnercenter.microsoft.com/v1/offers?country={0}&locale={1}" -f $countryid, $localeid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/offers?country={0}" -f $countryid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")
        }
    }
}

function Get-OfferCategoriesByMarket
{
    [CmdletBinding()]
    param($countryid,        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/offercategories?country={0}" -f $countryid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "OfferCategories")   
}

function Get-AddressRulesByMarket 
{
    [CmdletBinding()]
    param ($countryid,         [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/countryvalidationrules/{0}" -f $countryid
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "MarketRules")   
}

function Get-AzureRateCard
{
    [CmdletBinding()]
    param ($currency, $region,         [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
   
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/ratecards/azure?&currency={0}&region={1}" -f $currency, $region
    $headers = @{Authorization="Bearer $satoken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureRateCard")   
}