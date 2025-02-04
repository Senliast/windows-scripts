# Steam apps updates control  
## About
This script makes it possible to control the automatic updates of apps and games downloaded from Steam. It can be useful, if you would like to play a singleplayer game with mods (for example, the mods are available only for older version of a game) or use an older version of an app from Steam for some reason. Also, for those apps that have auto-updates disabled using this script, new Steam Workshop items will not be downloaded, existing ones will not be updated, and unsubscribed ones will not be removed. In combination with for example, Steam Depot Downloader (https://github.com/SteamRE/DepotDownloader) you can download older versions of apps and games even after you already updated and hold the old verion.

Obviously, as this is a PowerShell script, the execution of PowerShell scripts must be allowed on your system, in order for it to work. This script will at all case work on Windows 8 and newer, i am not sure about Windows 7, as PowerShell here is on very early state and may lack some functions. To start the script after installation - open the Steam-apps updates control.lnk .

The default directory to put the script files to is "C:\Software_support\SteamAppsUpdatesControl" but you can place it into other directory if you want. Please note, that name and path to the directory must include only english letters and be without spaces.

## Download
You can download latest release from: https://github.com/Senliast/windows-scripts/releases/tag/Steam-apps-updates-control-v2.0.

## Installation
1. Enable execution of PowerShell scripts on your system, if not already. In order to do this:
   - for Windows "Home" editions:
     1. Start PowerShell as administrator.
     2. Type "Set-ExecutionPolicy -Scope LocalMachine Unrestricted", press enter.
     3. Confirm the prompt.
   - for Windows "Pro" editions:
     1. Open Group Policy Editor.
     2. Navigate to "Computer configuration > Administrative templates > Windows components > Windows PowerShell"
     3. Open the setting "Allow script executing", select "Allow all scripts", press OK.
2. Place the files and folders from the "Script files" folder into the default folder "C:\Software_support\SteamAppsUpdatesControl\" or into other, if you want.
3. You need this step only if you placed the files into other directory then default:
   - open properties of the Steam-apps updates control.lnk (shortcut) from "Extras" folder and make sure that the "target" is pointing to the "SteamAppsUpdatesControl.bat" file and the "start in" - to its parent directory.
4. Place the Steam-apps updates control.lnk (shortcut) in a comfortable location for you (for example on Desktop). Start it in order to start the script.

## Updating
1. Delete all files, except "AppList.txt" in the script folder.
2. Place new files of the script, except "AppList.txt".

## Uninstalling
1. Remove all apps from list.
2. Remove all files from the script.
3. If you dont use any other PowerShell scripts - disable script execution:
   - for Windows "Home" editions:
     1. Start PowerShell as administrator.
     2. Type "Set-ExecutionPolicy -Scope LocalMachine Undefined", press enter.
     3. Confirm the prompt.
   - for Windows "Pro" editions:
     1. Open Group Policy Editor.
     2. Navigate to "Computer configuration > Administrative templates > Windows components > Windows PowerShell"
     3. Open the setting "Allow script executing", select "Not configured", press OK.



## Questions and answers
Q: How does it work?  
A: This script removes the "appmanifest" file, which Steam uses to detect that an app or game is installed and which holds information about the app. After removing it, Steam does not see the app anymore and therefore will not update it anymore.  

Q: Does it have any disadvantages?  
A: Some apps insist to be started from Steam directly (steam://rungameid) and otherwise refuse to start. In this case, nothing can be done. Besides of that, everything other (achievements, network functions, connection with Steam Workshop) should still work.  



## Copyright and 3rd-party authors and sources
The information from following websites and authors has been used for creating this script:  
https://developer.valvesoftware.com/  
https://www.makeuseof.com/how-to-downgrade-steam-games/  
https://steamdb.info/  
https://www.reddit.com/r/Steam/comments/611h5e/guide_how_to_download_older_versions_of_a_game_on/  
https://www.reddit.com/r/Steam/comments/kbcl2x/why_is_there_no_option_to_turn_off_auto_updates/  
https://steamcommunity.com/sharedfiles/filedetails/?id=1916008329  
https://chat.openai.com/  
https://stackoverflow.com  
https://ss64.com/ps/syntax-arrays.html  
https://learn.microsoft.com/de-de/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.3  
https://www.itprotoday.com/powershell/how-add-new-line-powershell-string  
https://stackoverflow.com/questions/9701840/how-to-create-a-shortcut-using-powershell  

## Key words
Steam, disable Steam games updates, disable Steam games auto updates, start Steam game without update, skip Steam game update, old version of Steam game, Steam update manager, Steam games update manager
