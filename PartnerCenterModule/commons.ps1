<#
    © 2018 Microsoft Corporation. All rights reserved. This sample code is not supported under any Microsoft standard support program or service. 
    This sample code is provided AS IS without warranty of any kind. Microsoft disclaims all implied warranties including, without limitation, 
    any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance 
    of the sample code and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, 
    production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business 
    profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the 
    sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
#>

# This variable is used in other cmdlets to identify the REST client.
$ApplicationName = "Partner Center PowerShell Module v0.10.0.3"

function _applyTypes {
   param($item,$type)
   $item.PSObject.TypeNames.Insert(0, $type)
}

function _formatResult {
    param ($obj, $type)
    try 
    {
        if($obj.items)
        {
            foreach($item in $obj.items){_applyTypes -item $item -type $type}
            return $obj.items
        }
    }
    catch
    {
        _applyTypes -item $obj -type $type        
        return $obj
    }
}

function _testTenantContext($TenantId)
{
    if ($TenantId.Length -lt 1)
    {
        throw ">>> Use Select-PCCustomer to select a specific tenant or use -TenantId parameter<<<"
    }
}

function _testTokenContext($SaToken)
{
    if ($SaToken.Length -lt 1)
    {
        throw ">>> Use Add-PCAuthentication to login to Partner Center or use -SaToken parameter<<<"
    }
}

function _unsecureString
{
    param ([SecureString]$string)
    $tmp_cred = New-Object System.Management.Automation.PSCredential -ArgumentList "tmp", $string
    return $tmp_cred.GetNetworkCredential().Password
}

function Get-SAToken
{
    [CmdletBinding()]
    param ($AadToken,[bool]$global)
    $url  = "https://api.partnercenter.microsoft.com/generatetoken"
	$body = "grant_type=jwt_token"
	$headers=@{Authorization="Bearer $AadToken"}
    
    $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Headers $headers -Body $body -method "POST" #-Debug -Verbose

    #setting SAToken variable as global
    if ($global){
        Set-Variable -Name "GlobalToken" -Value $response.access_token -Scope Global
    }

    return $response.access_token
}

