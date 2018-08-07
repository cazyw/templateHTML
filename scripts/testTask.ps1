$date = Get-Date -Format g
$text = "This is a test task $date"
Out-File -FilePath "C:\Users\Caz\coding\testTaskOutput.txt" -Encoding "UTF8" -InputObject $text