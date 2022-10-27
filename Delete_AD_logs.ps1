net stop certsvc
del /Q %windir%\System32\certlog\*.log
net start certsvc
