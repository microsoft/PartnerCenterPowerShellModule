# Get-PCInvoiceLineItem

TODO

## SYNTAX

```powershell
Get-PCInvoiceLineItem [-InvoiceId] <String> [-BillingProvider] <String> [-InvoiceLineItemType] <String> [[-ResultSize] <Int32>] [[-Offset] <Int32>] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCInvoiceLineItem cmdlet.

## PARAMETERS

### -InvoiceId &lt;String&gt;

Specifies the invoice id to retrieve.

```
Required?                    true
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -BillingProvider &lt;String&gt;

Specifies either Azure or Office.

```
Required?                    true
Position?                    2
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -InvoiceLineItemType &lt;String&gt;

Specifies either BillingLineItems for invoiced licence-based services or UsageLineItems for invoiced usage-based services.

```
Required?                    true
Position?                    3
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -ResultSize &lt;Int32&gt;

Specifies the maximum number of results to return. The default value is 200.

```
Required?                    false
Position?                    4
Default value                200
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Offset &lt;Int32&gt;

Specifies an offset

```
Required?                    false
Position?                    5
Default value                0
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    6
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

## EXAMPLES

### EXAMPLE 1

Retrieve a list of Azure usage from invoice D030001IZ6.

```powershell
PS C:\>Get-PCInvoiceLineItem -InvoceId D030001IZ6 -BillingProvider Azure -InvoiceLineItemType UsageLineItems
```
