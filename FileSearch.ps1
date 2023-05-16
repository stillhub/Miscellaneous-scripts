# Define output directory
$OutputDir = "C:\scripts\QuarterlyFileSearch\reports"

# Define UNC paths to scan
#$UNCPaths = @("<UNC_Path1>", "<UNC_Path2>", "<UNC_Path3>", "<UNC_Path4>", "<UNC_Path5>")

# Define file categories and their search patterns
$Categories = @{
    'Scripts' = @('*.ps1', '*.bat', '*.cmd', '*.sh', '*.py', '*.rb', '*.pl', '*.php', '*.js', '*.vbs', '*.tcl', '*.lua', '*.groovy', '*.r')
    'Certificates' = @('*.cer', '*.crt', '*.cer', '*.ca-bundle', '*.p7b', '*.p7c', '*.p7s', '*.pem', '*.key', '*.keystore', '*.jks', '*.p12', '*.pfx', '*.pem')
    'PasswordFiles' = @('*secret*', '*login*', '*pw*', '*pass*', '*credentials*', '*auth*', '*key*', '*access*', '*unlock*')
}

# Defines email settings
$smtpServer = "SMTP"
$smtpFrom = "systemchecks@example.com"
$smtpTo = @("alerts@example.com")

<### Do not edit below this line ###>

# Define date in number format for file save
$CurrentDate = Get-Date -Format "yyyyMMdd"

# Function to send email once script is completed
function SendEmail{
    $messageSubject = "Quarterly File Search complete - $CurrentDate"
    $messagebody = "Quarterly File Search complete. Please review reports. Reports located in: $OutputDir"
    Send-MailMessage -SmtpServer $smtpServer -From $smtpFrom -To $smtpTo -subject $messageSubject -Body $messagebody -BodyAsHtml
}

# Function to scan UNC paths for specified file patterns
function Scan-UNCPaths {
    param (
        [string[]]$Paths,
        [string[]]$Filters
    )

    $Results = @()

    foreach ($Path in $Paths) {
        foreach ($Filter in $Filters) {
            try {
                $Items = Get-ChildItem -Path $Path -Filter $Filter -Recurse -ErrorAction SilentlyContinue -Force
                $Results += $Items
            } catch {
                Write-Warning "Error scanning path: $Path"
            }
        }
    }

    return $Results
}

# Iterate through the categories and perform the scan
foreach ($Category in $Categories.GetEnumerator()) {
    $CategoryName = $Category.Name
    $Filters = $Category.Value
    $OutputFile = "$OutputDir\${CategoryName}_Files_$CurrentDate.csv"

    Write-Host "Scanning for $CategoryName files..."
    $Results = Scan-UNCPaths -Paths $UNCPaths -Filters $Filters

    if ($Results) {
        $Results | Select-Object FullName | Export-Csv -Path $OutputFile -NoTypeInformation
        Write-Host "Exported $CategoryName files to $OutputFile"
    } else {
        Write-Host "No $CategoryName files found"
    }
}
SendEmail