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
Returns aa list of offers based on the specified country id.
.DESCRIPTION
The Get-PCOffer cmdlet retrieves a list of offers based on the specified country id
.PARAMETER SaToken 
Specifies an authentication token you have created with your Partner Center credentials.
.PARAMETER CountryId
Specifies a two letter country id
.PARAMETER OfferId
Specifies the offer id to return.
.PARAMETER LocaleId
Specifies a locale as the language and country code. For example, English in the United States is en-us
.PARAMETER AddOns
Specifies add on SKUs
.EXAMPLE
Get-PCOffer -CountryId 'US'
Get all offer details for the US Country Id
.EXAMPLE
Get-PCOffer -CountryId 'US' -OfferId '8AA7E78B-B265-4AC6-ADA0-14900A8A3F94'
Get a specific offer using the offer id and country.
.EXAMPLE
Get-PCOffer -CountryId 'US' -LocaleId 'en-us'
Get all offer details using the Country Id and Locale Id.
.EXAMPLE
Get-PCOffer -CountryId 'US' -OfferId '8AA7E78B-B265-4AC6-ADA0-14900A8A3F94' -AddOns
Get add ons for the specified offer id.
.NOTES
#>
function Get-PCOffer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][ValidatePattern("^(AR|AU|AT|BE|BG|BR|CA|CH|CL|CN|CZ|DE|DK|EE|ES|FI|FR|GR|HR|HK|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|MX|NL|NO|NZ|PH|PL|PT|RO|RS|RS|RU|SA|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB|ZA)$")][string]$CountryId,
        [Parameter(Mandatory = $false)][string]$OfferId,
        [Parameter(Mandatory = $true)][ValidatePattern("^(es-US|en-ZA|en-PH|no-NO|en-NZ|en-IN|en-ID|es-AR|en-AU|en-MY|de-AT|nl-BE|zh-HK|fr-BE|es-CL|es-MX|bg-BG|pt-BR|zh-CN|cs-CZ|de-DE|da-DK|et-EE|ca-ES|es-ES|eu-ES|gl-ES|fi-FI|fr-FR|el-GR|hr-HR|hu-HU|id-ID|he-IL|hi-IN|it-IT|ja-JP|ko-KR|kk-KZ|lt-LT|lv-LV|ms-MY|nl-NL|nb-NO|pl-PL|pt-PT|ro-RO|sr-cyrl-rs|sr-latn-rs|ru-RU|sv-SE|zh-SG|sl-SI|sk-SK|th-TH|tr-TR|zh-TW|uk-UA|en-US|vi-VN|en-GB|en-CA|fr-CH|de-CH|it-CH|uz-UZ)$")][string]$LocaleId="en-US",
        [Parameter(Mandatory = $false)][switch]$AddOns,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    if ($OfferId) {

        if ($addons) {
            $url = "https://api.partnercenter.microsoft.com/v1/offers/{0}/addons?Country={1}" -f $OfferId, $CountryId

            $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
            $headers.Add("Authorization", "Bearer $SaToken")
            $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
            $headers.Add("X-Locale",$LocaleId)

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "OfferAddons")   
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/offers/{0}?Country={1}" -f $OfferId, $CountryId

            $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
            $headers.Add("Authorization", "Bearer $SaToken")
            $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
            $headers.Add("X-Locale",$LocaleId)

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")     
        }
    }
    else {

            $url = "https://api.partnercenter.microsoft.com/v1/offers?Country={0}" -f $CountryId

            $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
            $headers.Add("Authorization", "Bearer $SaToken")
            $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
            $headers.Add("X-Locale",$LocaleId)

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")
        }
    }

<#
.SYNOPSIS
Returns a list of offer categories based on the specified country id.
.DESCRIPTION
The Get-PCOfferCategoriesByMarket cmdlet retrieves a list of offer categories for the specified country id.

.PARAMETER SaToken 
Specifies an authentication token you created with your Partner Center credentials.
.PARAMETER CountryId 
Specifies a two-character ISO 2 country code.
.EXAMPLE
Get-PCOfferCategoriesByMarket -CountryId US

.NOTES
#>
function Get-PCOfferCategoriesByMarket {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][ValidatePattern("^(AR|AU|AT|BE|BG|BR|CA|CH|CL|CN|CZ|DE|DK|EE|ES|FI|FR|GR|HR|HK|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|MX|NL|NO|NZ|PH|PL|PT|RO|RS|RS|RU|SA|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB|ZA)$")][string]$CountryId,
        [Parameter(Mandatory = $true)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/offercategories?Country={0}" -f $CountryId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "OfferCategories")   
}

<#
.SYNOPSIS
Retrieves a list of address rules for a specified market.

.DESCRIPTION
The Get-PCAddressRulesByMarket returns a list of rules for the specified market.

