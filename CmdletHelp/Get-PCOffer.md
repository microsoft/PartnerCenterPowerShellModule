# Partner Center PowerShell Module (preview) #

## Get-PCOffer ##

**Get all Offers details for countryid**

    Get-PCOffer -countryid '<country two digits id>' 

**Get a specific Offer**

    Get-PCOffer -countryid '<country two digits id>' -offerid '<offer id GUID>'

**Get all Offers details for countryid and localeid**

    Get-PCOffer -countryid '<country two digits id>' -localeid '<locale id four digits>'

**Get addons for a specific Offer**

    Get-PCOffer -countryid '<country two digits id>' -offerid '<offer id GUID>' -addons


