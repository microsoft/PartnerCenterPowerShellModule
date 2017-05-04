# Partner Center PowerShell Module (preview) #

## Set-PCSR ##

**Get Service Request**

    $serviceRequest = Get-PCSR -serviceRequestId '<service request id guid>'

**Set Service Requests status**

    $serviceRequest | Set-PCSR -status '< open | closed >'
or
    Set-PCSR -serviceRequest $serviceRequest -status '< open | closed >'

**Add note to Service Requests**

    Set-PCSR -serviceRequest $serviceRequest -addnote '<note text>'

