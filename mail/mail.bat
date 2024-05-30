@echo off
Echo Waiting for server...
:Loop
timeout 10
Ping mail.smtp2go.com -n 1
if errorlevel 1 goto Loop
goto Email

:Email
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '.\mail.ps1'"