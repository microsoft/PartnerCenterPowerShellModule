# Get-PCSR

Returns a list of service requests or a specified service request.

## SYNTAX

```powershell
Get-PCSR [-TenantId <String>] [-SaToken <String>] [<CommonParameters>]

Get-PCSR [-ServiceRequestId <String>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCSR cmdlet retrieves a list of service requests or a specified service request.

## PARAMETERS

### -TenantId &lt;String&gt;

Specifies the tenant used for scoping this cmdlet.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ServiceRequestId &lt;String&gt;

Specifies a service request id.

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

The -All parameter has been removed in this version.

## EXAMPLES

### EXAMPLE 1

Get all service requests.

```powershell
PS C:\>Get-PCSR
```

### EXAMPLE 2

Get a specific service request

```powershell
    Get-PCSR -ServiceRequestId '<service request id>'
```

### EXAMPLE 3

Get all customer service requests for the specified tenant id.

```powershell
    Get-PCSR -TenantId 'e974093c-2a52-4ebd-994e-b3e7e0f90cf2'
```
