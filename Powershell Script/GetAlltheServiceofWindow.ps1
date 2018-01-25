Clear-Host
Get-Service | where {$_.Status -eq "Running"} | Export-Csv -path "C:\ps\services.csv"