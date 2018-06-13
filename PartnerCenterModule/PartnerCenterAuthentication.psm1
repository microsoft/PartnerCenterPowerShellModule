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
The Get-GraphAaDTokenByUser cmdlet
.PARAMETER Resource 
Specifies

.PARAMETER Domain 
Specifies
.PARAMETER ClientId 
Specifies

.PARAMETER Credential
Specifies
.EXAMPLE
Returns

Get-GraphAadTokenByUser
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
TODO
.DESCRIPTION
The Get-GraphAadTokenByApp cmdlet
.PARAMETER Resource 
Specifies
.PARAMETER Domain 
Specifies
.PARAMETER ClientId 
Specifies
.PARAMETER ClientSecret
Specifies
.EXAMPLE
Get-GraphAADTokenByApp 
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
    $tmp_ClientSecret = _unsecureString -string $ClientSecret
    
    # Need to escape the secret because it may contain special chars
    $tmp_ClientSecret = [uri]::EscapeDataString($tmp_ClientSecret)
    $body = $body + "client_secret=$tmp_ClientSecret"

    $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers 
    return $response.access_token
}

<#
.SYNOPSIS
Authenticates the current session with the Partner Center API.

.DESCRIPTION
The Add-PCAuthentication cmdlet sets up authentication for the Partner Center API. Authenticate with either App authentication or App+User authentication to use other cmdlets in this module. 

.PARAMETER CspAppId
Specifies a application Id generated for the Partner Center account. The application id must match the authentication type chosen. 

.PARAMETER CspDomain
Specifies the Partner Center tenant (onmicrosoft.com) domain.

.PARAMETER CspClientSecret
Specifies an application secret key generated from the Partner Center portal.

.PARAMETER Credential
Specifies the user account credentials to use to perform this task. To specify this parameter, you can type a user name, such as User1 or Domain01\User01 or you can specify a PSCredential object. If you specify a user name for this parameter, the cmdlet prompts for a password.
You can also create a PSCredential object by using a script or by using the Get-Credential cmdlet. You can then set the Credential parameter to the PSCredential object.

.EXAMPLE
$cred = Get-Credential
Add-PCAuthentication -CspAppId '<native app id Guid>' -CspDomain '<csp partner domain>' -Credential $cred

Set a global token for the script session - App+User authentication

.EXAMPLE
$clientSecret = '<key code secret>'
$clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force
Add-PCAuthentication -CspAppId '<web app id Guid>' -CspDomain '<csp partner domain>' -CspClientSecret $clientSecretSecure

Set a global token for the script session - App authentication
.NOTES
Some cmdlets require App+User authentication. If you are working with invoices or users, you should use App+User authentication.

$clientSecret = '<key code secret>'
$clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force
$cred = Get-Credential

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
            $SaToken = Get-SAToken -AadToken $AADToken -global $true
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
        $AADToken = Get-GraphAADTokenByApp -Resource $resource -Domain $CspDomain -ClientId $CspAppId -ClientSecret $CspClientSecret

        # Get SA token
        try {
            $SaToken = Get-SAToken -AadToken $AADToken -Global $true
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
Creates an access token for the Partner Center API.

.DESCRIPTION
The New-PCSaToken cmdlet returns a token used the access Partner Center resources.

.PARAMETER CspAppId
Specifies a application Id generated for the Partner Center account. The application id must match the authentication type chosen. 

.PARAMETER CspDomain 
Specifies the Partner Center tenant (onmicrosoft.com) domain.

.PARAMETER CspClientSecret
Specifies an application secret key generated from the Partner Center portal.

.PARAMETER Credential
Specifies the user account credentials to use to perform this task. To specify this parameter, you can type a user name, such as User1 or Domain01\User01 or you can specify a PSCredential object. If you specify a user name for this parameter, the cmdlet prompts for a password.
You can also create a PSCredential object by using a script or by using the Get-Credential cmdlet. You can then set the Credential parameter to the PSCredential object.

.EXAMPLE
Creates a new token using the specified information.
$sat = New-PCSaToken -CspAppId 97037612-799c-4fa6-8c40-68be72c6b83c -CspDomain contoso.onmicrosoft.com -CspClientSecret $ClientSecretSecure -Credential $cred

.EXAMPLE
Set a specific token for a command/function - user authentication ##
$cred = Get-Credential
New-PCSaToken -CspAppId '<native app id GUID>' -CspDomain '<csp partner domain>' -Credential $cred

.EXAMPLE
Set a specific token for a command/function - app authentication ##

$clientSecret = '<key code secret>'
$clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force
New-PCSaToken -CspAppId '<native app id GUID>' -CspDomain '<csp partner domain>' -CspClientSecret $clientSecretSecure

.NOTES
$cred = Get-Credential
clientSecret = 'NQSm6Wjsd7PcDeP5JD6arEWMF3UghEpWmphGrshxzsQ='
$ClientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force

#>
function New-PCSaToken {
    [CmdletBinding()]
    param ([Parameter(Mandatory = $True, ParameterSetName = 'app')][Parameter(Mandatory = $True, ParameterSetName = 'user')][string] $CspAppId,
        [Parameter(Mandatory = $True, ParameterSetName = 'app')][Parameter(Mandatory = $True, ParameterSetName = 'user')][string] $CspDomain,
        [Parameter(Mandatory = $True, ParameterSetName = 'app' )][SecureString]$CspClientSecret,
        [Parameter(Mandatory = $True, ParameterSetName = 'user')][PSCredential]$Credential
    )

    function Private:Add-AuthenticationByUser ($CspAppId, $CspDomain, [PSCredential]$Credential) {
        $resource = 'https://api.partnercenter.microsoft.com'
        $AADToken = Get-GraphAADTokenByUser -Resource $resource -Domain $CspDomain -ClientId $CspAppId -Credential $Credential
        $CspUserName = $Credential.UserName
        # Get SA token
        try {
            $SAToken = Get-SAToken -AadToken $AADToken -Global $false
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
        $AADToken = Get-GraphAADTokenByApp -Resource $resource -Domain $CspDomain -ClientId $CspAppId -ClientSecret $CspClientSecret

        # Get SA token
        try {
            $SAToken = Get-SAToken -AadToken $AADToken -Global $false
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