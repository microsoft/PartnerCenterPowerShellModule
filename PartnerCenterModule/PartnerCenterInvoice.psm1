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
The Get-PCInvoice cmdlet retrieves either a specific invoice or a list of invoices. This cmdlet requires App+User authentication.

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER InvoiceId 
Specifies an invoice id to return.

.PARAMETER Summary
Specifies whether to retrieve a summary of the invoice.

.EXAMPLE
Get-PCInvoice
Return a list of all invoices.

.EXAMPLE
Get-PCInvoice -InvoiceId D030001IZ6
Return the specified invoice

.EXAMPLE
Get-PCInvoice -InvoiceId D030001IZ6 -Summary
Return a summary for the specified invoice

.NOTES
This cmdlet requires App+User authentication.
#>
function Get-PCInvoice {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $false)][String]$InvoiceId,
        [Parameter(Mandatory = $false)][switch]$Summary,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        #[Parameter(ParameterSetName='detailUrl',Mandatory = $false)][switch]$detailUrl
    )
    _testTokenContext($SaToken)

    function Private:Get-InvoiceSummaryInner($SaToken) {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/invoices/summary"
        
        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice")   
    }

    function Private:Get-InvoiceByIdInner($SaToken, $InvoiceId) {
        $obj = @()
        if ($InvoiceId -ne $null) {
            $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}" -f $InvoiceId
        }
        else {

            $url = "https://api.partnercenter.microsoft.com/v1/invoices"
        }

        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)
 
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice") 
    }

    If ($Summary) {
        $res = Get-InvoiceSummaryInner -SaToken $SaToken
        return $res
    }
    else {
        $res = Get-InvoiceByIdInner -SaToken $SaToken -InvoiceID $InvoiceId
        return $res
    }

    <#"allInvoices" {$res = Get-AllInvoicesInner -SaToken $SaToken
        return $res}
        #>
    <#deprecated
        "detailUrl"    {$res = Get-InvoiceDetailInner -SaToken $SaToken -detailUrl $detailUrl
                          return $res}
                          #>
}

<#
.SYNOPSIS
TODO

.DESCRIPTION
The Get-PCInvoiceLineItem cmdlet. 

.PARAMETER SaToken 
Specifies a security token for authenticating and executing the cmdlet.

.PARAMETER InvoiceId 
Specifies the invoice id to retrieve.

.PARAMETER BillingProvider 
Specifies either Azure or Office.

.PARAMETER InvoiceLineItemType 
Specifies either BillingLineItems for invoiced licence-based services or UsageLineItems for invoiced usage-based services.

.PARAMETER ResultSize
Specifies the maximum number of results to return. The default value is 200.

.PARAMETER Offset
Specifies an offset

.EXAMPLE
Get-PCInvoiceLineItem -InvoiceId 12345678 -BillingProvider Azure -InvoiceLineItemType UsageLineItems

Retrieve a list of Azure usage from invoice 12345678.

.NOTES
#>
function Get-PCInvoiceLineItem {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $true)][String]$InvoiceId,
        [Parameter(Mandatory = $true)][ValidateSet("Azure", "Office")][string]$BillingProvider,
        [Parameter(Mandatory = $true)][ValidateSet("BillingLineItems", "UsageLineItems")][string]$InvoiceLineItemType,
        [Parameter(Mandatory = $false)][int]$ResultSize= 200,
        [Parameter(Mandatory = $false)][int]$Offset = 0,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}/lineitems/{1}/{2}?size={3}&offset={4}" -f $InvoiceId, $BillingProvider, $InvoiceLineItemType, $ResultSize, $Offset

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response
    return (_formatResult -obj $obj -type "Invoice") 
}