Set-StrictMode -Version latest
<#
    © 2018 Microsoft Corporation. All rights reserved. This sample code is not supported under any Microsoft standard support program or service. 
    This sample code is provided AS IS without warranty of any kind. Microsoft disclaims all implied warranties including, without limitation, 
    any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance 
    of the sample code and documentation remains with you. In no event shall Microsoft, its authors, or anyone else involved in the creation, 
    production, or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business 
    profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the 
    sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
#>
. $PSScriptRoot\commons.ps1

Import-Module "$($PSScriptRoot)\PartnerCenterAnalytics.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterAuthentication.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterCustomer.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterDirectory.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterInvoice.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterOffer.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterOrder.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterProfiles.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterServiceRequest.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterSubscription.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterUsage.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterPartner.psm1"
Import-Module "$($PSScriptRoot)\PartnerCenterUser.psm1"

class Attributes
{
    [string] $ObjectType
    
    Attributes ([string] $ObjectType)
    {
        $this.ObjectType = $ObjectType
    }
}

class CompanyProfile
{
    [string] $TenantId
    [string] $Domain
    [string] $CompanyName
    [Attributes] $Attributes

    CompanyProfile ([string] $Domain)
    {       
        $att_tmp = [Attributes]::new('CompanyProfile')
        $this.Domain = $Domain
        $this.Attributes = $att_tmp
    }
}

class DefaultAddress
{
    [string] $Country
    [string] $region
    [string] $City
    [string] $State
    [string] $AddressLine1
    [string] $AddressLine2
    [string] $PostalCode
    [string] $FirstName
    [string] $LastName
    [string] $PhoneNumber

    #main constructor
    DefaultAddress ([string] $Country, [string] $region, [string] $City, [string] $State, [string] $AddressLine1, `
                [string] $PostalCode, [string] $FirstName, [string] $LastName, [string] $PhoneNumber)
    {
        $this.Country = $Country
        $this.City = $City
        $this.State = $State
        $this.AddressLine1 = $AddressLine1
        $this.PostalCode = $PostalCode
        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.PhoneNumber = $PhoneNumber

        if(-not [string]::IsNullOrEmpty($region)) {
            $this.Region = $region            
        }
    }

    DefaultAddress ([string] $Country, [string] $region, [string] $City, [string] $State, [string] $AddressLine1, `
                [string] $PostalCode)
    {
        $this.Country = $Country
        $this.City = $City
        $this.State = $State
        $this.AddressLine1 = $AddressLine1
        $this.PostalCode = $PostalCode

        if(-not [string]::IsNullOrEmpty($region)) {
            $this.Region = $region            
        }
    }
}

class BillingProfile
{
    #read only
    [string] $Id

    [string] $FirstName
    [string] $LastName
    [string] $Email
    [string] $Culture
    [string] $Language
    [string] $CompanyName
    [DefaultAddress] $DefaultAddress
    [Attributes] $Attributes

    #main constructors
    BillingProfile ([string] $Email,[string] $Culture,[string] $Language,[string] $CompanyName, [string] $Country, [string] $region, [string] $City, [string] $State, [string] $AddressLine1,[string] $PostalCode, [string] $FirstName, [string] $LastName, [string] $PhoneNumber)
    {
        $defaultAddressTmp = [DefaultAddress]::new($Country, $region, $City,$State,$AddressLine1,$PostalCode,$FirstName,$LastName,$PhoneNumber)
        $att_tmp = [Attributes]::new('BillingProfile')

        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.DefaultAddress = $defaultAddressTmp
        $this.Email = $Email
        $this.Culture = $Culture
        $this.Language = $Language
        $this.CompanyName = $CompanyName
        $this.Attributes = $att_tmp
    }

    BillingProfile ([string]$FirstName, [string]$LastName, [string] $Email,[string]$Culture,[string]$Language,[string]$CompanyName,[DefaultAddress] $DefaultAddress)
    {
        $att_tmp = [Attributes]::new('BillingProfile')

        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.Email = $Email
        $this.Culture = $Culture
        $this.Language = $Language
        $this.CompanyName = $CompanyName
        $this.DefaultAddress = $DefaultAddress
        $this.Attributes = $att_tmp
    }

}

