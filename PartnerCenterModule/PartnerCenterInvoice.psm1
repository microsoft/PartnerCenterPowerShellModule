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
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER all 

.PARAMETER invoiceId 

.PARAMETER summary

.EXAMPLE

.NOTES
#>
function Get-PCInvoice
{
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName='allinvoices', Mandatory = $false)][switch]$all,
        [Parameter(ParameterSetName='invoice', Mandatory = $false)][String]$invoiceId,
        [Parameter(ParameterSetName='summary',Mandatory = $false)][switch]$summary,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
        #[Parameter(ParameterSetName='detailurl',Mandatory = $false)][switch]$detailurl
    )
   _testTokenContext($saToken)

   function Private:Get-InvoiceSummaryInner($saToken)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/invoices/summary"
        $headers = @{Authorization="Bearer $saToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice")   
    }

    function Private:Get-InvoiceByIdInner($saToken, $invoiceId)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}" -f $invoiceId
        $headers = @{Authorization="Bearer $saToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice") 
    }

    function Private:Get-AllInvoicesInner($saToken)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/invoices"
        $headers = @{Authorization="Bearer $saToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice") 
    }

<#deprecated
    function Private:Get-InvoiceDetailInner($saToken, $detailurl)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1{0}" -f $detailurl
        $headers = @{Authorization="Bearer $saToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Invoice") 
    }
#>

    switch ($PsCmdlet.ParameterSetName)
    {
        "summary" {$res = Get-InvoiceSummaryInner -saToken $saToken
                          return $res}
        "invoice"{$res = Get-InvoiceByIdInner -saToken $saToken -invoiceID $invoiceId
                          return $res}
        "allinvoices"    {$res = Get-AllInvoicesInner -saToken $saToken
                          return $res}
        <#deprecated
        "detailurl"    {$res = Get-InvoiceDetailInner -saToken $saToken -detailurl $detailurl
                          return $res}
                          #>
    }
}

function Get-PCInvoiceLineItems
{
    [CmdletBinding()]

    Param(
         [Parameter(Mandatory = $true)][String]$invoiceId,
         [Parameter(Mandatory = $true)][ValidateSet("Azure","Office")][string]$billingProvider,
         [Parameter(Mandatory = $true)][ValidateSet("BillingLineItems","UsageLineItems")][string]$invoicelineitemtype,
         [Parameter(Mandatory = $false)][int]$size = 200,
         [Parameter(Mandatory = $false)][int]$offset = 0,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
   _testTokenContext($saToken)

   Write-Warning "  Get-PCInvoiceLineItems is deprecated and will not be available in future releases, use Get-PCInvoiceLineItem instead."

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}/lineitems/{1}/{2}?size={3}&offset={4}" -f $invoiceId, $billingProvider, $invoicelineitemtype, $size, $offset

    $headers = @{Authorization="Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response
    return (_formatResult -obj $obj -type "Invoice") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER billingProvider 

.PARAMETER invoiceLineItemType 
Valid inputs are BillingLineItems or UsageLineItems

.PARAMETER size

.PARAMETER offset

.EXAMPLE

.NOTES
#>
function Get-PCInvoiceLineItem
{
    [CmdletBinding()]

    Param(
         [Parameter(Mandatory = $true)][String]$invoiceId,
         [Parameter(Mandatory = $true)][ValidateSet("Azure","Office")][string]$billingProvider,
         [Parameter(Mandatory = $true)][ValidateSet("BillingLineItems","UsageLineItems")][string]$invoiceLineItemType,
         [Parameter(Mandatory = $false)][int]$size = 200,
         [Parameter(Mandatory = $false)][int]$offset = 0,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
   _testTokenContext($saToken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}/lineitems/{1}/{2}?size={3}&offset={4}" -f $invoiceId, $billingProvider, $invoicelineitemtype, $size, $offset

    $headers = @{Authorization="Bearer $saToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response
    return (_formatResult -obj $obj -type "Invoice") 
}