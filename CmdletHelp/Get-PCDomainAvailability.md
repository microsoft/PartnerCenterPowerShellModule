# Partner Center PowerShell Module (preview) #

## Get-PCDomainAvailability ##

**Check if domain is available to use on new customer**

    $domainname = '<name>'
    $domain = $domainname+'.onmicrosoft.com'
    Get-PCDomainAvailability -domain $domain

