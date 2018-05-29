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

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER All 

.PARAMETER SubscriptionId

.PARAMETER AddOns 

.PARAMETER PartnerId 

.PARAMETER Size

.PARAMETER OrderId

.EXAMPLE

.NOTES
#>
function Get-PCSubscription
{
    [CmdletBinding()]

    Param(
            [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
            [Parameter(ParameterSetName='all', Mandatory = $false)][switch]$All,
            [Parameter(ParameterSetName='SubscriptionId', Mandatory = $false)][String]$SubscriptionId,
            [Parameter(ParameterSetName='SubscriptionId', Mandatory = $false)][switch]$AddOns,           
            [Parameter(ParameterSetName='partnerId', Mandatory = $true)][String]$PartnerId,
            [Parameter(ParameterSetName='partnerId',Mandatory = $false)][int]$Size = 200,
            [Parameter(ParameterSetName='OrderId', Mandatory = $false)][string]$OrderId,
            [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)


    function Private:Get-SubscriptionsAllInner ($SaToken, $TenantId)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $TenantId
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Subscription") 
    }

    function Private:Get-SubscriptionInner ($SaToken, $TenantId, $SubscriptionId,$AddOns)
    {
        $obj = @()
        if($SubscriptionId)
        {
            if ($addons)
            {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}/addons" -f $TenantId, $SubscriptionId
                $headers = @{Authorization="Bearer $SaToken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "SubscriptionAddons")   
            }
            else {
                $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}" -f $TenantId, $SubscriptionId
                $headers = @{Authorization="Bearer $SaToken"}

                $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
                $obj += $response.Substring(1) | ConvertFrom-Json
                return (_formatResult -obj $obj -type "Subscription") 
            }
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $TenantId
            $headers = @{Authorization="Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
    }

    function Private:Get-SubscriptionPartnerInner ($SaToken, $TenantId, $partnerId, $size)
    {
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions?mpn_id={1}&offset=0&size={2}" -f $TenantId,$partnerId,$size
        $headers = @{Authorization="Bearer $SaToken"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return (_formatResult -obj $obj -type "Subscription") 
    }

    function Private:Get-SubscriptionByOrderInner ($SaToken, $TenantId, $OrderId)
    {
        $obj = @()
        if($OrderId)
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions?order_id={1}" -f $TenantId, $OrderId
            $headers = @{Authorization="Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
        else
        {
            $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions" -f $TenantId
            $headers = @{Authorization="Bearer $SaToken"}

            $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
            $obj += $response.Substring(1) | ConvertFrom-Json
            return (_formatResult -obj $obj -type "Subscription") 
        }
    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "SubscriptionId" {$res = Get-SubscriptionInner -SaToken $SaToken -TenantId $TenantId -SubscriptionId $SubscriptionId -addons $addons
                          return $res}

        "partnerId"      {$res = Get-SubscriptionPartnerInner -SaToken $SaToken -TenantId $TenantId -partnerId $partnerId -size $size
                          return $res}

        "OrderId"        {$res = Get-SubscriptionByOrderInner -SaToken $SaToken -TenantId $TenantId -OrderId $OrderId
                          return $res}

        "all"        {$res = Get-SubscriptionsAllInner -SaToken $SaToken -TenantId $TenantId
                          return $res}
    }

}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER SaToken 
The authentication token you have created with your Partner Center Credentials.
.PARAMETER TenantId 

.PARAMETER Subscription 

.PARAMETER Status 

.PARAMETER FriendlyName 

.PARAMETER AutoRenewEnabled 

.PARAMETER Quantity 

.EXAMPLE

.NOTES
#>
function Set-PCSubscription
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)][String]$TenantId=$GlobalCustomerId,
        [Parameter(Mandatory = $true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)][PSCustomObject]$Subscription,
        [Parameter(Mandatory = $false)][ValidateSet("none","active","suspended","deleted")][String]$Status,
        [Parameter(Mandatory = $false)][String]$FriendlyName,
        [Parameter(Mandatory = $false)][ValidateSet("enabled","disabled")][String]$AutoRenewEnabled,
        [Parameter(Mandatory = $false)][int]$Quantity,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)
    _testTenantContext ($TenantId)  

    $obj = @()

    $actualSubscription = Get-PCSubscription -SaToken $SaToken -TenantId $TenantId -SubscriptionId $Subscription.Id

    if($Status)          {$actualSubscription.status = $status}
    if($FriendlyName){$actualSubscription.friendlyName = $FriendlyName}
    if($AutoRenewEnabled -eq "enabled")    {$actualSubscription.autoRenewEnabled = $true}
    if($AutoRenewEnabled -eq "disabled")    {$actualSubscription.autoRenewEnabled = $false}
    if(($Quantity) -and ($actualSubscription.billingType -eq "license")) {$actualSubscription.quantity = $quantity}

    $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/subscriptions/{1}" -f $TenantId, $Subscription.Id
    $headers = @{Authorization="Bearer $SaToken"}
    $body = $actualSubscription | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "Subscription") 
}
