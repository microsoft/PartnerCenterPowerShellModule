# Partner Center PowerShell Module #

## Get-PartnerCenterAuditRecords ##

**Get audit logs starting from a specific date**

    Get-PartnerCenterAuditRecords -startDate '2017-04-12'

**Get audit logs between two dates**

    Gett-PartnerCenterAuditRecords -startDate '2017-04-12' -endDate '2017-04-13'

**Get audit logs of a specific operationType between two dates**

    Get-PartnerCenterAuditRecords -startDate '2017-04-12' -endDate '2017-04-13' | ? operationType -EQ 'delete_customer_user'
