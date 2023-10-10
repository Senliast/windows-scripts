SET mypath=%~dp0
start powershell.exe -file %mypath:~0,-1%\SteamAppsUpdatesControl.ps1