$taskName = "TestTaskScheduler"
$taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\<path to the file>\testTask.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At "23:40"

if($taskExists) {
	Set-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName
} else {
	Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Description "Testing how to schedule a task"
}

