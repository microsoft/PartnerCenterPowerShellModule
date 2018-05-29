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

<#


.DESCRIPTION

.PARAMETER SaToken 

.PARAMETER CountryId 

.PARAMETER OfferId

.PARAMETER LocaleId

.PARAMETER AddOns 

.EXAMPLE

.NOTES
#>
function Get-PCOffer {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string]$CountryId,
        [Parameter(Mandatory = $false)][string]$OfferId,
        [Parameter(Mandatory = $false)][string]$LocaleId,
        [Parameter(Mandatory = $false)][switch]$AddOns,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    if ($OfferId) {
        if ($addons) {
            $url = "https://api.partnercenter.microsoft.com/v1/offers/{0}/addons?Country={1}" -f $OfferId, $CountryId
            $headers = @{Authorization = "Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "OfferAddons")   
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/offers/{0}?Country={1}&locale={2}" -f $OfferId, $CountryId, $LocaleId
            $headers = @{Authorization = "Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")     
        }
    }
    else {
        if ($LocaleId) {
            $url = "https://api.partnercenter.microsoft.com/v1/offers?Country={0}&locale={1}" -f $CountryId, $LocaleId
            $headers = @{Authorization = "Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")
        }
        else {
            $url = "https://api.partnercenter.microsoft.com/v1/offers?Country={0}" -f $CountryId
            $headers = @{Authorization = "Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Offer")
        }
    }
}

<#


.DESCRIPTION

.PARAMETER SaToken 

.PARAMETER CountryId 

.EXAMPLE

.NOTES
#>
function Get-PCOfferCategoriesByMarket {
    [CmdletBinding()]
    param(
        $CountryId,
        [Parameter(Mandatory = $true)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/offercategories?Country={0}" -f $CountryId
    $headers = @{Authorization = "Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "OfferCategories")   
}

<#

Retrieves a list of address rules for a specified market.

.DESCRIPTION
The Get-PCAddressRulesByMarket returns a list of rules for the specified market.

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.PARAMETER CountryId 
The two-character ISO alpha-2 Country code.

.EXAMPLE
Returns the address rules for the US.

Get-PCAddressRulesByMarket -CountryId US

.NOTES
You need to have a authentication Credential already established before running this cmdlet.

#>
function Get-PCAddressRulesByMarket {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]$CountryId,         
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/Countryvalidationrules/{0}" -f $CountryId
    $headers = @{Authorization = "Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "MarketRules")   
}

<#

Retrieves the Azure services rate card for the specified region.

.DESCRIPTION
The Get-PCAzureRateCard returns a list of Azure rates for the specified region.

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.

.PARAMETER region 
The two-character ISO alpha-2 Country code.

.PARAMETER currency 
The three-character ISO currency code.

.EXAMPLE
Returns the Azure rate card for the specified region and currency.

Get-PCAzureRateCard -region US -currency USD

.NOTES
You need to have a authentication Credential already established before running this cmdlet. The region and the currency must match to return a result.

#>
function Get-PCAzureRateCard {
    [CmdletBinding()]
    param (
        [ValidatePattern("^(NOK|SZL|SEK|CHF|CHE|CHW|SYP|TWD|TJS|TZS|THB|USD|XOF|NZD|TOP|TTD|TND|TRY|TMT|USD|AUD|UGX|UAH|AED|GBP|USD|USD|USN|UYU|UYI|UZS|VUV|VEF|VND|USD|USD|XPF|MAD|YER|ZMW|ZWL|XBA|XBB|XBC|XBD|XTS|XXX|XAU|XPD|XPT|XAG)$")][string]$Currency, 
        [ValidatePattern("^(AF|AX|AL|DZ|AS|AD|AO|AI|AQ|AG|AR|AM|AW|AU|AT|AZ|BS|BH|BD|BB|BY|BE|BZ|BJ|BM|BT|BO|BQ|BA|BW|BV|BR|IO|BN|BG|BF|BI|KH|CM|CA|CV|KY|CF|TD|CL|CN|CX|CC|CO|KM|CG|CD|CK|CR|CI|HR|CU|CW|CY|CZ|DK|DJ|DM|DO|EC|EG|SV|GQ|ER|EE|ET|FK|FO|FJ|FI|FR|GF|PF|TF|GA|GM|GE|DE|GH|GI|GR|GL|GD|GP|GU|GT|GG|GN|GW|GY|HT|HM|VA|HN|HK|HU|IS|IN|ID|IR|IQ|IE|IM|IL|IT|JM|JP|JE|JO|KZ|KE|KI|KP|KR|KW|KG|LA|LV|LB|LS|LR|LY|LI|LT|LU|MO|MK|MG|MW|MY|MV|ML|MT|MH|MQ|MR|MU|YT|MX|FM|MD|MC|MN|ME|MS|MA|MZ|MM|NA|NR|NP|NL|NC|NZ|NI|NE|NG|NU|NF|MP|NO|OM|PK|PW|PS|PA|PG|PY|PE|PH|PN|PL|PT|PR|QA|RE|RO|RU|RW|BL|SH|KN|LC|MF|PM|VC|WS|SM|ST|SA|SN|RS|SC|SL|SG|SX|SK|SI|SB|SO|ZA|GS|SS|ES|LK|SD|SR|SJ|SZ|SE|CH|SY|TW|TJ|TZ|TH|TL|TG|TK|TO|TT|TN|TR|TM|TC|TV|UG|UA|AE|GB|US|UM|UY|UZ|VU|VE|VN|VG|VI|WF|EH|YE|ZM|ZW)$")][string]$Region,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

   
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/ratecards/azure?&currency={0}&region={1}" -f $Currency, $Region
    $headers = @{Authorization = "Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "AzureRateCard")   
}