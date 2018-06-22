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
Get-PCOffer -CountryId 'US' -localeId 'en-us'
Get all offer details using the Country Id and Locale Id.
.EXAMPLE
Get-PCOffer -CountryId 'US' -OfferId '8AA7E78B-B265-4AC6-ADA0-14900A8A3F94' -addOns
Get add ons for the specified offer id.
.NOTES
#>
function Get-PCOffer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][ValidatePattern("^(BG|BR|CN|CZ|DE|DK|EE|ES|ES|ES|ES|FI|FR|GR|HR|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|NL|NO|PL|PT|RO|RS|RS|RU|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB)$")][string]$CountryId,
        [string]$OfferId,
        [Parameter(Mandatory = $false)][ValidatePattern("^(bg-bg|pt-br|zh-cn|cs-cz|de-de|da-dk|et-ee|ca-es|es-es|eu-es|gl-es|fi-fi|fr-fr|el-gr|hr-hr|hu-hu|id-id|he-il|hi-in|it-it|ja-jp|ko-kr|kk-kz|lt-lt|lv-lv|ms-my|nl-nl|nb-no|pl-pl|pt-pt|ro-ro|sr-cyrl-rs|sr-latn-rs|ru-ru|sv-se|zh-sg|sl-si|sk-sk|th-th|tr-tr|zh-tw|uk-ua|en-us|vi-vn|en-gb)$")][string]$LocaleId,
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

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "OfferAddons")   
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/offers/{0}?Country={1}&locale={2}" -f $OfferId, $CountryId, $LocaleId

            $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
            $headers.Add("Authorization", "Bearer $SaToken")
            $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")     
        }
    }
    else {
        if ($LocaleId) {
            $url = "https://api.partnercenter.microsoft.com/v1/offers?Country={0}&locale={1}" -f $CountryId, $LocaleId

            $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
            $headers.Add("Authorization", "Bearer $SaToken")
            $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/offers?Country={0}" -f $CountryId

            $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
            $headers.Add("Authorization", "Bearer $SaToken")
            $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
            
            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")
        }
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
        [ValidatePattern("^(BG|BR|CN|CZ|DE|DK|EE|ES|ES|ES|ES|FI|FR|GR|HR|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|NL|NO|PL|PT|RO|RS|RS|RU|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB)$")]$CountryId,
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
        [Parameter(Mandatory = $true)][ValidatePattern("^(BG|BR|CN|CZ|DE|DK|EE|ES|ES|ES|ES|FI|FR|GR|HR|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|NL|NO|PL|PT|RO|RS|RS|RU|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB)$")][string]$CountryId,         
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
        [ValidatePattern("^(NOK|SZL|SEK|CHF|CHE|CHW|SYP|TWD|TJS|TZS|THB|USD|XOF|NZD|TOP|TTD|TND|TRY|TMT|USD|AUD|UGX|UAH|AED|GBP|USD|USD|USN|UYU|UYI|UZS|VUV|VEF|VND|USD|USD|XPF|MAD|YER|ZMW|ZWL|XBA|XBB|XBC|XBD|XTS|XXX|XAU|XPD|XPT|XAG|EUR)$")][string]$Currency, 
        [ValidatePattern("^(BG|BR|CN|CZ|DE|DK|EE|ES|ES|ES|ES|FI|FR|GR|HR|HU|ID|IL|IN|IT|JP|KR|KZ|LT|LV|MY|NL|NO|PL|PT|RO|RS|RS|RU|SE|SG|SI|SK|TH|TR|TW|UA|US|VN|GB)$")][string]$Region,
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