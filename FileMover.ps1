#Enter path of CSV file. This script will move all files within the CSV to the destination folder
$csvpath = import-csv "C:\Temp\move_files.csv"
#Enter destination path below
$destination =  "E:\Data\Archive\10yearold\"

$global:count = 0

foreach($path in $csvpath){
    $global:count += 1
    $fullpath = $path.FullName
    write-host "$fullpath"
    Move-Item -Path $fullpath -Destination $destination"$global:count.$filename"
}