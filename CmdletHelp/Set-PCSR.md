# Set-PCSR

Updates a service request.

## SYNTAX

```powershell
Set-PCSR -ServiceRequest <PSObject> [-Status <String>] [-Title <String>] [-Description <String>] [-AddNote <String>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Set-PCSR cmdlet updates a service request..

## PARAMETERS

### -ServiceRequest &lt;PSObject&gt;

Specifies the updated service request object used to update the service request.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       true (ByValue, ByPropertyName)
Accept wildcard characters?  false
```

### -Status &lt;String&gt;

Specifies whether the service request is open or closed. Valid values are: open and closed.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Title &lt;String&gt;

Specifies the updated service request title.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Description &lt;String&gt;

Specifies the updated service request description.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -AddNote &lt;String&gt;

Specifies a note to add to the service request.

```
Required?                    false
Position?                    named
Default value
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

Set all open service request for the specified tenant to closed.

```powershell
PS C:\>$sr = Get-PCServiceRequest -TenantId 'e974093c-2a52-4ebd-994e-b3e7e0f90cf2' | Where-Object {$_.Status -eq 'open'}
PS C:\>Set-PCSR -ServiceRequest $sr -Status 'closed'
```

### EXAMPLE 2

Add a note to an existing service request.

```powershell
PS C:\>$sr = Get-PCServiceRequest -ServiceRequestId '615112491169010'
PS C:\>Set-PCSR -ServiceRequest $sr -AddNote 'After further testing, the problem is still occurring.'
```
