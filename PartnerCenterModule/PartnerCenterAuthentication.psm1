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

.PARAMETER Resource 

.PARAMETER Domain 

.PARAMETER ClientId 

.PARAMETER Credential

.EXAMPLE

.NOTES
#>
function Get-GraphAADTokenByUser {
    [CmdletBinding()]
    param (
        $Resource, 
        $Domain, 
        $ClientId, 
        [PSCredential]$Credential
        )

    $username = $Credential.GetNetworkCredential().userName
    $password = $Credential.GetNetworkCredential().Password

    $url = "https://login.windows.net/{0}/oauth2/token" -f $Domain
    $body = "grant_type=password&"
    $body = $body + "resource=$Resource&"
    $body = $body + "client_id=$ClientId&"
    $body = $body + "username=$Username&"
    $body = $body + "password=$Password&"
    $body = $body + "scope=openid"

    $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers
    return $response.access_token
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER Resource 

.PARAMETER Domain 

.PARAMETER ClientId 

.PARAMETER ClientSecret

.EXAMPLE

.NOTES
#>
function Get-GraphAADTokenByApp {
    [CmdletBinding()]
    param (
        $Resource, 
        $Domain, 
        $ClientId, 
        $ClientSecret
    )
    $url = "https://login.windows.net/{0}/oauth2/token" -f $Domain
    $body = "grant_type=client_Credentials&"
    $body = $body + "resource=$Resource&"
    $body = $body + "client_id=$ClientId&"
    $tmp_clientsecret = _unsecureString -string $ClientSecret
    
    # Need to escape the secret because it may contain special chars
    $tmp_ClientSecret = [uri]::EscapeDataString($tmp_ClientSecret)
    $body = $body + "client_secret=$tmp_ClientSecret"

    $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers 
    return $response.access_token
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER CspAppId

.PARAMETER CspDomain 

.PARAMETER CspClientSecret

.PARAMETER Credential

.EXAMPLE

.NOTES
#>
function Add-PCAuthentication {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $True, ParameterSetName = 'app')][Parameter(Mandatory = $True, ParameterSetName = 'user')][string] $CspAppId,
        [Parameter(Mandatory = $True, ParameterSetName = 'app')][Parameter(Mandatory = $True, ParameterSetName = 'user')][string] $CspDomain,
        [Parameter(Mandatory = $True, ParameterSetName = 'app' )][SecureString]$CspClientSecret,
        [Parameter(Mandatory = $True, ParameterSetName = 'user')][PSCredential]$Credential
    )

    function Private:Add-AuthenticationByUser ($CspAppId, $CspDomain, [PSCredential]$Credential) {
        $Resource = 'https://api.partnercenter.microsoft.com'
        $AadToken = Get-GraphAADTokenByUser -Resource $Resource -Domain $CspDomain -ClientId $CspAppId -Credential $Credential
        $CspUserName = $Credential.UserName
        
        # Get SA token
        try {
            $SaToken = Get-SAToken -aadtoken $AADToken -global $true
            $token = @{"Resource" = $Resource ; "Domain" = $CspDomain; "ClientId" = $CspAppId; "Username" = $CspUserName}
            return $token 
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }

    }

    function Private:Add-AuthenticationBySecret ($CspAppId, $CspDomain, $CspClientSecret) {
        $resource = 'https://graph.windows.net' 
        $AADToken = Get-GraphAADTokenByApp -resource $resource -domain $CspDomain -clientid $CspAppId -clientsecret $CspClientSecret

        # Get SA token
        try {
            $SAToken = Get-SAToken -aadtoken $AADToken -global $true
            $token = @{"Resource" = $resource ; "Domain" = $CspDomain; "ClientId" = $CspAppId}
            return $token 
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }

    }

    switch ($PsCmdlet.ParameterSetName) {
        "user" { $result = Add-AuthenticationByUser   -CspAppId $CspAppId -CspDomain $CspDomain -Credential $Credential }
        "app" { $result = Add-AuthenticationBySecret -CspAppId $CspAppId -CspDomain $CspDomain -CspClientSecret $CspClientSecret } 
    }
    
    return $result
}

<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER CspAppId 

.PARAMETER CspDomain

.PARAMETER CspClientSecret 

.PARAMETER Credential

.EXAMPLE

.NOTES
#>
function New-PCSAToken {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $True, ParameterSetName = 'app')][Parameter(Mandatory = $True, ParameterSetName = 'user')][string] $CspAppId,
        [Parameter(Mandatory = $True, ParameterSetName = 'app')][Parameter(Mandatory = $True, ParameterSetName = 'user')][string] $CspDomain,
        [Parameter(Mandatory = $True, ParameterSetName = 'app' )][SecureString]$CspClientSecret,
        [Parameter(Mandatory = $True, ParameterSetName = 'user')][PSCredential]$Credential
    )

    function Private:Add-AuthenticationByUser ($CspAppId, $CspDomain, [PSCredential]$Credential) {
        $resource = 'https://api.partnercenter.microsoft.com'
        $AADToken = Get-GraphAADTokenByUser -resource $resource -domain $CspDomain -clientid $CspAppId -Credential $Credential
        $CspUserName = $Credential.UserName
        # Get SA token
        try {
            $SAToken = Get-SAToken -aadtoken $AADToken -global $false
            $token = @{"Resource" = $resource ; "Domain" = $CspDomain; "ClientId" = $CspAppId; "Username" = $CspUserName}
            $objToReturn = @($SAToken, $token)
            return $objToReturn 
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }
    }

    function Private:Add-AuthenticationBySecret ($CspAppId, $CspDomain, $CspClientSecret) {
        $resource = 'https://graph.windows.net' 
        $AADToken = Get-GraphAADTokenByApp -resource $resource -domain $CspDomain -clientid $CspAppId -clientsecret $CspClientSecret

        # Get SA token
        try {
            $SAToken = Get-SAToken -aadtoken $AADToken -global $false
            $token = @{"Resource" = $resource ; "Domain" = $CspDomain; "ClientId" = $CspAppId}
            $objToReturn = @($SAToken, $token)
            return $objToReturn 
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            "Cannot retrieve the token: $ErrorMessage"
        }

    }

    switch ($PsCmdlet.ParameterSetName) {
        "user" {
            $result_arr = Add-AuthenticationByUser   -CspAppId $CspAppId -CspDomain $CspDomain -Credential $Credential 
            $result = $result_arr[0]
        }
        "app" {
            $result_arr = Add-AuthenticationBySecret -CspAppId $CspAppId -CspDomain $CspDomain -CspClientSecret $CspClientSecret
            $result = $result_arr[0]
        }
    }

    return $result
}