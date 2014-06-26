#########################################################
#########################################################
#########################################################
Write-Host
$ReleaseDate = "2014/06/26"
$Version = "1.0"
Write-Host -foregroundcolor "Yellow" -backgroundcolor "DarkGreen" Release Date: $ReleaseDate
Write-Host -foregroundcolor "Yellow" -backgroundcolor "DarkGreen" Version: $Version
Write-Host
#########################################################
#########################################################
#########################################################

$ObjComputerInfo = get-wmiobject Win32_ComputerSystem
$Manufacturer = $ObjComputerInfo.Manufacturer
$Model = $ObjComputerInfo.Model
$Name = $ObjComputerInfo.Name
Write-Host -foregroundcolor "magenta" Manufacturer:`t $Manufacturer
Write-Host -foregroundcolor "magenta" Model:`t`t $Model
Write-Host -foregroundcolor "magenta" Name:`t`t $Name
Write-Host

$Date = Get-Date -Format "MM/dd/yyyy"
Write-Host $Date
Write-Host

#######################
Write-Host -foregroundcolor "Blue" Foregroundcolor `"Blue`"
Write-Host -foregroundcolor "Cyan" Foregroundcolor `"Cyan`"
Write-Host -foregroundcolor "DarkBlue" Foregroundcolor `"DarkBlue`"
Write-Host -foregroundcolor "DarkCyan" Foregroundcolor `"DarkCyan`"
Write-Host -foregroundcolor "DarkGray" Foregroundcolor `"DarkGray`"
Write-Host -foregroundcolor "DarkGreen" Foregroundcolor `"DarkGreen`"
Write-Host -foregroundcolor "DarkMagenta" Foregroundcolor `"DarkMagenta`"
Write-Host -foregroundcolor "DarkRed" Foregroundcolor `"DarkRed`"
Write-Host -foregroundcolor "DarkYellow" Foregroundcolor `"DarkYellow`"
Write-Host -foregroundcolor "Gray" Foregroundcolor `"Gray`"
Write-Host -foregroundcolor "Green" Foregroundcolor `"Green`"
Write-Host -foregroundcolor "Magenta" Foregroundcolor `"Magenta`"
Write-Host -foregroundcolor "Red" Foregroundcolor `"Red`"
Write-Host -foregroundcolor "White" Foregroundcolor `"White`"
Write-Host -foregroundcolor "Yellow" Foregroundcolor `"Yellow`"
Write-Host -foregroundcolor "Black" -backgroundcolor "White" Foregroundcolor `"Black`" Backgroundcolor `'White`'
Write-Host

#######################
$OutFile = "tmp.txt"

IF(Test-Path $OutFile)
{
	Write-Host $OutFile exists, we will delete it.
	Remove-Item $OutFile
} ELSE {
	Write-Host $OutFile not exists.
}

#"===================" | Out-File $OutFile
Out-File $OutFile -inputobject "==============================================" -append	# method 1 to write file
"Manufacture:`t $Manufacturer" | Out-File $OutFile -Append	# method 2 to write file
"Model:`t`t $Model" >> $OutFile	# method 3 to write file
Out-File $OutFile -inputobject "Name:`t`t $Name" -append
Out-File $OutFile -inputobject "==============================================" -append
Out-File $OutFile -inputobject "" -append

$MultiLineVariable = "This is a multiline variable test
Line 1
					Line 2 (with tab)
					Line 3 (with tab)
Line 4
END"
					
Out-File $OutFile -inputobject $MultiLineVariable -Append
Out-File $OutFile -inputobject "" -append

# Multi line variable , here-string
$MultiLineVariable2 = @"
========================
This is a multiline variable here-string test
Line 5
Line 6
Line 7
	Line 8 (with tab)
Line 9
Line 10
========================
"@

Out-File $OutFile -inputobject $MultiLineVariable2 -Append
Out-File $OutFile -inputobject "" -append

#notepad $OutFile

#############################################################################

# Popup window. 1 is OK, 2 is cancel (or close window)
# nType parameter
# 0x0 (0). Show OK button.
# 0x1 (1). Show OK and Cancel buttons.
# 0x2 (2). Show Abort, Retry, and Ignore buttons.
# 0x3 (3). Show Yes, No, and Cancel buttons.
# 0x4 (4). Show Yes and No buttons. 
# 0x5 (5). Show Retry and Cancel buttons.
# 0x6 (6). Show Cancel, Try Again, and Continue buttons.

