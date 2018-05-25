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

.PARAMETER tenantId 

.PARAMETER all 

.PARAMETER subscriptionId

.PARAMETER addOns 

.PARAMETER partnerId 

.PARAMETER size

.PARAMETER orderId

.EXAMPLE

.NOTES
#>
function Get-PCSubscription
{
    [CmdletBinding()]

    Param(
            [Parameter(Mandatory = $false)][String]$tenantId=$GlobalCustomerID,
            [Parameter(ParameterSetName='all', Mandatory = $false)][switch]$all,
            [Parameter(ParameterSetName='subscriptionId', Mandatory = $false)][String]$subscriptionId,
            [Parameter(ParameterSetName='subscriptionId', Mandatory = $false)][switch]$addOns,           
            [Parameter(ParameterSetName='partnerId', Mandatory = $true)][String]$partnerId,
            [Parameter(ParameterSetName='partnerId',Mandatory = $false)][int]$size = 200,
            [Parameter(ParameterSetName='orderId', Mandatory = $false)][string]$orderId,
            [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)


    function Private:Get-SubscriptionsAllInner ($saToken, $tenantId)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $tenantId
        $headers = @{Authorization="Bearer $saToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Subscription") 
    }

    function Private:Get-SubscriptionInner ($saToken, $tenantId, $subscriptionId,$addons)
    {
        $obj = @()
        if($subscriptionId)
        {
            if ($addons)
            {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/addons" -f $tenantId, $subscriptionId
                $headers = @{Authorization="Bearer $saToken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "SubscriptionAddons")   
            }
            else {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}" -f $tenantId, $subscriptionId
                $headers = @{Authorization="Bearer $saToken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "Subscription") 
            }
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $tenantId
            $headers = @{Authorization="Bearer $saToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
    }

    function Private:Get-SubscriptionPartnerInner ($saToken, $tenantId, $partnerId, $size)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions?mpn_id={1}&offset=0&size={2}" -f $tenantId,$partnerId,$size
        $headers = @{Authorization="Bearer $saToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Subscription") 
    }

    function Private:Get-SubscriptionByOrderInner ($saToken, $tenantId, $orderId)
    {
        $obj = @()
        if($orderId)
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions?order_id={1}" -f $tenantId, $orderId
            $headers = @{Authorization="Bearer $saToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $tenantId
            $headers = @{Authorization="Bearer $saToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "subscriptionId" {$res = Get-SubscriptionInner -saToken $saToken -tenantId $tenantId -subscriptionId $subscriptionId -addons $addons
                          return $res}

        "partnerId"      {$res = Get-SubscriptionPartnerInner -saToken $saToken -tenantId $tenantId -partnerId $partnerId -size $size
                          return $res}

        "orderId"        {$res = Get-SubscriptionByOrderInner -saToken $saToken -tenantId $tenantId -orderId $orderId
                          return $res}

        "all"        {$res = Get-SubscriptionsAllInner -saToken $saToken -tenantId $tenantId
                          return $res}
    }

}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER saToken 

.PARAMETER tenantId 

.PARAMETER subscription 

.PARAMETER status 

.PARAMETER friendlyName 

.PARAMETER autoRenewEnabled 

.PARAMETER quantity 

.EXAMPLE

.NOTES
#>
function Set-PCSubscription
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][String]$tenantId=$GlobalCustomerID,
        [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$subscription,
        [Parameter(Mandatory = $false)][ValidateSet("none","active","suspended","deleted")][String]$status,
        [Parameter(Mandatory = $false)][String]$friendlyName,
        [Parameter(Mandatory = $false)][ValidateSet("enabled","disabled")][String]$autoRenewEnabled,
        [Parameter(Mandatory = $false)][int]$quantity,
        [Parameter(Mandatory = $false)][string]$saToken = $GlobalToken
    )
    _testTokenContext($saToken)
    _testTenantContext ($tenantId)  

    $obj = @()

    $actualSubscription = Get-PCSubscription -saToken $saToken -tenantId $tenantId -subscriptionId $subscription.Id

    if($status)          {$actualSubscription.status = $status}
    if($friendlyName){$actualSubscription.friendlyName = $friendlyName}
    if($autoRenewEnabled -eq "enabled")    {$actualSubscription.autoRenewEnabled = $true}
    if($autoRenewEnabled -eq "disabled")    {$actualSubscription.autoRenewEnabled = $false}
    if(($quantity) -and ($actualSubscription.billingType -eq "license")) {$actualSubscription.quantity = $quantity}

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}" -f $tenantId, $subscription.Id
    $headers = @{Authorization="Bearer $saToken"}
    $body = $actualSubscription | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Subscription") 
}