.PARAMETER SaToken 
Specifies an authentication token you have created with your Partner Center Credentials.

.PARAMETER CountryId 
Specifies a two-character ISO 2 country code.

.EXAMPLE
Returns the address rules for the US.

Get-PCAddressRulesByMarket -CountryId US

.NOTES
You need to have a authentication Credential already established before running this cmdlet.

#>
function Get-PCAddressRulesByMarket {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][ValidatePattern("^(AR|AU|AT|BE|BG|BR|CA|CH|CL|CN|CZ|DE|DK|EE|ES|FI|FR|GR|HR|HK|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|MX|NL|NO|NZ|PH|PL|PT|RO|RS|RS|RU|SA|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB|ZA)$")][string]$CountryId,         
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/Countryvalidationrules/{0}" -f $CountryId

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "MarketRules")   
}

<#
.SYNOPSIS
Retrieves the Azure services rate card for the specified region.

.DESCRIPTION
The Get-PCAzureRateCard returns a list of Azure rates for the specified region.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.PARAMETER Region 
Specifies a two-character ISO 2 country code.

.PARAMETER Currency 
Specifies a three-character ISO currency code.

.EXAMPLE
Get-PCAzureRateCard -region US -currency USD

Returns the Azure rate card for the specified region and currency.
.NOTES
You need to have a authentication Credential already established before running this cmdlet. The region and the currency must match to return a result.

#>
function Get-PCAzureRateCard {
    [CmdletBinding()]
    param (
        [ValidatePattern("^(USD|AUD|CAD|CHF|DKK|EUR|GBP|INR|JPY|KRW|NOK|NZD|RUB|TWD|CNY|TRY|BRL|SEK|MXN|ZAR|IDR|HKD|MYR)$")][string]$Currency, 
        [ValidatePattern("^(AR|AU|AT|BE|BG|BR|CA|CH|CL|CN|CZ|DE|DK|EE|ES|FI|FR|GR|HR|HK|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|MX|NL|NO|NZ|PH|PL|PT|RO|RS|RS|RU|SA|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB|ZA)$")][string]$Region,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/ratecards/azure?&currency={0}&region={1}" -f $Currency, $Region

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureRateCard")   
}


<#
.SYNOPSIS
Retrieves the products available for the specified country Id and target view.

.DESCRIPTION
The Get-PCProduct returns a list of products available.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.

.PARAMETER CountryId 
Required. Specifies a two-character ISO 2 country code.

.PARAMETER ProductId
Optional. Specifies a product id for which to retrieve details.

.PARAMETER ShowSKUs
Optional when product Id is specified. This returns a list of SKUs for the specified product id.


.PARAMETER TargetView
Required if product Id is not specified. Specifies a target catalog to view. Valid options are Azure, OnlineServices, and Software

.PARAMETER TargetSegment
Optional. Specifies a target segment to view. Valid options are commercial, education, government, and nonprofit

.EXAMPLE
Get-PCProduct -CountryId US -TargetView Azure

Returns the products available in the country Id for the Azure catalog.

.NOTES
You must have an authentication credential already established before running this cmdlet. The partner must be authorized for the specified country id.

#>
function Get-PCProduct {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][ValidatePattern("^(AR|AU|AT|BE|BG|BR|CA|CH|CL|CN|CZ|DE|DK|EE|ES|FI|FR|GR|HR|HK|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|MX|NL|NO|NZ|PH|PL|PT|RO|RS|RS|RU|SA|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB|ZA)$")][string]$CountryId,
        [Parameter(Mandatory = $false, ParameterSetName = 'ProductId')][string]$ProductId,
        [Parameter(Mandatory = $false, ParameterSetName = 'ProductId')][switch]$ShowSKUs,
        [Parameter(Mandatory = $true, ParameterSetName = 'noProductId')][ValidateSet("Azure", "OnlineServices", "Software")][string]$TargetView,
        [Parameter(Mandatory = $false, ParameterSetName = 'noProductId')][ValidateSet("commercial", "education", "government", "nonprofit")][string]$TargetSegment,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $obj = @()
    if ($ProductId) {

        if ($ShowSKUs) {
            $url = "https://api.partnercenter.microsoft.com/v1/products/{0}/skus?Country={1}" -f $ProductId, $CountryId
            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response # | ConvertFrom-Json
            return (_formatResult -obj $obj -type "ProductSku")    
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/products/{0}?Country={1}" -f $ProductId, $CountryId
        }
     
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response # | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Product")     
    }
    else {
        if ($TargetSegment) {
            $url = "https://api.partnercenter.microsoft.com/v1/products?Country={0}&targetView={1}&targetSegment{2}" -f $CountryId, $TargetView, $TargetSegment
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/products?Country={0}&targetView={1}" -f $CountryId, $TargetView
        }

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response # | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Product")
        
    }
}