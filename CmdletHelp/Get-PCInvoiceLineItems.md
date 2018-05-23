# Get-PCInvoiceLineItems #

## Deprecated: Use Get-PCInvoiceLineItem instead ##

## Get an invoice ##

```powershell
    $invoice = Get-PCInvoice -invoiceid '<invoice id>'
```

## Get an invoice line item ##

```powershell
    Get-PCInvoiceLineItems -invoiceid $invoice.id -billingprovider '<provider>' -invoicelineitemtype '<line item type>'
```
