# Get-PCInvoiceLineItem #

This cmdlet requires App+User authentication.

## Get an invoice ##

```powershell
    $invoice = Get-PCInvoice -invoiceId '<invoice id>'
```

## Get an invoice line item ##

```powershell
    Get-PCInvoiceLineItem -invoiceId $invoice.id -billingProvider '<provider>' -invoicelineitemtype '<line item type>'
```
