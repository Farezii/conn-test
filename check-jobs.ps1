Write-Host "Running background job, do not close. Run Get-Job to check progress"
Get-Job -Id 1 -IncludeChildJob
Write-host "Current time: $(Get-Date)"