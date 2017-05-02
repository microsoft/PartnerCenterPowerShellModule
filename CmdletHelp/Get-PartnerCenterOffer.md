# Partner Center PowerShell Module #

## Get-PartnerCenterOffer ##

**Get all Offers details for countryid**

    Get-PartnerCenterOffer -countryid '<country two digits id>' 

**Get a specific Offer**

    Get-PartnerCenterOffer -countryid '<country two digits id>' -offerid '<offer id GUID>'

**Get all Offers details for countryid and localeid**

    Get-PartnerCenterOffer -countryid '<country two digits id>' -localeid '<locale id four digits>'

**Get addons for a specific Offer**

    Get-PartnerCenterOffer -countryid '<country two digits id>' -offerid '<offer id GUID>' -addons