class Customer
{
    #read only
    [string] $Id
    [string] $CommerceId
    [string] $RelationshipToPartner = 'unknown'
    [string] $UserCredentials

    #mandatoryFields
    [BillingProfile]$BillingProfile
    [CompanyProfile]$CompanyProfile
    
    #optionalFields
    [string] $AllowDelegatedAccess
    [Attributes] $Attributes

    #main constructors
    Customer ([string] $Email,[string] $Culture,[string] $Language,[string] $CompanyName, `
                [string] $Country, [string] $region, [string] $City, [string] $State, [string] $AddressLine1, `
                [string] $PostalCode, [string] $FirstName, [string] $LastName, [string] $PhoneNumber, `
                [string] $Domain)
    {
        $defaultAddress_tmp = [DefaultAddress]::new($Country,$region,$City,$State,$AddressLine1, `
                                                        $PostalCode,$FirstName,$LastName,$PhoneNumber)

        $billingProfile_tmp = [BillingProfile]::new($FirstName, $LastName, $Email,$Culture,$Language,$CompanyName,$defaultAddress_tmp)

        $companyProfile_tmp = [CompanyProfile]::new($Domain)
        $att_tmp = [Attributes]::new('Customer')

        $this.CompanyProfile = $companyProfile_tmp 
        $this.BillingProfile = $billingProfile_tmp
        $this.Attributes = $att_tmp
    }

    Customer ([BillingProfile]$BillingProfile,[CompanyProfile]$CompanyProfile)
    {
        $att_tmp = [Attributes]::new('Customer')

        $this.CompanyProfile = $CompanyProfile 
        $this.BillingProfile = $BillingProfile
        $this.Attributes = $att_tmp 
    }
}

class CustomerUserPasswordProfile
{
    [string] $password
    [bool] $forceChangePassword
    CustomerUserPasswordProfile ([SecureString] $password,[bool]$forceChangePassword)
    {
        $this.password = _unsecureString String -string $password
        $this.forceChangePassword = $forceChangePassword
    }
}


class CustomerUser
{
    [string] $Id
    [string] $usageLocation
    [string] $userPrincipalName
    [string] $FirstName
    [string] $LastName
    [string] $displayName
    [CustomerUserPasswordProfile] $passwordProfile
    [Attributes] $Attributes

    CustomerUser ([string]$usageLocation ,[string] $userPrincipalName,[string] $FirstName,[string] $LastName,[string] $displayName,[SecureString] $password,[bool] $forceChangePassword)
    {
        $passwordProfile_tmp = [CustomerUserPasswordProfile]::new($password,$forceChangePassword)
        $att_tmp = [Attributes]::new('CustomerUser')
        $this.usageLocation = $usageLocation
        $this.userPrincipalName = $userPrincipalName
        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.displayName = $displayName
        $this.passwordProfile = $passwordProfile_tmp
        $this.Attributes = $att_tmp
    }

    <#
    CustomerUser([string]$usageLocation ,[string] $userPrincipalName,[string] $FirstName,[string] $LastName,[string] $displayName,[CustomerUserPasswordProfile]$CustomerUserPasswordProfile)
    {
        $att_tmp = [Attributes]::new('CustomerUser')
        $this.usageLocation = $usageLocation
        $this.userPrincipalName = $userPrincipalName
        $this.FirstName = $FirstName
        $this.LastName = $LastName
        $this.displayName = $displayName
        $this.passwordProfile = $CustomerUserPasswordProfile
        $this.Attributes = $att_tmp
    }
    #>
}

class DirectoryRoleMember
{
    [string] $id
}

class Order
{
    #ReadOnly Fields
    [string] $Id

    #Mandatory Fields
    [string] $ReferenceCustomerId
    [Array] $LineItems

    #Optional fields
    #[string] $Status = 'none'
    [string] $CreationDate
    [string] $BillingCycleType
    [Attributes] $Attributes

    Order ([string] $ReferenceCustomerId,[Array] $LineItems)
    {
        $this.ReferenceCustomerId = $ReferenceCustomerId
        $this.LineItems = $LineItems

        $att_tmp = [Attributes]::new('Order')
        $this.Attributes = $att_tmp
    }
}

class OrderLineItem
{
    #Mandatory Fields
    [uint16] $LineItemNumber
    [string] $OfferId
    [uint16] $Quantity

