# Partner Center PowerShell Module #

## Get-PartnerCenterInvoiceLineItems ##

**Get an invoice**

    $invoice = Get-PartnerCenterInvoice -invoiceid '<invoice id>'

**Get an invoice line items**

    Get-PartnerCenterInvoiceLineItems -invoiceid $invoice.id -billingprovider '<provider>' -invoicelineitemtype '<line item type>'
