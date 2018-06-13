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
Returns either a list of service requests or a specific service request.
.DESCRIPTION
The Get-PCSR cmdlet retrieves either a specific service request or a list of service requests for the tenant or the partner.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER TenantId 
Specifies the tenant id used for scoping this cmdlet.
.PARAMETER ServiceRequestId 
Specifies the service request id to return.
.EXAMPLE
Get-PCSR
Get all service requests.

.EXAMPLE
Get-PCSR -ServiceRequestId '335c4cad-b235-4a31-8273-e73da43e7817'
Get the specified service request.

.EXAMPLE
Get-PCSR -TenantId '3c762ceb-b839-4b4a-85d8-0e7304c89f62'
Get all customer service requests for the specified tenant id.

.NOTES
The -All parameter has been removed in this version.
#>
function Get-PCSR {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $false)][String]$TenantId,
        [Parameter(Mandatory = $false)][String]$ServiceRequestId,
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    if ($TenantId) {
        if ($ServiceRequestId) {

            $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $ServiceRequestId
        }
        
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/servicerequests" -f $TenantId
    }
    else {
        if ($ServiceRequestId) {

            $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $ServiceRequestId
        }
        else {
            
            $url = "https://api.partnercenter.microsoft.com/v1/servicerequests"
        }

    }
    
    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")
}

<#
.SYNOPSIS
Returns a list of service request topics.
.DESCRIPTION
The Get-PCSRTopic cmdlet retrieves a list of service request topics.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.EXAMPLE
Get-PCSRTopic
.NOTES
#>
function Get-PCSRTopic {
    [CmdletBinding()]
    param([Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken)
    _testTokenContext($SaToken)

    $obj = @()
    
    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/supporttopics"
    
    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequestTopics")   
}

<#
.SYNOPSIS
Creates a new service request.
.DESCRIPTION
The New-PCSR cmdlet creates a new service request.
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER ServiceRequest 
Specifies the service request object variable created that defines the service request to open.
.PARAMETER Title 
Specifies the title of the service request.
.PARAMETER Description 
Specifies details of the the service request.

.PARAMETER Severity 
Specifies the severity of request. Valid entries are: minimal, moderate, or critical.
.PARAMETER SupportTopicId 
Specifies the Id of the support topic that should be associated with the new service request.
.PARAMETER ServiceRequestContact 
Specifies an object that defines the contact for the new service request.
.PARAMETER ServiceRequestNote 
Specifies a note to add to the new service request.
.PARAMETER AgentLocale 
Specifies the two letter ISO code for the language and country. For example United States English would be en-us.
.EXAMPLE
Create a new service request

Get support topic for the request

    $supportTopic = Get-PCSRTopics | Where-Object name -Contains '<support topic name>'
    New-PCSR -title '<service request title>' -description '<service request description>' -severity '<Minimal | Moderate | Critical>' -supportTopicID '<support topic id guid>'

.EXAMPLE
Create a new service request by specifying the information manually.

    $serviceRequestContact = [ServiceRequestContact]::new()
    $serviceRequestContact.FirstName = '<first name>'
    $serviceRequestContact.LastName = '<last name>'
    $serviceRequestContact.Email = '<Email>'
    $serviceRequestContact.PhoneNumber = '<phone number>'

    $supportTopic = Get-PCSRTopics | Where-Object name -Contains '<support topic name>'

    $serviceRequestNote = [ServiceRequestNote]::new()
    $serviceRequestNote.Text = '<problem detailed description>'

    $serviceRequest = [ServiceRequest]::new()
    $serviceRequest.Title = '<title>'
    $serviceRequest.SYNOPSIS \n \n .DESCRIPTION = '<description>'
    $serviceRequest.Severity = '<Minimal | Moderate | Critical>'
    $serviceRequest.supportTopicID = $supportTopic.id
    $serviceRequest.PrimaryContact = $serviceRequestContact
    $serviceRequest.NewNote = $serviceRequestNote

    New-PCSR -serviceRequest $serviceRequest
.NOTES
#>
function New-PCSR {
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = 'byObject', Mandatory = $true)][ServiceRequest]$ServiceRequest, 
        [Parameter(ParameterSetName = 'byParam', Mandatory = $true)][string]$Title, 
        [Parameter(ParameterSetName = 'byParam', Mandatory = $true)][string]$Description,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $true)][ValidateSet("Minimal", "Moderate", "Critical")][string]$Severity,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $true)][string]$SupportTopicID,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $false)][ServiceRequestContact]$ServiceRequestContact,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $false)][ServiceRequestNote]$ServiceRequestNote,
        [Parameter(Mandatory = $false)][ValidatePattern("^(bg-bg|pt-br|zh-cn|cs-cz|de-de|da-dk|et-ee|ca-es|es-es|eu-es|gl-es|fi-fi|fr-fr|el-gr|hr-hr|hu-hu|id-id|he-il|hi-in|it-it|ja-jp|ko-kr|kk-kz|lt-lt|lv-lv|ms-my|nl-nl|nb-no|pl-pl|pt-pt|ro-ro|sr-cyrl-rs|sr-latn-rs|ru-ru|sv-se|zh-sg|sl-si|sk-sk|th-th|tr-tr|zh-tw|uk-ua|en-us|vi-vn|)$")][string]$AgentLocale = "en-US",
        [Parameter(Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)

    $obj = @()
    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $AgentLocale

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $newSR = [ServiceRequest]::new()
    if ($serviceRequest) { $newSR = $serviceRequest }
    else {
        $newSR = [ServiceRequest]::new($Title, $Description, $Severity, $SupportTopicID)
        if ($ServiceRequestContact) { $newSR.primaryContact = $ServiceRequestContact }
        if ($ServiceRequestNote) { $newSR.newNote = $ServiceRequestNote }
    }

    $body = $newSR | ConvertTo-Json -Depth 100
    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "POST" # -Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")  
}

