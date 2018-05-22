# Set-PCSR #

## Get Service Request ##

```powershell
    $serviceRequest = Get-PCSR -serviceRequestId '<service request id guid>'
```

## Set Service Requests status ##

```powershell
    $serviceRequest | Set-PCSR -status '< open | closed >'
```

or

```powershell
    Set-PCSR -serviceRequest $serviceRequest -status '< open | closed >'
```

## Add note to Service Requests ##

```powershell
    Set-PCSR -serviceRequest $serviceRequest -addnote '<note text>'
```
