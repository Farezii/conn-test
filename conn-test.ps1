# Made using Powershell 7.4
# Run using "./conn-test.ps1"
# Script to test connection using Test-Connection for a certain amount of time
# and output the results to a file


Param (
    [Parameter(Mandatory)]
    [string]$Hostname,
    [int]$Days = 1,
    [int]$Samples = 10,
    [string]$Tag = "ethernet"
)

$date = Get-Date -Format "yyyy-MM-dd"
$time = Get-Date -Format "HH-mm-ss"
$filename = "conn-test-$Tag-$date-$time.txt"

$sleep = $Days * 24 * 60 * 60 / $Samples

$start = Get-Date
$end = $start.AddHours($Days * 24)
# $end = $start.AddSeconds(60)

while ($end -gt (Get-Date)) {
    # Gets current date and time and appends to file
    $sampleTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $sampleString = "Sample time: $sampleTime"
    $sampleString | Out-File -FilePath $filename -Append
    # Tests connection according to parameters
    $result = Test-Connection $Hostname -Count 15 -ErrorAction SilentlyContinue
    If ($null -eq $result) {
        $result = "Error: No connection on this sample.`n"
    }
    $result | Out-File -FilePath $filename -Append
    # Print for debugging purposes
    # Write-Output $sampleString
    # Sleeps for n seconds
    Start-Sleep -Seconds $sleep
}

# Test-Connection-Multiday -Hostname "google.com" -Days 1 -Samples 10 -Tag "ethernet" &