#$folders = dir
$folders = Import-Csv 1.csv
$folderpath = $folders.Name

foreach($DirPath in $folderpath){
    write-host "Removing security from $DirPath"
    icacls $DirPath /remove:g "GROUP 1" /t /c
    icacls $DirPath /remove:g "GROUP 2" /t /c
    #icacls $DirPath /deny $DirPath:W /c
    #$permission = $DirPath + ":(M)"
    #icacls $DirPath /grant $permission /t /c
}

dir | export-csv -path usersDesktop.csv -NoTypeInformation

cd D:\DocumentFolder
cd D:\DesktopFolder