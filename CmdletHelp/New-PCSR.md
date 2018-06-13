# New-PCSR

Creates a new service request.

## SYNTAX

```powershell
New-PCSR -ServiceRequest <ServiceRequest> [-AgentLocale <String>] [-SaToken <String>] [<CommonParameters>]



New-PCSR -Title <String> -Description <String> -Severity <String> -SupportTopicID <String> [-ServiceRequestContact <ServiceRequestContact>] [-ServiceRequestNote <ServiceRequestNote>] [-AgentLocale <String>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The New-PCSR cmdlet creates a new service request.

## PARAMETERS

### -ServiceRequest &lt;ServiceRequest&gt;

Specifies the service request object variable created that defines the service request to open.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Title &lt;String&gt;

Specifies the title of the service request.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Description &lt;String&gt;

Specifies details of the the service request.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Severity &lt;String&gt;

Specifies the severity of request. Valid entries are: minimal, moderate, or critical.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -SupportTopicID &lt;String&gt;

Specifies the Id of the support topic that should be associated with the new service request.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -ServiceRequestContact &lt;ServiceRequestContact&gt;

Specifies an object that defines the contact for the new service request.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -ServiceRequestNote &lt;ServiceRequestNote&gt;

Specifies a note to add to the new service request.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -AgentLocale &lt;String&gt;

Specifies the two letter ISO code for the language and country. For example United States English would be en-us.

```
Required?                    false
Position?                    named
Default value                en-US
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    named
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Create a new service request.

Get support topic for the request

```powershell
    $supportTopic = Get-PCSRTopics | Where-Object name -Contains '<support topic name>'
```

Complete request creation

```powershell
    New-PCSR -title '<service request title>' -description '<service request description>' -severity '<Minimal | Moderate | Critical>' -supportTopicID '<support topic id guid>'
```

### EXAMPLE 2

Create a new service request by specifying the information manually.

```powershell
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
```
