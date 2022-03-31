$DeviceDesc = "CanoScan"
$FindTWAIN = (gwmi Win32_USBControllerDevice |%{[wmi]($_.Dependent)} | Where-Object {($_.Description  -match $DeviceDesc)})
If ($FindTWAIN.Name -match $DeviceDesc){
$DeviceID = ($FindTWAIN.DeviceID).Replace("\","#")
$ClassGuid = $FindTWAIN.ClassGuid
$FullCommand = "`"C:\WINDOWS\system32\rundll32.exe`" fdprint,InvokeTask /ss `"\\?\"
$Params = "`"\\?\"+$DeviceID+"#"+$ClassGuid+"`""
& "C:\WINDOWS\system32\rundll32.exe" fdprint,InvokeTask /ss $Params
}

If ($FindTWAIN.Name -Notmatch $DeviceDesc){
#######################
$MsgBoxInfo = "$DeviceDesc device not found..."
[void] [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
[Microsoft.VisualBasic.Interaction]::MsgBox($MsgBoxInfo, "OKOnly,SystemModal,Exclamation", "Nothing Found.") | Out-null
 ## Out-null just supresses the 'ok' to the (ISE?) screen, after pressing the OK button.
#######################
}