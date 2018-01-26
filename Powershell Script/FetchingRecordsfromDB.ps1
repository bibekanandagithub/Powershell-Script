#
# FetchingRecordsfromDB.ps1
#

$dataSource = "DESKTOP-ANH3RO7"
$user = "sa"
$pwd = "xxxx"
$database = "FB"
$connectionString = "Server=$dataSource;uid=$user; pwd=$pwd;Database=$database;Integrated Security=False;"

$query = "SELECT * FROM FB_INFO"

$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
#$connection.ConnectionString = "Server=$dataSource;Database=$database;Integrated Security=True;"
$connection.Open()
$command = $connection.CreateCommand()
$command.CommandText = $query

$result = $command.ExecuteReader()

$table = new-object “System.Data.DataTable”
$table.Load($result)

$format = @{Expression={$_.MobNo};Label="Mobile Number";width=40},@{Expression={$_.Username};Label="UserName"; width=30}
$table | Where-Object {$_.Username -like "*.*" } | format-table $format | Out-File C:\ps\swedes.txt


$connection.Close()