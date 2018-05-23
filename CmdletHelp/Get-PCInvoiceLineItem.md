# Get-PCInvoiceLineItem #

## Get an invoice ##

```powershell
    $invoice = Get-PCInvoice -invoiceid '<invoice id>'
```

## Get an invoice line item ##

```powershell
    Get-PCInvoiceLineItem -invoiceid $invoice.id -billingprovider '<provider>' -invoicelineitemtype '<line item type>'
```
