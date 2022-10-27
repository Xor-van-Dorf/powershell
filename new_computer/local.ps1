#####################SET KEYBOARD LAYOUT#####################
Set-WinSystemLocale fr-CA
Set-WinUserLanguageList -LanguageList fr-CA
$languageList = Get-WinUserLanguageList
$languageList[0].InputMethodTips.Clear()
$languageList[0].InputMethodTips.Add('0C0C:00001009')
Set-WinUserLanguageList $languageList -Force

#####################SET TIME ZONE#####################
Set-TimeZone -Name "Est"

#####################REMOVE BLOATWARE#####################
Get-AppxPackage *Microsoft.3dbuilder* | Remove-AppxPackage
Get-AppxPackage *AdobeSystemsIncorporated.AdobePhotoshopExpress* | Remove-AppxPackage
Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Asphalt8Airborne* | Remove-AppxPackage
Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage
Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage
Get-AppxPackage *king.com.CandyCrushSodaSaga* | Remove-AppxPackage
Get-AppxPackage *Microsoft.DrawboardPDF* | Remove-AppxPackage
Get-AppxPackage *Facebook* | Remove-AppxPackage
Get-AppxPackage *BethesdaSoftworks.FalloutShelter* | Remove-AppxPackage
Get-AppxPackage *FarmVille2CountryEscape* | Remove-AppxPackage
Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage
Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage
Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Wallet* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage
Get-AppxPackage *Todos* | Remove-AppxPackage
Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage
Get-AppxPackage *MinecraftUWP* | Remove-AppxPackage
Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage
Get-AppxPackage *Microsoft.BingFinance* | Remove-AppxPackage
Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage
Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage
Get-AppxPackage *Netflix* | Remove-AppxPackage
Get-AppxPackage *OneNote* | Remove-AppxPackage
Get-AppxPackage *PandoraMediaInc* | Remove-AppxPackage
Get-AppxPackage *Microsoft.People* | Remove-AppxPackage
Get-AppxPackage *CommsPhone* | Remove-AppxPackage
Get-AppxPackage *windowsphone* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage
Get-AppxPackage *flaregamesGmbH.RoyalRevolt2* | Remove-AppxPackage
Get-AppxPackage *WindowsScan* | Remove-AppxPackage
Get-AppxPackage *AutodeskSketchBook* | Remove-AppxPackage
Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage
Get-AppxPackage *Office.Sway* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage
Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage
Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage
Get-AppxPackage *XboxOneSmartGlass* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage
Get-AppxPackage *DB6EA5DB.MediaSuiteEssentialsforDell* | Remove-AppxPackage
Get-AppxPackage *DB6EA5DB.Power2GoforDell* | Remove-AppxPackage
Get-AppxPackage *WavesAudio.MaxxAudioProforDell2020* | Remove-AppxPackage
Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage
Get-AppxPackage *DB6EA5DB.PowerDirectorforDell* | Remove-AppxPackage
Get-AppxPackage *Microsoft.RemoteDesktop* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage
Get-AppxPackage *DB6EA5DB.PowerMediaPlayerforDell* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage
Get-AppxPackage *Microsoft.BingTranslator* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage

#####################Set Sound Schemes to no sound#####################
Write-Host "`nSetting Sound Schemes to 'No Sound' .." -foregroundcolor Gray 

$Path = "HKCU:\AppEvents\Schemes"

$Keyname = "(Default)"

$SetValue = ".None"

$TestPath = Test-Path $Path
if (-Not($TestPath -eq $True)) {
    Write-Host " Creating Folder.. " -foregroundcolor Gray 
    New-item $path -force
} 
 
if (Get-ItemProperty -path $Path -name $KeyName -EA SilentlyContinue) {
  
    $Keyvalue = (Get-ItemProperty -path $Path).$keyname  
  
    if ($KeyValue -eq $setValue) {
 
        Write-Host " The Registry Key Already Exists. " -foregroundcolor green 
 
 
    }
    else {
 
        Write-Host " Changing Key Value.. " -foregroundcolor Gray 
 
        New-itemProperty -path $Path -Name $keyname -value $SetValue -force # Set 'No Sound' Schemes
        Get-ChildItem -Path "HKCU:\AppEvents\Schemes\Apps" | # Apply 'No Sound' Schemes
         Get-ChildItem | 
         Get-ChildItem | 
         Where-Object { $_.PSChildName -eq ".Current" } | 
         Set-ItemProperty -Name "(Default)" -Value ""
 
        Write-Host " The Registry Key Value Changed Sucessfully. " -foregroundcolor green 
    }
 
}
else {
  
    Write-Host " Creating Registry Key.. " -foregroundcolor Gray 
   
    New-itemProperty -path $Path -Name $keyname -value $SetValue -force
    Get-ChildItem -Path "HKCU:\AppEvents\Schemes\Apps" | 
        Get-ChildItem | 
        Get-ChildItem | 
        Where-Object { $_.PSChildName -eq ".Current" } | 
        Set-ItemProperty -Name "(Default)" -Value ""

  
    Write-Host " The Registry Key Created Sucessfully. " -foregroundcolor green 
}

#####################QOL TWEAKS#####################
reg import .\Tweaks.reg