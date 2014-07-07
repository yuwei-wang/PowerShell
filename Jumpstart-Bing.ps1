#########################################################
Write-Host
$ReleaseDate = "2014/07/07"
$Version = "WYW, 1.0"
Write-Host -foregroundcolor "Yellow" -backgroundcolor "DarkGreen" Release Date: $ReleaseDate
Write-Host -foregroundcolor "Yellow" -backgroundcolor "DarkGreen" Version: $Version
Write-Host
#########################################################
$wshell = New-Object -ComObject Wscript.Shell

$defaultSearchCU = (Get-Itemproperty "HKCU:\Software\Microsoft\Internet Explorer\SearchScopes")."DefaultScope"
$defaultSearchCU = "HKCU:\Software\Microsoft\Internet Explorer\SearchScopes" + "\" + $defaultSearchCU

New-ItemProperty -Path $defaultSearchCU -Name URL -Value "http://www.bing.com/search?q={searchTerms}&form=IE11TR&src=IE11TR&pc=MAMIJS;" -Force

$defaultSearchCU2 = (Get-Itemproperty "$defaultSearchCU")."URL"
Out-File Log\JumpStart.log -inputobject $defaultSearchCU2