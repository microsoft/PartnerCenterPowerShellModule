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

function Get-PCOrder 
{
    [CmdletBinding()]
    param ([Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
    [string]$orderid,
    [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    if ($orderid)
    {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $tenantid,$orderid
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Order")  
    }
    else
    {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders" -f $tenantid
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Order")  
    }
}

function New-PCOrder
{
    [CmdletBinding()]
      param( [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
             [Parameter(ParameterSetName='Addon',Mandatory = $true)][string]$orderid,
             [Parameter(ParameterSetName='ByArray',Mandatory = $true)][Parameter(ParameterSetName='Addon')][Array]$LineItems,
             [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][string]$OfferId,
             [Parameter(ParameterSetName='AllDetails',Mandatory = $true)][uint16]$Quantity,
             [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][string]$FriendlyName,
             [Parameter(ParameterSetName='AllDetails',Mandatory = $false)][string]$PartnerIdOnRecord,
             [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $headers  = @{"Authorization"="Bearer $satoken"}
    $headers += @{"MS-Contract-Version"="v1"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    if ($orderid)
    {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $tenantid, $orderid

        $order = [Order]::new($tenantid, $LineItems)
        $body = $order | ConvertTo-Json -Depth 100

        $method = "PATCH"
    }
    else
    {
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders" -f $tenantid

        switch ($PsCmdlet.ParameterSetName)
        {
            'ByArray'    { $order = [Order]::new($tenantid,$LineItems)}
            'AllDetails' { $lineItems_tmp = [OrderLineItem]::new(0,$OfferId,$Quantity)
                           if ($FriendlyName){$lineItems_tmp.FriendlyName = $FriendlyName}
                           if ($PartnerIdOnRecord){$lineItems_tmp.PartnerIdOnRecord = $PartnerIdOnRecord}
                           $arr = @()
                           $arr += $lineItems_tmp
                           $order = [Order]::new($tenantid,$arr)}
        }

        $body = $order | ConvertTo-Json -Depth 100
        $method = "POST"
    }

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method $method #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Order")  
}

function New-PCAddonOrder
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
        [Parameter(Mandatory = $true)][string]$orderid,
        [Parameter(Mandatory = $true)][Array]$LineItems,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
   _testTokenContext($satoken)
   _testTenantContext ($tenantid)
   Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $tenantid, $orderid
    $headers  = @{"Authorization"="Bearer $satoken"}
    $headers += @{"MS-Contract-Version"="v1"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}

    $order = [Order]::new($tenantid, $LineItems)
    $body = $order | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Order")
}

<#
function Set-Order
{
    [CmdletBinding()]
    param  ([Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$order,
            [Parameter(Mandatory = $true)][uint16]$LineItemNumber,
            [Parameter(Mandatory = $false)][string]$FriendlyName,
            [Parameter(Mandatory = $false)][uint16]$Quantity,
            [Parameter(Mandatory = $false)][ValidateSet('Unknown','Monthly','Annual','None')][string]$BillingCycleType,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken)
    $obj = @()
    _testTokenContext($satoken)
    $actualOrder = Get-PCOrder -tenantID $order.ReferenceCustomerId -orderID $order.id -satoken $satoken

    if ($FriendlyName) { $actualOrder.lineItems[$LineItemNumber].friendlyName = $FriendlyName}
    if ($quantity) {$actualOrder.lineItems[$LineItemNumber].Quantity = $quantity}
    if ($BillingCycleType){$actualOrder.BillingCycleType = $BillingCycleType}

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/orders/{1}" -f $order.ReferenceCustomerId, $order.id
    $headers  = @{"Authorization"="Bearer $satoken"}
    $headers += @{"MS-Contract-Version"="v1"}
    $headers += @{"MS-RequestId"=[Guid]::NewGuid()}
    $headers += @{"MS-CorrelationId"=[Guid]::NewGuid()}
    $body = $actualOrder | ConvertTo-Json -Depth 100

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $body -Method "PATCH" #-Debug -Verbose 
}
#>

function New-OrderLineItem
{
    [CmdletBinding()]
    Param ([uint16] $LineItemNumber,[string] $OfferId,[uint16] $Quantity, [string]$FriendlyName)
    $LineItem =  [OrderLineItem]::new($LineItemNumber,$OfferId,$Quantity)
    if ($FriendlyName){$LineItem.FriendlyName = $FriendlyName}
    return $LineItem

}