<#
.SYNOPSIS
Updates a service request.
.DESCRIPTION
The Set-PCSR cmdlet updates a service request.. 
.PARAMETER SaToken 
Specifies an authentication token with your Partner Center credentials.
.PARAMETER ServiceRequest 
Specifies the updated service request object used to update the service request.
.PARAMETER Status 
Specifies whether the service request is open or closed. Valid values are: open and closed.
.PARAMETER Description 
Specifies the updated service request description.
.PARAMETER Title 
Specifies the updated service request title.
.PARAMETER AddNote 
Specifies a note to add to the service request.
.EXAMPLE
$sr = Get-PCServiceRequest -TenantId 'e974093c-2a52-4ebd-994e-b3e7e0f90cf2' | Where-Object {$_.Status -eq 'open'}
Set-PCSR -ServiceRequest $sr -Status 'closed'
Set all open service request for the specified tenant to closed.
.EXAMPLE
$sr = Get-PCServiceRequest -ServiceRequestId '615112491169010'
Set-PCSR -ServiceRequest $sr -AddNote 'After further testing, the problem is still occurring.'
Add a note to an existing service request.
.NOTES
#>
function Set-PCSR {
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = 'byParam', Mandatory = $true, ValueFromPipeline = $True, ValueFromPipelineByPropertyName = $True)][PSCustomObject]$ServiceRequest,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $false)][ValidateSet("open", "closed")][string]$Status,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $false)][string]$Title,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $false)][string]$Description,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $false)][string]$AddNote,
        [Parameter(ParameterSetName = 'byParam', Mandatory = $false)][string]$SaToken = $GlobalToken
    )
    _testTokenContext($SaToken)  

    $obj = @()

    if ($ServiceRequest) {$body = $ServiceRequest | ConvertTo-Json -Depth 100}
    else {
        $actualSR = Get-PCSR -serviceRequestId $serviceRequest.id -SaToken $SaToken
        if ($Status) {
            $actualSR.status = $Status
            $body = $actualSR | ConvertTo-Json -Depth 100
        }
        if ($AddNote) {
            $newSR = [ServiceRequest]::new($actualSR.title, $actualSR.description, $actualSR.severity, $actualSR.supportTopicID)
            $newSR.newNote = $AddNote
            $body = $newSR | ConvertTo-Json -Depth 100
        }
    }

    $url = "https://api.partnercenter.microsoft.com/v1/servicerequests/{0}" -f $ServiceRequest.id

    $headers = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]'
    $headers.Add("Authorization", "Bearer $SaToken")
    $headers.Add("MS-PartnerCenter-Application", $ApplicationName)

    $utf8body = [System.Text.Encoding]::UTF8.GetBytes($body)

    $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Body $utf8body -Method "PATCH" #-Debug -Verbose
    $obj += $response.Substring(1) | ConvertFrom-Json
    return (_formatResult -obj $obj -type "ServiceRequest")
}
