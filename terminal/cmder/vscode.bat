REM Add Cmder as an option in vscode
REM C:\Users\<USER>\Downloads\cmder_mini\vscode.bat
REM Then add this to the vscode settings file:
REM "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\cmd.exe",
REM "terminal.integrated.shellArgs.windows": [
REM     "/K",
REM     "C:\\Users\\<USER>\\Downloads\\cmder_mini\\vscode.bat"
REM ]

REM The CMDER_ROOT path will need to be amended

@echo off
SET CurrentWorkingDirectory=%CD%
SET CMDER_ROOT=<REPLACE WITH FULL PATH TO FOLDER>\cmder_mini
CALL "%CMDER_ROOT%\vendor\init.bat"
CD /D %CurrentWorkingDirectory%