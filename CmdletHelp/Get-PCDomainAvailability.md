# Get-PCDomainAvailability #

## Check if domain is available to use on new customer ##

```powershell
    $domainname = '<name>'
    $domain = $domainname+'.onmicrosoft.com'
    Get-PCDomainAvailability -domain $domain
```
