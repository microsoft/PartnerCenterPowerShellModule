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
<<<<<<< HEAD
TODO

.DESCRIPTION
The Get-PCOrder cmdlet returns a list of orders or information about a specific order.
=======

.DESCRIPTION
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.

.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER OrderId 
Specifies the order id for which to return information.
.EXAMPLE
Return all orders for the specified customer tenant.
  Get-PCOrder -TenantId 3c762ceb-b839-4b4a-85d8-0e7304c89f62

.EXAMPLE
<<<<<<< HEAD
Get the specified customer order
  Get-PCOrder -TenantId -TenantId '3c762ceb-b839-4b4a-85d8-0e7304c89f62' -OrderId '1168c0f1-f0ed-4f9a-9e8c-1dcac072cba8'
=======

>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
.NOTES
#>
function Get-PCOrder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [string]$OrderId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    if ($OrderId) {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $TenantId, $OrderId

        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Order")  
    }
    else {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders" -f $TenantId
        
        $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
        $headers.Add("Authorization", "Bearer $SaToken")
        $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Order")  
    }
}

<#
.SYNOPSIS
<<<<<<< HEAD
Creates a new order.
.DESCRIPTION
The New-PCOrder cmdlet creates a new order.
=======

.DESCRIPTION

>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER OrderId 
<<<<<<< HEAD
Specifies the order id if this is an add on order.
.PARAMETER LineItems 
Specifies line items to include in the order
=======

.PARAMETER lineItems 

>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
.PARAMETER OfferId 
Specifies the offer id guid for the ordered items.
.PARAMETER Quantity
Specifies the number of licenses for a license-based subscription or instances for an Azure reservation.
.PARAMETER FriendlyName
Optional. The friendly name for the subscription defined by the partner to help disambiguate.
.PARAMETER PartnerIdOnRecord 
When an indirect provider places an order on behalf of an indirect reseller, populate this field with the MPN ID of the indirect reseller only (never the ID of the indirect provider). This ensures proper accounting for incentives.
.EXAMPLE
Order a new subscription

Select a customer
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
 Get offer
    $offer = Get-PCOffer -CountryId '<Country two digits id>' -OfferId '<offer id GUID>'

Create the OrderLineItem
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $offer.id
    $lineItems[0].Quantity = <quantity>

Send order
    New-PCOrder -TenantId $customer.id -LineItems $lineItems

.EXAMPLE
<<<<<<< HEAD
Order an Add on to an existing subscription
Get subscription
    $subscription = Get-PCSubscription -TenantId $customer.id -subscriptionid '<subscription id>'

Get list of addons available for the subscription offer
    $addons = Get-PCOffer -CountryId '<Country two digits id>' -OfferId $subscription.OfferId -addons

Get addon offer
    $addon = Get-PCOffer -CountryId 'US' -OfferId '<offer id>'

Get subscription order
    $order = Get-PCOrder -TenantId $customer.id -OrderId $subscription.OrderId

Get the next OrderLineItem number

    $newLineItemNumber = $order.lineItems.Count

Create the addon OrderLineItem
    $lineItems = @()
    $lineItems += [OrderLineItem]::new()
    $lineItems[0].LineItemNumber = 0
    $lineItems[0].FriendlyName = '<friendly name>'
    $lineItems[0].OfferId = $addon.id
    $lineItems[0].ParentSubscriptionId = $subscription.id
    $lineItems[0].Quantity = <quantity>

Send order
    New-PCOrder -TenantId $customer.id -OrderId $order.id -LineItems $lineItems
=======
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.

.NOTES
#>
function New-PCOrder {
    [CmdletBinding()]
    param( 
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(ParameterSetName = 'Addon', Mandatory = $true)][string]$OrderId,
        [Parameter(ParameterSetName = 'ByArray', Mandatory = $true)][Parameter(ParameterSetName = 'Addon')][Array]$LineItems,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][string]$OfferId,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $true)][uint16]$Quantity,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][string]$FriendlyName,
        [Parameter(ParameterSetName = 'AllDetails', Mandatory = $false)][string]$PartnerIdOnRecord,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $headers = @{"Authorization" = "Bearer $SaToken"}
    $headers += @{"MS-Contract-Version" = "v1"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    if ($OrderId) {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $TenantId, $OrderId

        $order = [Order]::new($TenantId, $LineItems)
        $body = $order | ConvertTo-Json -Depth 100

        $method = "PATCH"
    }
    else {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders" -f $TenantId

        switch ($PsCmdlet.ParameterSetName) {
            'ByArray' { $order = [Order]::new($TenantId, $LineItems)}
            'AllDetails' {
                $lineItems_tmp = [OrderLineItem]::new(0, $OfferId, $Quantity)
                if ($FriendlyName) {$lineItems_tmp.friendlyName = $FriendlyName}
                if ($PartnerIdOnRecord) {$lineItems_tmp.partnerIdOnRecord = $PartnerIdOnRecord}
                $arr = @()
                $arr += $lineItems_tmp
                $order = [Order]::new($TenantId, $arr)
            }
        }

        $body = $order | ConvertTo-Json -Depth 100
        $method = "POST"
    }

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method $method #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Order")  
}