# 0x10 (16). Show "Stop Mark" icon.
# 0x20 (32). Show "Question Mark" icon.
# 0x30 (48). Show "Exclamation Mark" icon.
# 0x40 (64). Show "Information Mark" icon.

# 0x100 (256). The second button is the default button.
# 0x200 (512). The third button is the default button.
# 0x1000 (4096). The message box is a system modal message box and appears in a topmost window.
# 0x80000 (524288). The text is right-justified.
# 0x100000(1048576) The message and caption text display in right-to-left reading order, which is useful for some languages.

# -1, The user did not click a button before nSecondsToWait seconds elapsed.
# 1, OK button
# 2, Cancel button
# 3, Abort button
# 4, Retry button
# 5, Ignore button
# 6, Yes button
# 7, No button
# 8, Try Again button
# 9, Continue button

$wshell = New-Object -ComObject Wscript.Shell

$YesNo = $wshell.Popup("Operation Completed Test",0,"Done",0x1 + 4096)
$wshell.Popup("Your choice is: " + $YesNo ,2,"2 seconds time out",0x0 + 4096)
Write-Host "----------------------------------"
IF ($YesNo -eq "1" ) {
	Write-Host $YesNo
	Write-Host "You click OK"
} ELSE {
	Write-Host $YesNo
	Write-Host "You click Cancel"
}

# 6 = Yes, 7 = No
$YesNo2 = $wshell.Popup("Yes or No test",0,"Yes or No",0x4 + 4096)
Write-Host "----------------------------------"
$wshell.Popup("Your choice is: " + $YesNo2 ,2,"2 seconds time out",0x0 + 0x40 + 4096)

$wshell.Popup("Stop Mark",2,"xxx",0x0 + 0x10 + 4096)
$wshell.Popup("Question Mark",2,"xxx",0x0 + 0x20 + 4096)
$wshell.Popup("Exclamation Mark",2,"xxx",0x0 + 0x30 + 4096)
$wshell.Popup("Information Mark",2,"xxx",0x0 + 0x40 + 4096)

##########################

Function Get-FileName($initialDirectory)
{   
 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
 Out-Null

 $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
 $OpenFileDialog.initialDirectory = $initialDirectory
 $OpenFileDialog.filter = "All files (*.*)| *.*"
 $OpenFileDialog.ShowDialog() | Out-Null
 $OpenFileDialog.filename
} #end function Get-FileName

# *** Entry Point to Script ***

#$WimFile = Get-FileName -initialDirectory ""
$WimFile = Get-FileName -initialDirectory "X:\"

IF ($WimFile) {
	IF(Test-Path $WimFile)
	{
		Write-Host $WimFile exists.
	} ELSE {
		Write-Host $WimFile not exists.
	}
} ELSE {
	Write-Host You did not choose a file.
	$wshell.Popup("You did not choose a file",2,"Error",0x0)
}

# Read registry
$key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion'
$ProgramFilesDir = (Get-ItemProperty -Path $key -Name ProgramFilesDir).ProgramFilesDir
$wshell.Popup("Program Files Dir is: " + $ProgramFilesDir ,2,"2 seconds time out",0x0 + 0x40 + 4096)

$Key2 = "HKLM:\System\CurrentControlSet\Control\Session Manager\Environment"
$SystemPath = (Get-ItemProperty -Path $key2 -Name Path).Path
$wshell.Popup("System Path is: " + $SystemPath ,2,"2 seconds time out",0x0 + 0x40 + 4096)

# another way to read registry
$key3 = (Get-Itemproperty hklm:software\microsoft\windows\currentversion).ProgramFilesDir
$wshell.Popup("Program Files Dir is (method 2): " + $key3 ,2,"2 seconds time out",0x0 + 0x40 + 4096)

$key4 = (Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Environment").Path
$wshell.Popup("System Path is (method 2): " + $key4 ,2,"2 seconds time out",0x0 + 0x40 + 4096)

# Creating Keys
New-Item -Path hkcu:\software\_DeleteMe
# Creating Keys (with space)
New-Item -Path "hkcu:\software\_Delete Me"
# Deleting Keys
Remove-Item -Path hkcu:\Software\_DeleteMe
# Deleting Keys (with space)
Remove-Item -Path "hkcu:\software\_Delete Me"
