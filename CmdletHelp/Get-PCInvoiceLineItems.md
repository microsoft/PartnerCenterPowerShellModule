# Get-PCInvoiceLineItems #

This cmdlet requires App+User authentication.

## Deprecated: Use Get-PCInvoiceLineItem instead ##

## Get an invoice ##

```powershell
    $invoice = Get-PCInvoice -invoiceId '<invoice id>'
```

## Get an invoice line item ##

```powershell
    Get-PCInvoiceLineItems -invoiceId $invoice.id -billingProvider '<provider>' -invoicelineitemtype '<line item type>'
```