    #Optional Fields
    [string] $ReferencedEntitlementUris
    [string] $FriendlyName
    [string] $PartnerIdOnRecord
    [string] $ParentSubscriptionId
    #[PsObject] $Links
    OrderLineItem ([uint16] $LineItemNumber,[string] $OfferId,[uint16] $Quantity)
    {
        $this.LineItemNumber = $LineItemNumber
        $this.OfferId = $OfferId
        $this.Quantity = $Quantity
    }
    OrderLineItem ()
    {
    }
}

class SpendingBudget
{
    [double] $amount
    SpendingBudget ([double] $amount)
    {
        $this.amount = $amount
    }
}

#region SR class
class ServiceRequestOrganization
{
    [string] $Id
    [string] $Name
    [string] $PhoneNumber
}

class ServiceRequestContact
{   
    [string] $ContactId
    [string] $LastName
    [string] $FirstName
    [string] $Email
    [string] $PhoneNumber
    [ServiceRequestOrganization] $Organization
}

class ServiceRequestNote
{
    [string]   $CreatedByName
    [string]   $Text
    [datetime] $CreatedDate

    ServiceRequestNote ([string]$Text)
    {
        $this.Text = $Text
       # $this.CreatedDate = Get-Date
    }

    ServiceRequestNote ()
    {
    }
}

class FileInfo
{
    [string] $Comment
    [string] $FileExtension
    [string] $FileNameWithoutExtension
    [long]   $FileSize
    [string] $Id
}

class ServiceRequest
{

    #Mandatory Fields
    [string]	$Title
    [string]	$Description
    [string]	$Severity
    [string]	$SupportTopicId

    #Optional Fields
    [string]	$SupportTopicName
    [string]	$Id
    [string]	$ProductName
    [string]	$ProductId
    [datetime]	$CreatedDate
    [datetime]	$LastModifiedDate
    [datetime]	$LastClosedDate
    [string]	$CountryCode
    [Object]    $Attributes
    [FileInfo[]]                    $FileLinks
    [ServiceRequestNote]	        $NewNote
    [ServiceRequestNote[]]	        $Notes
    [ServiceRequestContact]	        $PrimaryContact
    [ServiceRequestContact]	        $LastUpdatedBy
    [ServiceRequestOrganization]	$Organization
    [ValidateSet('none','open','closed','attention_needed')][string]	$Status
  
    #main constructor
    ServiceRequest ([string]$Title,[string]$Description,[string]$Severity,[string]$SupportTopicId)
    {
        $this.Title =          $Title
        $this.Severity =       $Severity
        $this.Description =    $Description
        $this.SupportTopicId = $SupportTopicId
    }
  
    #constructor
    ServiceRequest ()
    {
    }
}
#endregion

class _Filter
{
    #filter example: '{"Field":"CompanyName","Value":"csp","Operator":"starts_with"}'
    #Mandatory Fields
    [string]$Field
    [string]$Value
    [string]$Operator
    <#
    [ValidateSet('CONTAINS','NOT_CONTAINS','IS','IS_NOT','ARE','IN','NOT_IN',
'IN_RANGE','NOT_IN_RANGE','STARTS_WITH','ENDS_WITH','ON_OR_BEFORE','ON_OR_AFTER','BETWEEN',
'EARLIER_THAN','WITHIN_THE_LAST','GREATER_THAN','LESS_THAN','IS_EMPTY','IS_NOT_EMPTY','INCLUDE'
'DO_NOT_INCLUDE','IS_APPLIED','IS_NOT_APPLIED',
)][string]	$Operator
    #>

    _Filter([string]$Field,[string]$Value,[string]$Operator)
    {
        $this.Field = $Field
        $this.Value = $Value
        $this.Operator = $Operator
    }

    [string] _ToString ()
    {
        return '{"Field":"' + $this.Field + '","Value":"' + $this.Value + '","Operator":"' + $this.Operator + '"}'
    }
}

#region class from GraphAPI
class PasswordResetInfo
{
    [PasswordProfile] $passwordProfile
}

class PasswordProfile
{
    [string] $password
    [bool] $forceChangePasswordNextLogin
}

Set-Variable -Name "GlobalCustomerID" -Value "" -Scope Global -Visibility Private 
Set-Variable -Name "GlobalToken" -Value "" -Scope Global -Visibility Private 


