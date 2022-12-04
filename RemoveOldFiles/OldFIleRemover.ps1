# Script to delete old files. Useful for removing old downloads on RDS servers
# Script created by Jared Stillwell
# Version: 1.0

$rootdir = @('\\TARGETNETWORKFOLDER1\','\\TARGETNETWORKFOLDER2\','\\TARGETNETWORKFOLDER3\')
$Daysback = "-15"
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)


Foreach($root in $rootdir){
    cd $root
    $Paths = (Get-ChildItem).Name
    foreach($Path in $Paths){
        $FullDir = $Path
        #$FullDir = $Path + "\Downloads"
        #Get-ChildItem $FullDir | Where-Object {$_.LastWriteTime -lt $DatetoDelete}
        Get-ChildItem $FullDir | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item

    }
}

