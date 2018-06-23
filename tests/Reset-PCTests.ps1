<#
.SYNOPSIS
Removes and readds the PartnerCenterModule for testing

.PARAMETER WebAppAuth 
Authenticates using the Web App authentication information provided.

.PARAMETER AppUserAuth 
Authenticates using App+User authentication information provided.

.PARAMETER Credentials 
This is a credential object created using Get-Credential.

.PARAMETER Path 
Specifies the path to the partnercenter module
.EXAMPLE
.\Reset-PCTest.ps1 -AppUserAuth -credentials $creds -CspDomain ContosoCsp.OnMicrosoft.com -CspAppId $CspApppId

Resets the test using AppUser Authentication.
.NOTES
You need to have a authentication credential already established before running this cmdlet.

#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory = $false)][switch]$WebAppAuth,
    [Parameter(Mandatory = $false)][switch]$AppUserAuth,
    [Parameter(Mandatory = $true)][PSCredential]$Credentials,
    [Parameter(Mandatory = $true)][string]$CspDomain,
    [Parameter(Mandatory = $false)][string]$CspClientSecret,
    [Parameter(Mandatory = $false)][string]$CspAppId,
    [Parameter(Mandatory = $false)][string]$CspWebAppId,
    [Parameter(Mandatory = $false)][string]$Path
)

if($Path -eq $null){
    $Path = (Get-Location).Path
}
# If the module is already imported, remove it.
$x = Get-Module -Name PartnerCenterModule
if ($x -ne $null) {
    Write-Output " Removing current PartnerCenterModule version."
    Remove-Module -Name PartnerCenterModule -Force  
}

# Import the latest version of the module
Write-Output " Adding in local Partner Center Module for testing"
Import-Module $Path`PartnerCenterModule\PartnerCenterModule.psd1 -Force

if ($WebAppAuth) {
    # App Auth
    Add-PCAuthentication -cspAppId $cspWebAppId -cspDomain $cspDomain -cspClientSecret $cspClientSecret -Verbose
}
elseif ($AppUserAuth) {
    # App+User Auth
    Add-PCAuthentication -cspAppId $cspAppId -cspDomain $cspDomain -credential $credentials -Verbose
}


