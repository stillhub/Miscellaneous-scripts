# Script to unlock BitLocker partition at startup. Can be run via Task Scheduler.
# Script created by Jared Stillwell
# Version: 1.0
#
# Notes:
# 

 
$PaswordLocation = "C:\temp\locker.txt"

#$securePassword = Read-host -AsSecureString | ConvertFrom-SecureString
#$securePassword | Out-File -FilePath $PaswordLocation

$Pass = Get-Content $PaswordLocation

Unlock-BitLocker -MountPoint "J:" -RecoveryPassword $pass -Confirm:$false
