# Add-PCAuthentication

Authenticates the current session with the Partner Center API.

## SYNTAX

```powershell
Add-PCAuthentication -CspAppId <String> -CspDomain <String> -Credential <PSCredential> [<CommonParameters>]

Add-PCAuthentication -CspAppId <String> -CspDomain <String> -CspClientSecret <SecureString> [<CommonParameters>]
```

## DESCRIPTION

The Add-PCAuthentication cmdlet sets up authentication for the Partner Center API. Authenticate with either App authentication or App+User authentication to use other cmdlets in this module.

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

Some cmdlets require App+User authentication. If you are working with invoices or users, you should use App+User authentication.

$clientSecret = '<key code secret>'
$clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force
$cred = Get-Credential

## EXAMPLES

You can obtain the Web App ID and the Client Secret from either Partner Center UI or Azure Active Directory

### EXAMPLE 1

Set a global token for the script session - App+User authentication

```powershell
PS C:\>$cred = Get-Credential
PS C:\>Add-PCAuthentication -CspAppId '<native app id GUID>' -CspDomain '<csp partner domain>' -Credential $cred
```

### EXAMPLE 2

Set a global token for the script session - App authentication

```powershell
PS C:\>$clientSecret = '<key code secret>'
PS C:\>$clientSecretSecure = $clientSecret | ConvertTo-SecureString -AsPlainText -Force
PS C:\>Add-PCAuthentication -CspAppId '<web app id GUID>' -CspDomain '<csp partner domain>' -CspClientSecret $clientSecretSecure
```
