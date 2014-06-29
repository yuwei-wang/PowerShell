#########################################################
Write-Host
$ReleaseDate = "2014/06/29"
$Version = "WYW, 1.0"
Write-Host -foregroundcolor "Yellow" -backgroundcolor "DarkGreen" Release Date: $ReleaseDate
Write-Host -foregroundcolor "Yellow" -backgroundcolor "DarkGreen" Version: $Version
Write-Host
#########################################################
$wshell = New-Object -ComObject Wscript.Shell

$keyOfPath = (Get-Itemproperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Environment").Path
$keyOfPath = $keyOfPath + ";%SystemRoot%\Microsoft.NET\Framework\v1.1.4322"

New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Environment" -Name Path -Value $keyOfPath -Force
