# Script to test internet download speed
# Script created by Jared Stillwell
# Version: 1.0

Function Measure-NetworkSpeed{
    # The test file has to be a 10MB file for the math to work. If you want to change sizes, modify the math to match
    $TestFile  = 'https://www.stats.govt.nz/assets/Uploads/International-trade/International-trade-September-2021-quarter/Download-data/overseas-trade-indexes-September-2021-quarter-provisional-csv.csv'
    $TempFile  = Join-Path -Path $env:TEMP -ChildPath 'testfile.tmp'
    $WebClient = New-Object Net.WebClient
    $TimeTaken = Measure-Command { $WebClient.DownloadFile($TestFile,$TempFile) } | Select-Object -ExpandProperty TotalSeconds
    $SpeedMbps = (21 / $TimeTaken) * 8
    $Message = "{0:N2} Mbit/sec" -f ($SpeedMbps)
    $Message
}

Measure-NetworkSpeed