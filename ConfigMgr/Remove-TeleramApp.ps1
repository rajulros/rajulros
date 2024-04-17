
$desktopapp = Get-Package -Name "Telegram Desktop" -erroraction SilentlyContinue
if ($desktopapp)
{
    $ustring = $desktopapp.meta.attributes["uninstallString"]
    Start-Process -FilePath $ustring /Silent 
}
Get-AppxPackage -Name *Telegram* | Remove-AppxPackage -AllUsers