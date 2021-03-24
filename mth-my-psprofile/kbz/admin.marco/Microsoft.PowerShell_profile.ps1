Function cnct-msxOnline
{
$credentials = Get-Credential -Credential username@domain.com
Write-Output “Getting the Exchange Online cmdlets”
$Session = New-PSSession -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
-ConfigurationName Microsoft.Exchange -Credential $credentials `
-Authentication Basic -AllowRedirection
Import-PSSession $Session
write-host -fore green "[i] end session with  Get-PSSession | Remove-PSSession"
}
#
Function cnct-msx
{
$remhost="kbzsg-d-exc01.cl03.ch"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$remhost/PowerShell/ -Authentication Kerberos 
Import-PSSession $Session -DisableNameChecking
write-host -fore green "[i] connected to $remhost"
write-host -fore green "[i] end session with  Get-PSSession | Remove-PSSession"
}
Function gt-functions
{
write-host -fore green "[i] die Liste der eigenen Funktionen"
Get-Content -Path $profile | Select-String -Pattern "^function.+" | ForEach-Object {
        # Find function names that contains letters, numbers and dashes
        [Regex]::Matches($_, "^function ([a-z0-9.-]+)","IgnoreCase").Groups[1].Value
    } | Where-Object { $_ -ine "prompt" } | Sort-Object
write-host -fore green "[/i]"
}
#
Function gt-alias
{
write-host -fore green "[i] die Liste der eigenen Alias"
Get-Content -Path $profile | Select-String -Pattern "^set-alias.+" | ForEach-Object {
        # Find alias names that contains letters, numbers and dashes
        [Regex]::Matches($_, "^set-alias ([a-z0-9.-]+)","IgnoreCase").Groups[1].Value
    } | Where-Object { $_ -ine "prompt" } | Sort-Object
write-host -fore green "[/i]"
}
#
function st-color ($bc,$fc) 
{
$a = (Get-Host).UI.RawUI
$a.BackgroundColor = $bc
$a.ForegroundColor = $fc ; cls
}
#	Black 	White
#	Gray	DarkGray
#	Red 	DarkRed
#	Blue 	DarkBlue
#	Green 	DarkGreen
#	Yellow	DarkYellow
#	Cyan 	DarkCyan
#	Magenta DarkMagenta
#st-color "DarkGreen" "Gray"
#
Function sign-script {
	Param(
	[parameter(Position=0)]
		$Filename
	)
$timestampserver = "http://timestamp.comodoca.com/authenticode"
$cert = Get-ChildItem -path Cert:\CurrentUser\my -CodeSigningCert
Set-AuthenticodeSignature $Filename $cert[0] -IncludeChain All -TimeStampServer $timestampserver
}
#
set-alias edit "C:\Program Files (x86)\Notepad++\notepad++.exe"
#
gt-functions
gt-alias