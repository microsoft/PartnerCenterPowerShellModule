# Get-PCAuditRecord #

## Get audit logs starting from a specific date ##

```powershell
    Get-PCAuditRecord -startDate '2017-04-12'
```

## Get audit logs between two dates ##

```powershell
    Gett-PCAuditRecord -startDate '2017-04-12' -endDate '2017-04-13'
```

## Get audit logs of a specific operationType between two dates ##

```powershell
    Get-PCAuditRecord -startDate '2017-04-12' -endDate '2017-04-13' | ? operationType -EQ 'delete_customer_user'
```
