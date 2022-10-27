# Part 1: Create directory
$path = "C:\AESkey"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}


# Part 2: Generate your encrypted password #
# Do not include this in the end script - run it as its own separate instance #
# Prompt you to enter the username and password #
 $credObject = Get-Credential
 
 # The credObject now holds the password in a ‘securestring’ format #
 $passwordSecureString = $credObject.password
 
 # Define a location to store the AESKey #
 $AESKeyFilePath = "c:\AESkey\aeskey.txt"
 # Define a location to store the file that hosts the encrypted password #
 $credentialFilePath = "C:\AESkey\credpassword.txt"
 
 # Generate a random AES Encryption Key. #
 $AESKey = New-Object Byte[] 32
 [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($AESKey)
 
 # Store the AESKey into a file. This file should be protected! (e.g. ACL on the file to allow only select people to read) #
 Set-Content $AESKeyFilePath $AESKey # Any existing AES Key file will be overwritten #
 $password = $passwordSecureString | ConvertFrom-SecureString -Key $AESKey
 Set-Content $credentialFilePath $password
