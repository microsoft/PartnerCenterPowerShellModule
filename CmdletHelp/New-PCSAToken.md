# New-PCSaToken

Creates an access token for the Partner Center API.

## SYNTAX

```powershell
New-PCSaToken -CspAppId <String> -CspDomain <String> -Credential <PSCredential> [<CommonParameters>]



New-PCSaToken -CspAppId <String> -CspDomain <String> -CspClientSecret <SecureString> [<CommonParameters>]
```

## DESCRIPTION

The New-PCSaToken cmdlet returns a token used the access Partner Center resources.

## PARAMETERS

### -CspAppId &lt;String&gt;

Specifies a application Id generated for the Partner Center account. The application id must match the authentication type chosen.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -CspDomain &lt;String&gt;

Specifies the Partner Center tenant (onmicrosoft.com) domain.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -CspClientSecret &lt;SecureString&gt;

Specifies an application secret key generated from the Partner Center portal.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```
 
### -Credential &lt;PSCredential&gt;

Specifies the user account credentials to use to perform this task. To specify this parameter, you can type a user name, such as User1 or Domain01\User01 or you can specify a PSCredential object. If you specify a user name for this parameter, the cmdlet prompts for a password.
You can also create a PSCredential object by using a script or by using the Get-Credential cmdlet. You can then set the Credential parameter to the PSCredential object.

```
Required?                    true
Position?                    named
Default value
Accept pipeline input?       false
Accept wildcard characters?  false
```

## INPUTS

## OUTPUTS

## NOTES

$cred = Get-Credential
clientSecret = 'NQSm6Wjsd7PcDeP5JD6arEWMF3UghEpWmphGrshxzsQ='
$ClientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force

## EXAMPLES

### EXAMPLE 1

Creates a new token using the specified information.

```powershell
PS C:\>$sat = New-PCSaToken -CspAppId 97037612-799c-4fa6-8c40-68be72c6b83c -CspDomain contoso.onmicrosoft.com -CspClientSecret $ClientSecretSecure -Credential $cred
```

### EXAMPLE 2

Set a specific token for a command/function - user authentication ##

```powershell
    $cred = Get-Credential
    New-PCSaToken -CspAppId '<native app id GUID>' -CspDomain '<csp partner domain>' -Credential $cred
```

### EXAMPLE 3

Set a specific token for a command/function - app authentication ##

```powershell
    $clientSecret = '<key code secret>'
    $clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force

    New-PCSaToken -CspAppId '<native app id GUID>' -CspDomain '<csp partner domain>' -CspClientSecret $clientSecretSecure
```
