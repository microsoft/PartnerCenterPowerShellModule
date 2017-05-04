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

function Get-GraphAADTokenByUser
{
    [CmdletBinding()]
    param ($resource, $domain, $clientid, [PSCredential]$credential)

    $username = $credential.GetNetworkCredential().userName
    $password = $credential.GetNetworkCredential().Password

    $url  = "https://login.windows.net/{0}/oauth2/token" -f $domain
    $body =         "grant_type=password&"
    $body = $body + "resource=$resource&"
    $body = $body + "client_id=$clientid&"
    $body = $body + "username=$username&"
    $body = $body + "password=$password&"
    $body = $body + "scope=openid"

    $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers
    return $response.access_token
}

function Get-GraphAADTokenByApp
{
    [CmdletBinding()]
    param ($resource, $domain, $clientid, $clientsecret)
    $url  = "https://login.windows.net/{0}/oauth2/token" -f $domain
    $body = "grant_type=client_credentials&"
    $body = $body + "resource=$resource&"
    $body = $body + "client_id=$clientid&"
    $tmp_clientsecret = _unsecureString -string $clientsecret
    $body = $body + "client_secret=$tmp_clientsecret"

    $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers 
	return $response.access_token
}

function Add-PCAuthentication
{
    [CmdletBinding()]
    param ([Parameter(Mandatory=$True,ParameterSetName='app')][Parameter(Mandatory=$True,ParameterSetName='user')][string] $cspAppID,
           [Parameter(Mandatory=$True,ParameterSetName='app')][Parameter(Mandatory=$True,ParameterSetName='user')][string] $cspDomain,
           [Parameter(Mandatory=$True,ParameterSetName='app' )][SecureString]$cspClientSecret,
           [Parameter(Mandatory=$True,ParameterSetName='user')][PSCredential]$credential
    )

    function Private:Add-AuthenticationByUser ($cspAppID,$cspDomain,[PSCredential]$credential)
    {
        $resource = 'https://api.partnercenter.microsoft.com'
        $AADToken = Get-GraphAADTokenByUser -resource $resource -domain $cspDomain -clientid $cspAppID -credential $credential
        $cspUsername = $credential.UserName
        # Get SA token
        try {
            $SAToken = Get-SAToken -aadtoken $AADToken -global $true
            $token = @{"Resource" = $resource ; "Domain" = $cspDomain; "ClientId" =  $cspAppID; "Username" = $cspUsername}
            return $token 
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }

    }

    function Private:Add-AuthenticationBySecret ($cspAppID,$cspDomain,$cspClientSecret)
    {
        $resource = 'https://graph.windows.net' 
        $AADToken = Get-GraphAADTokenByApp -resource $resource -domain $cspDomain -clientid $cspAppID -clientsecret $cspClientSecret

        # Get SA token
        try {
            $SAToken = Get-SAToken -aadtoken $AADToken -global $true
            $token = @{"Resource" = $resource ; "Domain" = $cspDomain; "ClientId" =  $cspAppID; "Username" = $cspUsername}
            return $token 
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }

    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "user"     { $result = Add-AuthenticationByUser   -cspAppID $cspAppID -cspDomain $cspDomain -credential $credential }
        "app"      { $result = Add-AuthenticationBySecret -cspAppID $cspAppID -cspDomain $cspDomain -cspClientSecret $cspClientSecret } 
    }

    Update-ModuleTelemetry -cspDomain $result.Domain
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    return $result
}

function New-PCSAToken
{
    [CmdletBinding()]
    param ([Parameter(Mandatory=$True,ParameterSetName='app')][Parameter(Mandatory=$True,ParameterSetName='user')][string] $cspAppID,
           [Parameter(Mandatory=$True,ParameterSetName='app')][Parameter(Mandatory=$True,ParameterSetName='user')][string] $cspDomain,
           [Parameter(Mandatory=$True,ParameterSetName='app' )][SecureString]$cspClientSecret,
           [Parameter(Mandatory=$True,ParameterSetName='user')][PSCredential]$credential
    )

    function Private:Add-AuthenticationByUser ($cspAppID,$cspDomain,[PSCredential]$credential)
    {
        $resource = 'https://api.partnercenter.microsoft.com'
        $AADToken = Get-GraphAADTokenByUser -resource $resource -domain $cspDomain -clientid $cspAppID -credential $credential
        $cspUsername = $credential.UserName
        # Get SA token
        try {
            $SAToken = Get-SAToken -aadtoken $AADToken -global $false
            $token = @{"Resource" = $resource ; "Domain" = $cspDomain; "ClientId" =  $cspAppID; "Username" = $cspUsername}
            write-host $token
            return $SAToken 
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }
    }

    function Private:Add-AuthenticationBySecret ($cspAppID,$cspDomain,$cspClientSecret)
    {
        $resource = 'https://graph.windows.net' 
        $AADToken = Get-GraphAADTokenByApp -resource $resource -domain $cspDomain -clientid $cspAppID -clientsecret $cspClientSecret

        # Get SA token
        try {
            $SAToken = Get-SAToken -aadtoken $AADToken -global $false
            $token = @{"Resource" = $resource ; "Domain" = $cspDomain; "ClientId" =  $cspAppID; "Username" = $cspUsername}
            write-host $token
            return $SAToken 
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }

    }

    switch ($PsCmdlet.ParameterSetName)
    {
        "user"     { $result = Add-AuthenticationByUser   -cspAppID $cspAppID -cspDomain $cspDomain -credential $credential }
        "app"      { $result = Add-AuthenticationBySecret -cspAppID $cspAppID -cspDomain $cspDomain -cspClientSecret $cspClientSecret } 
    }

    Update-ModuleTelemetry -cspDomain $result.Domain
    Send-ModuleTelemetry -functionName $MyInvocation.MyCommand.Name
    return $result
}