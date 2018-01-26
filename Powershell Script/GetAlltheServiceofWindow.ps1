#this is create list of service running in your window and save in csv file

#Clear-Host
#Get-Service | where {$_.Status -eq "Running"} | Export-Csv -path "C:\ps\services.csv"

