# Partner Center PowerShell Module (preview) #

## Get-PCInvoiceLineItems ##

**Get an invoice**

    $invoice = Get-PCInvoice -invoiceid '<invoice id>'

**Get an invoice line items**

    Get-PCInvoiceLineItems -invoiceid $invoice.id -billingprovider '<provider>' -invoicelineitemtype '<line item type>'

