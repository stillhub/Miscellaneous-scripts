# Script to get battery health report of remote machine. Saves report on a network drive.
# Script created by Jared Stillwell
# Version: 1.0
#
# Notes:
# 


([switch]$Elevated)
function CheckAdmin{
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((CheckAdmin) -eq $false) {
    if ($elevated) {
        # could not elevate, quit
    }
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -ExecutionPolicy Bypass -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition)) | Out-Null
    }
    Exit
}

CheckAdmin
$computer = Read-Host "Enter machine hostname"
$s = New-PSSession -ComputerName $computer #-Credential Domain01\User01
Invoke-Command -Session $s -ScriptBlock {powercfg /batteryreport /output \\NETWORKCOMPUTERNAME\C$\Temp\$computer.html}
pause