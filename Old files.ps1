$Folder = "C:\Temp"

#Delete files older than 2 months
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-60)} |
ForEach-Object {
   $_ | del -Force
}