<#
.SYNOPSIS
Removes and readds the PartnerCenterModule for testing

.PARAMETER webAppAuth 
Authenticates using the Web App authentication information provided.

.PARAMETER appUserAuth 
Authenticates using App+User authentication information provided.

.PARAMETER credentials 
This is a credential object created using Get-Credential.

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
    [Parameter(Mandatory = $false)][string]$CspWebAppId
)

# If the module is already imported, remove it.
$x = Get-Module -Name PartnerCenterModule
if ($x -ne $null) {
    Remove-Module -Name PartnerCenterModule -Force  
}

# Import the latest version of the module
Import-Module ..\PartnerCenterModule\PartnerCenterModule.psd1 -Force

if ($WebAppAuth) {
    # App Auth
    Add-PCAuthentication -cspAppID $cspWebappId -cspDomain $cspDomain -cspClientSecret $cspClientSecret -Verbose
}
elseif ($AppUserAuth) {

    # App+User Auth
    Add-PCAuthentication -cspAppID $cspAppId -cspDomain $cspDomain -credential $credentials -Verbose
}


