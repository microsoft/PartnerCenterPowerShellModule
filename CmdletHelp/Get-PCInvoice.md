# Get-PCInvoice

TODO

## SYNTAX

```powershell
Get-PCInvoice [[-InvoiceId] <String>] [-Summary] [[-SaToken] <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCInvoice cmdlet retrieves either a specific invoice or a list of invoices. This cmdlet requires App+User authentication.

## PARAMETERS

### -InvoiceId &lt;String&gt;

Specifies an invoice id to return.

```
Required?                    false
Position?                    1
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -Summary &lt;SwitchParameter&gt;

Specifies whether to retrieve a summary of the invoice.

```
Required?                    false
Position?                    named
Default value                False
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token with your Partner Center credentials.

```
Required?                    false
Position?                    2
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

This cmdlet requires App+User authentication.

## EXAMPLES

### EXAMPLE 1

Return all invoices.

```powershell
PS C:\>Get-PCInvoice
```

### EXAMPLE 2

Return the specified invoice

```powershell
PS C:\>$invoice = Get-PCInvoice -InvoiceId D030001IZ6
```

### EXAMPLE 3

Return a summary of the specified invoice

```powershell
PS C:\>$invoice = Get-PCInvoice -InvoiceId D030001IZ6 -Summary
```
