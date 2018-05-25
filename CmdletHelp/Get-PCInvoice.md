# Get-PCInvoice #

This cmdlet requires App+User authentication.

## Get current payable amount ##

```powershell
    Get-PCInvoice -summary
```

## Get all invoices ##

```powershell
    Get-PCInvoice -all
```

## Get an invoice ##

```powershell
    $invoice = Get-PCInvoice -invoiceId '<invoice id>'
```