<#
.SYNOPSIS

.DESCRIPTION
<<<<<<< HEAD
The New-PCAddonOrder cmdlet creates a new addon order for an already created order.
.PARAMETER SaToken
Specifies an authentication token with your Partner Center credentials.
=======

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER OrderId 
Specifies the order id for which to associate the add on.
.PARAMETER LineItems 
Specifies the line items.
.EXAMPLE

.NOTES
#>
function New-PCAddonOrder {
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $false)][String]$TenantId = $GlobalCustomerId,
        [Parameter(Mandatory = $true)][string]$OrderId,
        [Parameter(Mandatory = $true)][Array]$LineItems,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)

    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $TenantId, $OrderId
    $headers = @{"Authorization" = "Bearer $SaToken"}
    $headers += @{"MS-Contract-Version" = "v1"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}

    $order = [Order]::new($TenantId, $LineItems)
    $body = $order | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Order")
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Set-PCOrder cmdlet
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER Order
Specifies the order to modify.
.PARAMETER LineItemNumber
Specifies a line item number to modify
.PARAMETER FriendlyName
Specifies a friendly name for the order.
.PARAMETER Quantity
Specifies the quantity of items on the specified order line item.

.PARAMETER BillingCycleType
Specifies the billing cycle type. Valid values are: unknown, monthly, annual, none.
.EXAMPLE
Set-PCOrder
.NOTES

#>
function Set-PCOrder {
    [CmdletBinding()]
    param  ([Parameter(Mandatory = $true, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)][PSCustomObject]$order,
        [Parameter(Mandatory = $true)][uint16]$LineItemNumber,
        [Parameter(Mandatory = $false)][string]$FriendlyName,
        [Parameter(Mandatory = $false)][uint16]$Quantity,
        [Parameter(Mandatory = $false)][ValidateSet('Unknown', 'Monthly', 'Annual', 'None')][string]$BillingCycleType,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
        )
    
    $obj = @()
    _testTokenContext($SaToken)
    $actualOrder = Get-PCOrder -tenantID $order.referenceCustomerId -orderID $Order.id -SaToken $SaToken

    if ($FriendlyName) { $actualOrder.lineItems[$LineItemNumber].friendlyName = $FriendlyName}
    if ($Quantity) {$actualOrder.lineItems[$LineItemNumber].quantity = $Quantity}
    if ($BillingCycleType) {$actualOrder.billingCycleType = $BillingCycleType}

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $order.referenceCustomerId, $Order.id
    $headers = @{"Authorization" = "Bearer $SaToken"}
    $headers += @{"MS-Contract-Version" = "v1"}
    $headers += @{"MS-RequestId" = [Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId" = [Guid]::NewGuid()}
    $body = $actualOrder | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose 
    $obj += $response.Substring(1) | ConvertFrom-Json
    return $obj
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER LineItemNumber 
Specifies the line number of the order to add the line item. Specifying an existing line item will overwrite the current line item.
.PARAMETER OfferId
Specifies the offer id for which to purchase. Use Get-PCOffer to list offers available in your region.
.PARAMETER Quantity
Specifies a quantity of licenses to purchase for this line item.
.PARAMETER FriendlyName
Specifies a friendly name for the line item.
.EXAMPLE
<<<<<<< HEAD
New-OrderLineItem
=======
>>>>>>> parent of d3de9aa... Removed deprecated cmdlets.

.NOTES
TODO
#>
function New-OrderLineItem {
    [CmdletBinding()]
    Param (
        [uint16] $LineItemNumber,
        [string] $OfferId,
        [uint16] $Quantity, 
        [string] $FriendlyName
        
    )
    $LineItem = [OrderLineItem]::new($LineItemNumber, $OfferId, $Quantity)
    if ($FriendlyName) {$LineItem.friendlyName = $FriendlyName}
    return $LineItem

}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The New-PCCart cmdlet creates a new cart.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER SubscriptionId
Specifies the subscription 

.EXAMPLE
New-PCCart -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c

.NOTES

#>
function New-PCCart {
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'TenantId', Mandatory = $true)][String]$TenantId,
        [Parameter(Mandatory = $true)][string]$SubscriptionId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    
    return $null
}

<#
.SYNOPSIS
TODO
.DESCRIPTION
The Set-PCCart cmdlet modifies the cart.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant used for scoping this cmdlet.
.PARAMETER CartId
Specifies the cart id that you will modify.

.EXAMPLE
New-PCCart -TenantId 97037612-799c-4fa6-8c40-68be72c6b83c

.NOTES

#>
function Set-PCCart {
    [CmdletBinding()]
    Param(
        [Parameter(ParameterSetName = 'TenantId', Mandatory = $true)][String]$TenantId,
        [Parameter(Mandatory = $true)][string]$CartId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    return $null
}