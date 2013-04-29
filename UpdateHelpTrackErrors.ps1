$error.Clear()
Update-Help -Module * -Force -ea 0
For ($i = 0 ; $i -le $error.Count ; $i ++)
	{ "`nerror $i" ; $error[$i].exception }