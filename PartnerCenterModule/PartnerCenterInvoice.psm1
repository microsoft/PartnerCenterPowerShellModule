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

.PARAMETER SaToken 

.PARAMETER All 

.PARAMETER InvoiceId 

.PARAMETER Summary

.EXAMPLE

.NOTES
#>
function Get-PCInvoice
{
    [CmdletBinding()]

    Param(
        [Parameter(ParameterSetName='allinvoices', Mandatory = $false)][switch]$All,
        [Parameter(ParameterSetName='invoice', Mandatory = $false)][String]$InvoiceId,
        [Parameter(ParameterSetName='summary',Mandatory = $false)][switch]$Summary,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        #[Parameter(ParameterSetName='detailurl',Mandatory = $false)][switch]$detailurl
    )
   _testTokenContext($SaToken)

   function Private:Get-InvoiceSummaryInner($SaToken)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/invoices/summary"
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice")   
    }

    function Private:Get-InvoiceByIdInner($SaToken, $InvoiceId)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}" -f $InvoiceId
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice") 
    }

    function Private:Get-AllInvoicesInner($SaToken)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/invoices"
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response
        return (_formatResult -obj $obj -type "Invoice") 
    }

<#deprecated
    function Private:Get-InvoiceDetailInner($SaToken, $detailurl)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1{0}" -f $detailurl
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Invoice") 
    }
#>

    switch ($PsCmdlet.ParameterSetName)
    {
        "summary" {$res = Get-InvoiceSummaryInner -SaToken $SaToken
                          return $res}
        "invoice"{$res = Get-InvoiceByIdInner -SaToken $SaToken -invoiceID $InvoiceId
                          return $res}
        "allinvoices"    {$res = Get-AllInvoicesInner -SaToken $SaToken
                          return $res}
        <#deprecated
        "detailurl"    {$res = Get-InvoiceDetailInner -SaToken $SaToken -detailurl $detailurl
                          return $res}
                          #>
    }
}

function Get-PCInvoiceLineItems
{
    [CmdletBinding()]

    Param(
         [Parameter(Mandatory = $true)][String]$InvoiceId,
         [Parameter(Mandatory = $true)][ValidateSet("Azure","Office")][string]$BillingProvider,
         [Parameter(Mandatory = $true)][ValidateSet("BillingLineItems","UsageLineItems")][string]$InvoiceLineItemType,
         [Parameter(Mandatory = $false)][int]$Size = 200,
         [Parameter(Mandatory = $false)][int]$Offset = 0,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
   _testTokenContext($SaToken)

   Write-Warning "  Get-PCInvoiceLineItems is deprecated and will not be available in future releases, use Get-PCInvoiceLineItem instead."

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}/lineitems/{1}/{2}?size={3}&offset={4}" -f $InvoiceId, $billingProvider, $invoicelineitemtype, $size, $offset

    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response
    return (_formatResult -obj $obj -type "Invoice") 
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 

.PARAMETER TenantId 

.PARAMETER BillingProvider 

.PARAMETER InvoiceLineItemType 
Valid inputs are BillingLineItems or UsageLineItems

.PARAMETER Size

.PARAMETER Offset

.EXAMPLE

.NOTES
#>
function Get-PCInvoiceLineItem
{
    [CmdletBinding()]

    Param(
         [Parameter(Mandatory = $true)][String]$InvoiceId,
         [Parameter(Mandatory = $true)][ValidateSet("Azure","Office")][string]$BillingProvider,
         [Parameter(Mandatory = $true)][ValidateSet("BillingLineItems","UsageLineItems")][string]$InvoiceLineItemType,
         [Parameter(Mandatory = $false)][int]$Size = 200,
         [Parameter(Mandatory = $false)][int]$Offset = 0,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
   _testTokenContext($SaToken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/invoices/{0}/lineitems/{1}/{2}?size={3}&offset={4}" -f $InvoiceId, $BillingProvider, $InvoiceLineItemType, $Size, $Offset

    $headers = @{Authorization="Bearer $SaToken"}

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response
    return (_formatResult -obj $obj -type "Invoice") 
}