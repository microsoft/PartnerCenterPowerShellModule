# Get-PCAuditRecord

Returns audit records for the specified date range.

## SYNTAX

```powershell
Get-PCAuditRecord [-StartDate] <String> [[-EndDate] <String>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCAuditRecord cmdlet.

## PARAMETERS

### -StartDate &lt;String&gt;

The date from which you will start retrieving data. Must be formated yyyy-mm-dd.

```
Required?                    true
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -EndDate &lt;String&gt;

The date from which you will stop retrieving data. Must be formated yyyy-mm-dd.

```
Required?                    false
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    3
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

#### Get audit logs starting from a specific date

```powershell
    Get-PCAuditRecord -StartDate '2017-04-12'
```

#### Get audit logs between two dates

```powershell
    Get-PCAuditRecord -StartDate '2017-04-12' -EndDate '2017-04-13'
```

#### Get audit logs of a specific operationType between two dates

```powershell
    Get-PCAuditRecord -StartDate '2017-04-12' -EndDate '2017-04-13' | ? operationType -EQ 'delete_customer_user'
```
