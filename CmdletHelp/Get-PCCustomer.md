# Get-PCCustomer

Returns a list of customers or a specific customer.

## SYNTAX

```powershell
Get-PCCustomer [-TenantId <String>] [-SaToken <String>] [<CommonParameters>]

Get-PCCustomer -StartsWith <String> [-ResultSize <Int32>] [-SaToken <String>] [<CommonParameters>]
```

## DESCRIPTION

The Get-PCCustomer cmdlet retrieves a list of customers, or a specific customer based on the input.

## PARAMETERS

### -TenantId &lt;String&gt;

The tenant Id assigned to the customer you want to retrieve.

```
Required?                    false
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -StartsWith &lt;String&gt;

Specifies a filter for the customer names returned.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -ResultSize &lt;Int32&gt;

Specifies the maximum number of results to return. The default value is 200, the maximum allowed value is 500.

```
Required?                    false
Position?                    named
Default value                200
Accept pipeline input?       false
Accept wildcard characters?  false
```

### -SaToken &lt;String&gt;

Specifies an authentication token you have created with your Partner Center credentials.

```
Required?                    false
Position?                    named
Default value                $GlobalToken
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

You need to have a authentication credential already established before running this cmdlet.

## EXAMPLES

### EXAMPLE 1

Return a list of customers for a partner.

```powershell
PS C:\>Get-PCCustomer
```

### EXAMPLE 2

Return a customer by specifying an Id

```powershell
    $customer = Get-PCCustomer -TenantId '<tenant id GUID>'
```

### EXAMPLE 3

Return a customer by specifying part of the company name

```powershell
    Get-PCCustomer -StartsWith '<company name>'
```
