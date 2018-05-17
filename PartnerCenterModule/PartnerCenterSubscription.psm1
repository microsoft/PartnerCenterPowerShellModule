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

function Get-PCSubscription
{
    [CmdletBinding()]

    Param(
            [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
            [Parameter(ParameterSetName='all', Mandatory = $false)][switch]$all,
            [Parameter(ParameterSetName='subscriptionid', Mandatory = $false)][String]$subscriptionid,
            [Parameter(ParameterSetName='subscriptionid', Mandatory = $false)][switch]$addons,           
            [Parameter(ParameterSetName='partnerid', Mandatory = $true)][String]$partnerid,
            [Parameter(ParameterSetName='partnerid',Mandatory = $false)][int]$size = 200,
            [Parameter(ParameterSetName='orderid', Mandatory = $false)][string]$orderid,
            [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name

    function Private:Get-SubscriptionsAllInner ($satoken, $tenantid)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $tenantid
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Subscription") 
    }

    function Private:Get-SubscriptionInner ($satoken, $tenantid, $subscriptionid,$addons)
    {
        $obj = @()
        if($subscriptionid)
        {
            if ($addons)
            {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/addons" -f $tenantid, $subscriptionid
                $headers = @{Authorization="Bearer $satoken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "SubscriptionAddons")   
            }
            else {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}" -f $tenantid, $subscriptionid
                $headers = @{Authorization="Bearer $satoken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "Subscription") 
            }
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $tenantid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
    }

    function Private:Get-SubscriptionPartnerInner ($satoken, $tenantid, $partnerid, $size)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions?mpn_id={1}&offset=0&size={2}" -f $tenantid,$partnerid,$size
        $headers = @{Authorization="Bearer $satoken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Subscription") 
    }

    function Private:Get-SubscriptionByOrderInner ($satoken, $tenantid, $orderid)
    {
        $obj = @()
        if($orderid)
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions?order_id={1}" -f $tenantid, $orderid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $tenantid
            $headers = @{Authorization="Bearer $satoken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "subscriptionid" {$res = Get-SubscriptionInner -satoken $satoken -tenantid $tenantid -subscriptionid $subscriptionid -addons $addons
                          return $res}

        "partnerid"      {$res = Get-SubscriptionPartnerInner -satoken $satoken -tenantid $tenantid -partnerid $partnerid -size $size
                          return $res}

        "orderid"        {$res = Get-SubscriptionByOrderInner -satoken $satoken -tenantid $tenantid -orderid $orderid
                          return $res}

        "all"        {$res = Get-SubscriptionsAllInner -satoken $satoken -tenantid $tenantid
                          return $res}
    }

}

function Set-PCSubscription
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][String]$tenantid=$GlobalCustomerID,
        [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$subscription,
        [Parameter(Mandatory = $false)][ValidateSet("none","active","suspended","deleted")][String]$status,
        [Parameter(Mandatory = $false)][String]$friendlyName,
        [Parameter(Mandatory = $false)][ValidateSet("enabled","disabled")][String]$AutoRenewEnabled,
        [Parameter(Mandatory = $false)][int]$quantity,
        [Parameter(Mandatory = $false)][string]$satoken = $GlobalToken
    )
    _testTokenContext($satoken)
    _testTenantContext ($tenantid)  
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    $obj = @()

    $actualSubscription = Get-PCSubscription -satoken $satoken -tenantid $tenantid -subscriptionid $subscription.Id

    if($status)          {$actualSubscription.status = $status}
    if($friendlyName){$actualSubscription.friendlyName = $friendlyName}
    if($AutoRenewEnabled -eq "enabled")    {$actualSubscription.autoRenewEnabled = $true}
    if($AutoRenewEnabled -eq "disabled")    {$actualSubscription.autoRenewEnabled = $false}
    if(($quantity) -and ($actualSubscription.billingType -eq "license")) {$actualSubscription.quantity = $quantity}

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}" -f $tenantid, $subscription.Id
    $headers = @{Authorization="Bearer $satoken"}
    $body = $actualSubscription | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Subscription") 
}
