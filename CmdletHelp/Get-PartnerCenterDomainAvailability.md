# Partner Center PowerShell Module (preview) #

## Get-PartnerCenterDomainAvailability ##

**Check if domain is available to use on new customer**

    $domainname = '<name>'
    $domain = $domainname+'.onmicrosoft.com'
    Get-PartnerCenterDomainAvailability -domain $domain
