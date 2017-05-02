# Partner Center PowerShell Module #

## Set-PartnerCenterSR ##

**Get Service Request**

    $serviceRequest = Get-PartnerCenterSR -serviceRequestId '<service request id guid>'

**Set Service Requests status**

    $serviceRequest | Set-PartnerCenterSR -status '< open | closed >'
or
    Set-PartnerCenterSR -serviceRequest $serviceRequest -status '< open | closed >'

**Add note to Service Requests**

    Set-PartnerCenterSR -serviceRequest $serviceRequest -addnote '<note text>'