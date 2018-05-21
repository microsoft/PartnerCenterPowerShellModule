# Partner Center PowerShell Module (preview) #

## Get-PCInvoiceLineItems ##

Deprecated: Please use Get-PCInvoiceLineItem instead.

**Get an invoice**

```powershell
    $invoice = Get-PCInvoice -invoiceid '<invoice id>'
```

**Get an invoice line items**

```powershell
    Get-PCInvoiceLineItems -invoiceid $invoice.id -billingprovider '<provider>' -invoicelineitemtype '<line item type>'
```
