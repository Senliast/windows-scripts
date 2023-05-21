# SteamAppsUpdatesControl v1.0 by @Senliast
# 
# The information from following websites and authors has been used for creating this script:
# https://developer.valvesoftware.com/
# https://www.makeuseof.com/how-to-downgrade-steam-games/
# https://steamdb.info/
# https://www.reddit.com/r/Steam/comments/611h5e/guide_how_to_download_older_versions_of_a_game_on/
# https://www.reddit.com/r/Steam/comments/kbcl2x/why_is_there_no_option_to_turn_off_auto_updates/
# https://steamcommunity.com/sharedfiles/filedetails/?id=1916008329
# https://chat.openai.com/
# https://stackoverflow.com
# https://ss64.com/ps/syntax-arrays.html
# https://learn.microsoft.com/de-de/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.3
# https://www.itprotoday.com/powershell/how-add-new-line-powershell-string
# https://stackoverflow.com/questions/9701840/how-to-create-a-shortcut-using-powershell

# Text strings
$language = Get-WinUserLanguageList
if ($language[0].LanguageTag -like "*de*")
{
    # german
    $textTitle = 'Verwaltung von Updates von Steam-Apps'
    $textTitleLoadingConfiguration = 'Konfiguration wird geladen...'
    $textFollowingAppsAreOnBlacklist = 'Aktuell sind folgende Apps auf der Sperrliste:'
    $textEnterAppNameToDisableUpdates = 'Öffne zuerst die App, für die du Updates seitens Steam ausschalten willst. Falls es bereits Updates für diese App vorhanden sind, die du nicht installieren willst - starte Steam im Offline-Modus oder trenne die Internet-Verbindung. Falls das eine Vollbild-App - minimire diese. Fahre nun mit der Maus über das Symbol der App in der Taskleiste - eine Vorschau wird erscheinen. Gib den Namen der App aus der Vorschau hier ein. Es ist auch möglich, ein Teil davon einzugeben.'
    $textNoAppFound = 'Keine passende App wurde gefunden. Stelle sicher, dass der App-Name / Pfad der ausführbaren Datei / Prozessname richtig eingegeben ist, die App installiert ist und im Steam angezeit wird.'
    $textEnterAppNameToEnableUpdates = 'Gib den Namen der App, für die die Updates eingeschaltet werden sollen, ein. Gib den Namen so ein, wie er in dieser Liste (jedoch ohne "-") angezeigt wird. Es ist auch möglich, ein Teil davon einzugeben.'
    $textEnterAppShortcutName = 'Die Verknüpfung der App konnte nicht automatisch gefunden werden. Gib den Namen der Verknüpfung der App ein, so, wie es im Windows-Start-Menu angezeigt wird. Es ist auch möglich, ein Teil davon einzugeben.'
    $textNoShortcutFound = 'Die Verknüpfung der App konnte nicht gefunden werden. Stelle sicher, dass es richtig geschrieben ist und versuche eventuell, nach einem Teil der Namen zu suchen.'
    $textFootnotesTitle = 'Info: '
    $textFootnotes = 'Beachte, dass dieser Skript nicht mit allen Apps genutzt werden kann. Apps, die vom Steam-Prozess abhängig sind, oder Lizenz über Steam überprüfen, könnten den Start verweigern. Der Skript kann auch nichts machen, wenn eine App nach Updates prüft und den Start verweigert, falls es erkennt, dass es nicht aktuell ist (z.B. Multiplayer-Spiele). Dieser Skript kann nur verhindern, dass Steam eine App aktualisiert. Nachdem die Updates für Apps blockiert wurden, wird es nicht mehr möglich sein, diese Apps aus dem Steam-Bibliothek zu starten. Diese müssen dann über Windows-Start-Menü gestartet werden. Daher, falls du eine Verknüpfung zu der App irgendwo, außer im Windows-Start-Menü (z.B. auf dem Desktop) hast - lösche diese und nimm die neu erstelle Verknüpfung aus dem Windows-Start-Menü. Für die Apps, für die die automatische Updates mithilfe von diesem Skript deaktiviert wurden, werden auch keine neue Steam Workshop Items heruntergeleden, keine Vorhandene aktualisiert und Keine, die abbestellt wurden, entfernt.'
    $textNoAppToEnableUpdatesForFound = 'App wurde nicht gefunden. Stelle sicher, dass sie in der Liste von Apps mit blockierten Updates enthalten ist und überprüfe, ob der Name richtig geschrieben ist.'
    $textNotASteamApp = 'Dies ist keine Steam-App.'
    $textListIsActive = 'Die Liste ist aktiv, die Updates für diese Apps werden blockiert.'
    $textListIsInactive = 'Die Liste ist deaktiviert, die Updates für diese Apps sind zugelassen.'
    $textTooManyProcessesFound = 'Zu viele Treffer gefunden. Versuche, den Prozess-Namen genauer zu schreiben.'
    $textTooManyWindowsFound = 'Zu viele Treffer gefunden. Versuche, den Fenster-Titel genauer zu schreiben und stelle sicher, dass keine andere Fenster (z.B. ein aktiver Tab im Browser) den gleichen Namen haben.'
    $textSelectionPlaceholder = '     '
    $textContinue = 'Fortsetzen'
    $textCancel = 'Abbrechen'
    $textExit = 'Beenden'
    $textAddApp = 'App hinzufügen'
    $textRemoveApp = 'App entfernen'
    $textActivateList = 'Liste aktivieren'
    $textDeactivateList = 'Liste deaktivieren'
    $textEnterOptionNumber = 'Gib die Nummer der Option ein'
    $textSearchForWindowTitle = 'Nach Fenster-Titel suchen'
    $textSearchForProcessName = 'Nach Prozessnamen Suchen'
    $textEnterPath = 'Pfad der ausführbaren Datei eingeben'
    $textInvalidInput = 'Ungültige Eingabe'
    $textProcessing = 'Verarbeitung...'
    $textDone = 'Fertig.'
    $textContinueQuestion = 'Fortsetzen?'
    $textYes = 'Ja'
    $textPressAnyKeyToContinue = 'Drücke eine beliebige Taste um fortzufahren...'
    $textSteamIsStillOpened = 'Steam ist immer noch offen.'
    $textAlreadyAddedToBlacklist = 'Bereits hinzugefügt.'
    $textForFollowingAppsUpdatesWillBeBlocked = 'Für folgende App werden Updates blockiert:'
    $textForFollowingAppsUpdatesWillBeAllowed = 'Für folgende App werden Updates eingeschaltet:'
    $textUpdatesForAllAppsOnBlacklistWillBeBlocked = 'Die Updates für alle Apps auf der Sperrliste werden blockiert. Fortsetzen?'
    $textUpdatesForAllAppsOnBlacklistWillBeAllowed = 'Die Updates für alle Apps auf der Sperrliste werden zugelassen, die Liste wird jedoch nicht gelöscht. Fortsetzen?'
    $textNowCloseAllSteamAppsAndSteam = 'Schließe nun alle Steam-Apps und Steam komplett, sodass diese auch im System-Tray nicht angezeigt werden.'
    $textDoneRestartSteam = 'Fertig. Starte Steam neu, damit die Änderungen in Kraft treten.'
    $textOpenAppAndEnterProcessName = 'Öffne die App (diese kann im Hinter- oder Vordergrund laufen) und gib den Namen des App-Prozesses ein: '
    $textEnterPathInvite = 'Gib den Pfad der ausführbaren Datei der App ein (inkl. Dateinamenerweiterung). Dies kann z.B. eine exe-, jar-, oder bat-Datei sein: '
    $textNowCloseTheAppAndSteam = 'Schließe nun die App und Steam komplett, sodass diese auch im System-Tray nicht angezeigt werden.'
    $textDoneListIsInactive = 'Fertig. Beachte, dass diese Änderungen zurzeit nicht gelten, da die Liste deaktiviert ist.'
    $textFollowingShortcutWasFound = 'Folgende Verknüpfung wurde gefunden: '

}
else
{
    # english
    $textTitle = 'Steam-apps updates control'
    $textTitleLoadingConfiguration = 'Loading configuration...'
    $textFollowingAppsAreOnBlacklist = 'The following apps are currently blacklisted:'
    $textEnterAppNameToDisableUpdates = 'First, open the app for which you want to turn off updates from Steam. If there are already updates for this app that you don''t want to install - start Steam in offline mode or disconnect from the internet. If this is a full screen app - minimize it. Now hover your mouse over the app''s icon in the taskbar - a preview will appear. Enter the name of the app from the preview here. It is also possible to enter part of it.'
    $textNoAppFound = 'No matching app was found. Make sure the app name / executable path / process name is entered correctly, the app is installed and showing up in Steam.'
    $textEnterAppNameToEnableUpdates = 'Enter the name of the app for which you want updates to be turned on. Enter the name as it appears in this list (but without the "-"). It is also possible to enter part of it.'
    $textEnterAppShortcutName = 'The app''s shortcut could not be found automatically. Enter the app''s shortcut name as it appears in the Windows Start menu. It is also possible to enter part of it.'
    $textNoShortcutFound = 'The shortcut of the app could not be found. Make sure it''s spelled correctly and maybe try searching for some of the names.'
    $textFootnotesTitle = 'Info: '
    $textFootnotes = 'Note that this script cannot be used with all apps. Apps that depend on the Steam process or verify license through Steam may refuse to launch. The script also cannot do anything when an app checks for updates and refuses to launch if it detects that it is out of date (e.g. multiplayer games). This script can only prevent Steam from updating an app. After app updates are blocked, it will no longer be possible to launch those apps from the Steam library. These must then be started via the Windows Start menu. Therefore, if you have a shortcut to the app anywhere but in the Windows Start menu (e.g. on the desktop) - delete it and take the newly created shortcut from the Windows Start menu. Also, for those apps that have auto-updates disabled using this script, new Steam Workshop items will not be downloaded, existing ones will not be updated, and unsubscribed ones will not be removed.'
    $textNoAppToEnableUpdatesForFound = 'App not found. Make sure it''s included in the list of apps with blocked updates and make sure the name is spelled correctly.'
    $textNotASteamApp = 'This is not a Steam-app.'
    $textListIsActive = 'The list is active, updates for these apps are blocked.'
    $textListIsInactive = 'The list is disabled, updates for these apps are allowed.'
    $textTooManyProcessesFound = 'Too many hits found. Try spelling the process name more precisely.'
    $textTooManyWindowsFound = 'Too many hits found. Try to write the window title more precisely and make sure that no other windows (e.g. an active tab in the browser) have the same name.'
    $textSelectionPlaceholder = '     '
    $textContinue = 'Continue'
    $textCancel = 'Cancel'
    $textExit = 'Exit'
    $textAddApp = 'Add app'
    $textRemoveApp = 'Remove app'
    $textActivateList = 'Activate list'
    $textDeactivateList = 'Deactivate list'
    $textEnterOptionNumber = 'Enter the number of an option'
    $textSearchForWindowTitle = 'Search for window name'
    $textSearchForProcessName = 'Search for process name'
    $textEnterPath = 'Enter the path of the binary file'
    $textInvalidInput = 'Invalid input'
    $textProcessing = 'Processing...'
    $textDone = 'Done.'
    $textContinueQuestion = 'Continue?'
    $textYes = 'Yes'
    $textPressAnyKeyToContinue = 'Press any key to continue...'
    $textSteamIsStillOpened = 'Steam is still opened.'
    $textAlreadyAddedToBlacklist = 'Already added.'
    $textForFollowingAppsUpdatesWillBeBlocked = 'Updates will be blocked for the following app:'
    $textForFollowingAppsUpdatesWillBeAllowed = 'Updates will be enabled for the following app:'
    $textUpdatesForAllAppsOnBlacklistWillBeBlocked = 'The updates for all apps on the blocked list will be blocked. Continue?'
    $textUpdatesForAllAppsOnBlacklistWillBeAllowed = 'All apps on the blocked list will be allowed to update, but the list will not be cleared. Continue?'
    $textNowCloseAllSteamAppsAndSteam = 'Now close all Steam apps and Steam completely so that they are not displayed in the system tray either.'
    $textDoneRestartSteam = 'Complete. Restart Steam for the changes to take effect.'
    $textOpenAppAndEnterProcessName = 'Open the app (it can run in the background or foreground) and enter the name of the app process: '
    $textEnterPathInvite = 'Enter the path of the app''s executable file (including the filename extension). This can be an exe, jar or bat file, for example: '
    $textNowCloseTheAppAndSteam = 'Now close the app and Steam completely so that they are not displayed in the system tray either.'
    $textDoneListIsInactive = 'Complete. Note that these changes do not apply at this time as the list is disabled.'
    $textFollowingShortcutWasFound = 'The following shortcut was found: '
}

# Setup variables and determine paths
$appDirNameExtractionPattern = "(?<=steamapps\\common\\).+?(?=\\)"
$startMenuShortcutsDir = $env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\Steam"
$appListFile = $PSScriptRoot + "\" + "AppList.txt"
$gameDirNameExtractionPattern = "(?<=steamapps\\common\\).+?(?=\\)"
$originalResourcesDir = $PSScriptRoot + "\OriginalResources"
$listDeactivatedFile = $PSScriptRoot + "\ListDeactivated"
$modifiedResourcesDir = $PSScriptRoot + "\ModifiedResources"

function activateAppList() {
    Remove-Item $listDeactivatedFile
    # Parse config file and move files
    $appList = Get-Content $appListFile
    foreach ($line in $appList) {
        if (-not ($line -eq "dummyline")) {
            New-Item ($originalResourcesDir + "\" + (($line -split ";")[0])) -ItemType Directory
            Move-Item -Path ($startMenuShortcutsDir + "\" + (($line -split ";")[3])) -Destination ($originalResourcesDir + "\" + (($line -split ";")[0]))
            Move-Item -Path ((($line -split ";")[1]) + "\" + (($line -split ";")[2])) -Destination ($originalResourcesDir + "\" + (($line -split ";")[0]))
            Move-Item -Path ($modifiedResourcesDir + "\" + (($line -split ";")[0]) + "\" + ((((($line -split ";")[3])-split "\.")[0]) + ".lnk")) -Destination $startMenuShortcutsDir
            Remove-Item ($modifiedResourcesDir + "\" + (($line -split ";")[0]))
        }
    }
}

function deactivateAppList() {
    New-Item -ItemType File -Path $listDeactivatedFile
    # Parse config file, backup modified files and restore original files
    $appList = Get-Content $appListFile
    foreach ($line in $appList) {
        if (-not ($line -eq "dummyline")) {
            New-Item ($modifiedResourcesDir + "\" + (($line -split ";")[0])) -ItemType Directory
            Move-Item -Path ($startMenuShortcutsDir + "\" + ((((($line -split ";")[3])-split "\.")[0]) + ".lnk")) -Destination ($modifiedResourcesDir + "\" + (($line -split ";")[0]))
            Move-Item -Path ($originalResourcesDir + "\" + (($line -split ";")[0]) + "\" + (($line -split ";")[2])) -Destination (($line -split ";")[1])
            Move-Item -Path ($originalResourcesDir + "\" + (($line -split ";")[0]) + "\" + (($line -split ";")[3])) -Destination $startMenuShortcutsDir
            Remove-Item ($originalResourcesDir + "\" + (($line -split ";")[0]))
        }
    }
}

function mainMenu() {
    # Clear screen and draw menu

    Clear-Host
    $textTitle
    Write-Host ""
    $textTitleLoadingConfiguration

    # Read configuration
    (Get-Content -Path $appListFile) | Where-Object { $_ -notmatch "^\s*$" } | Set-Content -Path $appListFile
    $appList = Get-Content $appListFile
    $appListToShow = @()
    foreach ($line in $appList) {
        if (-not ($line -eq "dummyline")) {
            $appListToShow += $line.Split(';')[0].Trim()
        }
    }

    Clear-Host
    $textTitle
    Write-Host ""
    $textFollowingAppsAreOnBlacklist
    foreach ($line in $appListToShow) {
        Write-Host " - " $line
    }
    Write-Host ""
    if ((Test-Path $listDeactivatedFile -PathType Any) -eq $true)
    {
	    Write-Host $textListIsInactive
    }
    else
    {
	    Write-Host $textListIsActive
    } 
    Write-Host ""
    Write-Host $textFootnotesTitle
    Write-Host $textFootnotes
    if ((Test-Path $listDeactivatedFile -PathType Any) -eq $false)
    {
	    Write-Host ""
        Write-Host "[1] " $textAddApp $textSelectionPlaceholder "[2] " $textRemoveApp $textSelectionPlaceholder "[3] " $textDeactivateList $textSelectionPlaceholder "[4] " $textExit
    }
    else
    {
	    Write-Host ""
        Write-Host "[1] " $textAddApp $textSelectionPlaceholder "[2] " $textRemoveApp $textSelectionPlaceholder "[3] " $textActivateList $textSelectionPlaceholder "[4] " $textExit
    }

    # Wait for user input

    $option = Read-Host $textEnterOptionNumber

    switch ($option) {
        "1" {
            # Add an application to the menu
            addAppMenu
        }
        "2" {
            # Remove an application from the menu
            removeAppMenu
        }
        "3" {
            # Activate or deactivate the update lock
            if ((Test-Path $listDeactivatedFile -PathType Any) -eq $true)
            {
	            Write-Host $textUpdatesForAllAppsOnBlacklistWillBeBlocked
                Write-Host ""
                Write-Host "[1] " $textContinue $textSelectionPlaceholder "[2] " $textCancel
                $option = Read-Host $textEnterOptionNumber
                switch ($option) {
                    "1" {
                        Write-Host $textNowCloseAllSteamAppsAndSteam
                        Write-Host ""
                        Write-Host "[1] " $textContinue $textSelectionPlaceholder "[2] " $textCancel
                        $option = Read-Host $textEnterOptionNumber
                        switch ($option) {
                            "1" {
                                while ($true) {
                                    # Check if Steam is opened. Steam will restore the file if it will be changed while Steam is opened, therefore it is necessary that Steam is closed.
                                    $SteamProcess = $null
                                    $SteamProcess = Get-Process | Where-Object { $_.ProcessName -like "*steam*" } | Select-Object -ExpandProperty Path
                                    if ($SteamProcess -eq $null) {
                                        # Exit loop and call activateAppList
                                        break
                                    } else {
                                        Write-Host $textSteamIsStillOpened
                                        Write-Host $textNowCloseAllSteamAppsAndSteam
                                        Write-Host ""
                                        Write-Host "[1] " $textContinue $textSelectionPlaceholder "[2] " $textCancel
                                        $option = Read-Host $textEnterOptionNumber
                                        switch ($option) {
                                            "1" {
                                            
                                            }
                                            "2" {
                                                mainMenu
                                            }
                                            default {
                                                Write-Host $textInvalidInput
                                                Start-Sleep -s 3
                                                mainMenu
                                            }
                                        }
                                    } 
                                }
                            }
                            "2" {
                                mainMenu
                            }
                            default {
                                Write-Host $textInvalidInput
                                Start-Sleep -s 3
                                mainMenu
                            }
                        }

                        activateAppList
	                    Write-Host $textDone
                        Start-Sleep -s 3
                        mainMenu
                    }
                    "2" {
                        mainMenu
                    }
                    default {
                        Write-Host $textInvalidInput
                        Start-Sleep -s 3
                        mainMenu
                    }
                }
            }
            else
            {
	            Write-Host $textUpdatesForAllAppsOnBlacklistWillBeAllowed
                Write-Host ""
                Write-Host "[1] " $textContinue $textSelectionPlaceholder "[2] " $textCancel
                $option = Read-Host $textEnterOptionNumber
                switch ($option) {
                    "1" {
                        deactivateAppList
	                    Write-Host $textDoneRestartSteam 
                        Write-Host ""
                        Write-Host $textPressAnyKeyToContinue
                        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                        mainMenu
                    }
                    "2" {
                        mainMenu
                    }
                    default {
                        Write-Host $textInvalidInput
                        Start-Sleep -s 3
                        mainMenu
                    }
                }
            }
            
        }
        "4" {
            Clear-Host
            exit
        }
        default {
            Write-Host $textInvalidInput
            Start-Sleep -s 3
            mainMenu
        }
    }
}

function addAppMenu() {
    $triedToFindAppShortcutManually = $false
    $triedToFindAppShortcutAutomatically = $false
    $appList = Get-Content $appListFile
    $appShortcutFile = ""

    # The path to the binary file is not saved anywhere in Steam files and will be resolved internally in Steam (at least i found no such record). And this introduce problems.
    # There are 3 methods of adding of a Steam app: by searching for it based on window title, by searching for it based on process name and by entering the binary path.
    # Methods with searching works in most cases, but not always. For example, the app process could be started from a launcher. In this case, starting the binary that
    # is currently running will not work, as it will be only correctly started when starting from launcher. Or, if it is a mod for a game - it could do some preparations and
    # then start the game binary. In this case, starting the game binary directly will as well result into incorrect behaviour or start will fail. If the search method will
    # not work - the user will have to enter the binary file path by itself.

    Clear-Host
    $textTitle
    Write-Host ""
    Write-Host "[1] " $textSearchForWindowTitle $textSelectionPlaceholder "[2] " $textSearchForProcessName $textSelectionPlaceholder "[3] " $textEnterPath $textSelectionPlaceholder "[4] " $textCancel
    # Wait for user input

    $option = Read-Host $textEnterOptionNumber

    switch ($option) {
        "1" {
            # Search for window title
            $textEnterAppNameToDisableUpdates
            $userEnteredAppName = Read-Host
            $appFile = Get-Process | Where-Object {$_.MainWindowTitle -like "*$userEnteredAppName*"} | Select -ExpandProperty Path
            if ($appFile -is [System.Collections.IEnumerable] -and $appFile.Count -gt 1) {
                Write-Host $textTooManyWindowsFound
                Write-Host ""
                Write-Host $textPressAnyKeyToContinue
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                mainMenu
            }
        }
        "2" {
            # Search for process name
            Write-Host $textOpenAppAndEnterProcessName
            $userEnteredProcessName = Read-Host
            $appFile = Get-Process | Where-Object {$_.ProcessName -like "*$userEnteredProcessName*"} | Select-Object -ExpandProperty Path
            if ($appFile -is [System.Collections.IEnumerable] -and $appFile.Count -gt 1) {
                Write-Host $textTooManyProcessesFound
                Write-Host ""
                Write-Host $textPressAnyKeyToContinue
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                mainMenu
            }
        }
        "3" {
            # Enter binary path
            Write-Host $textEnterPathInvite
            $appFile = Read-Host
        }
        "4" {
            mainMenu
        }
        default {
            Write-Host $textInvalidInput
            Start-Sleep -s 3
            mainMenu
        }
    }
    if (($appFile -eq $null) -or ((Test-Path $appFile -PathType Any) -eq $false))
    {
        Write-Host $textNoAppFound
        Write-Host ""
        Write-Host $textPressAnyKeyToContinue
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        mainMenu
    }
    if (-not ($appFile -like '*steamapps*')) {
        Write-Host $textNotASteamApp
        Write-Host ""
        Write-Host $textPressAnyKeyToContinue
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        mainMenu
    }
    $SteamLibraryWithAppInstalledPath = $appFile.Substring(0, $appFile.IndexOf('steamapps')) + 'steamapps'
    $appDirName = $appFile | Select-String -Pattern $appDirNameExtractionPattern -AllMatches | ForEach-Object { $_.Matches.Value }
    # Search for Steam manifest file of the app
    Get-ChildItem -Path $SteamLibraryWithAppInstalledPath -Filter "*.acf" | ForEach-Object {
        $filePath = $_.FullName
        $fileContent = Get-Content -Path $filePath -Raw

        if ($fileContent -match $appDirName) {
            $appManifestFile = $filePath
            $appManifestFileName = $_.Name
        }
    }
    if ($appList -like "*$appDirName*") {
        Write-Host $textAlreadyAddedToBlacklist
        Start-Sleep -s 3
        mainMenu
    }

    # Clear screen, display app information and ask for confirmation
    Clear-Host
    $textTitle
    Write-Host ""
    Write-Host $textForFollowingAppsUpdatesWillBeBlocked
    Write-Host " - Name: "$appDirName
    Write-Host " - Installationspfad: "$SteamLibraryWithAppInstalledPath"\"$appDirName
    Write-Host " - Steam app ID: "(($appManifestFileName -replace "appmanifest_", "") -replace ".acf", "")
    Write-Host ""
    Write-Host $textContinueQuestion
    Write-Host "[1] " $textYes $textSelectionPlaceholder "[2] " $textCancel
    $option = Read-Host $textEnterOptionNumber
        switch ($option) {
        "1" {
            Write-Host $textProcessing

            while ($true)
            {
                # Try to find app shortcut automatically first. App shortcut can be called differently as the app directory therefore it will be tried to search first based on the app directory name.
                # If it fails - it will be tried to search based on user-entered process or app name. If it fails as well - the user will be asked to enter the name manually.
                if ($appShortcutFile -eq "")
                {
                    if ($triedToFindAppShortcutAutomatically -eq $false)
                    {
                        Get-ChildItem -Path $startMenuShortcutsDir -Filter "*$appDirName*" | ForEach-Object {
                            $filePath = $_.FullName
                            $fileContent = Get-Content -Path $filePath -Raw
                            $appShortcutFile = $filePath
                            $appShortcutFileName = $_.Name
                        }

                        if ($appShortcutFile -eq "")
                        {
                            Get-ChildItem -Path $startMenuShortcutsDir -Filter "*$userEnteredAppName*" | ForEach-Object {
                                $filePath = $_.FullName
                                $fileContent = Get-Content -Path $filePath -Raw
                                $appShortcutFile = $filePath
                                $appShortcutFileName = $_.Name
                            }
                        }

                        $triedToFindAppShortcutAutomatically = $true
                    }
                    else
                    {
                        if ($triedToFindAppShortcutManually -eq $false)
                        {
                            Write-Host $textEnterAppShortcutName
                            $userEnteredShortcutName = Read-Host

                            Get-ChildItem -Path $startMenuShortcutsDir -Filter "*$userEnteredShortcutName*" | ForEach-Object {
                                $filePath = $_.FullName
                                $fileContent = Get-Content -Path $filePath -Raw
                                $appShortcutFile = $filePath
                                $appShortcutFileName = $_.Name
                            }
                            $triedToFindAppShortcutManually = $true
                        }
                        else
                        {
                            Write-Host $textNoShortcutFound
                            Write-Host ""
                            Write-Host $textPressAnyKeyToContinue
                            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                            mainMenu
                        }
                    }
                }
                else
                {
                    if ($triedToFindAppShortcutAutomatically -eq $true -and $triedToFindAppShortcutManually -eq $true) {
                        Write-Host $textFollowingShortcutWasFound
                        Write-Host $appShortcutFile
                        Write-Host $textContinueQuestion
                        Write-Host "[1] " $textYes $textSelectionPlaceholder "[2] " $textCancel
                        $option = Read-Host $textEnterOptionNumber
                        switch ($option) {
                            "1" {
                            
                            }
                            "2" {
                                mainMenu
                            }
                            default {
                                Write-Host $textInvalidInput
                                Start-Sleep -s 3
                                mainMenu
                            }
                        }
                    }
                    Write-Host $textNowCloseTheAppAndSteam
                    Write-Host ""
                    Write-Host "[1] " $textContinue $textSelectionPlaceholder "[2] " $textCancel
                    $option = Read-Host $textEnterOptionNumber
                    switch ($option) {
                        "1" {
                            while ($true) {
                                # Check if Steam is opened. Steam will restore the file if it will be changed while Steam is opened, therefore it is necessary that Steam is closed.
                                $SteamProcess = $null
                                $SteamProcess = Get-Process | Where-Object { $_.ProcessName -like "*steam*" } | Select-Object -ExpandProperty Path
                                if ($SteamProcess -eq $null) {
                                    break
                                } else {
                                    Write-Host $textSteamIsStillOpened
                                    Write-Host $textNowCloseTheAppAndSteam
                                    Write-Host ""
                                    Write-Host "[1] " $textContinue $textSelectionPlaceholder "[2] " $textCancel
                                    $option = Read-Host $textEnterOptionNumber
                                    switch ($option) {
                                        "1" {
                                            
                                        }
                                        "2" {
                                            mainMenu
                                        }
                                        default {
                                            Write-Host $textInvalidInput
                                            Start-Sleep -s 3
                                            mainMenu
                                        }
                                    }
                                } 
                            }
                        }
                        "2" {
                            mainMenu
                        }
                        default {
                            Write-Host $textInvalidInput
                            Start-Sleep -s 3
                            mainMenu
                        }
                    }

                    # Write a record about the app that is blocked from update into the config file, the manifest file name and shortcut name. As well, generate a modified shortcut for direct start.
                    # Finally, move the files depending on whether the list is currently enabled or disabled.
                    Add-Content -Path $appListFile -Value ($appDirName + ";" + $SteamLibraryWithAppInstalledPath + ";" + $appManifestFileName + ";" + $appShortcutFileName + ";")
                    if ((Test-Path $listDeactivatedFile -PathType Any) -eq $true)
                    {
                        New-Item ($modifiedResourcesDir + "\" + $appDirName) -ItemType Directory
                        $WshShell = New-Object -comObject WScript.Shell
                        $Shortcut = $WshShell.CreateShortcut($modifiedResourcesDir + "\" + $appDirName + "\" + (($appShortcutFileName-split "\.")[0]) + ".lnk")
                        $Shortcut.TargetPath = $appFile
                        $shortcut.WorkingDirectory = ($SteamLibraryWithAppInstalledPath + "\common\" + $appDirName)
                        $Shortcut.Save()
	                    Write-Host $textDoneListIsInactive
                        Write-Host ""
                        Write-Host $textPressAnyKeyToContinue
                        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                        break
                    }
                    else
                    {
                        New-Item ($originalResourcesDir + "\" + $appDirName) -ItemType Directory
                        Move-Item -Path $appManifestFile -Destination ($originalResourcesDir + "\" + $appDirName)
                        Move-Item -Path $appShortcutFile -Destination ($originalResourcesDir + "\" + $appDirName)
                        $WshShell = New-Object -comObject WScript.Shell
                        $Shortcut = $WshShell.CreateShortcut((($appShortcutFile-split "\.")[0]) + ".lnk")
                        $Shortcut.TargetPath = $appFile
                        $shortcut.WorkingDirectory = ($SteamLibraryWithAppInstalledPath + "\common\" + $appDirName)
                        $Shortcut.Save()

                        
	                    Write-Host $textDone
                        Start-Sleep -s 3
                        break
                    }
                }
            }
            mainMenu
        }
        "2" {
            mainMenu
        }
        default {
            Write-Host $textInvalidInput
            Start-Sleep -s 3
            mainMenu
        }
    }
}

function removeAppMenu() {
    Write-Host ""
    $textEnterAppNameToEnableUpdates
    $userEnteredAppName = Read-Host
    $appList = Get-Content $appListFile
    $matchAlreadyFound1 = $false

    foreach ($line in $appList)
    {
        if ($matchAlreadyFound1 -eq $false) {
            if ($line -like "*$userEnteredAppName*") {
                $matchAlreadyFound1 = $true
                # Clear screen, display app information and ask for confirmation
                Clear-Host
                $textTitle
                Write-Host ""
                Write-Host $textForFollowingAppsUpdatesWillBeAllowed
                Write-Host " - Name: "($line.Split(';')[0].Trim())
                Write-Host " - Installationspfad: "(((($line -split ";")[1]) + "\" + (($line -split ";")[0])) -replace " \\ ", "\\")
                Write-Host " - Steam app ID: "(((($line -split ';')[2])-replace "appmanifest_", "") -replace ".acf", "")
                Write-Host ""
                Write-Host $textContinueQuestion
                Write-Host "[1] " $textYes $textSelectionPlaceholder "[2] " $textCancel
                $option = Read-Host $textEnterOptionNumber
                    switch ($option) {
                    "1" {
                        Write-Host $textProcessing
                        
                        # Preapare the new array with blocked apps
                        $newAppList = @()
                        $matchAlreadyFound2 = $false
                        foreach ($line in $appList) {
                            if ($matchAlreadyFound2 -eq $false) {
                                if (-not ($line -like "*$userEnteredAppName*")) {
                                    $newAppList += $line
                                } else {
                                    $matchAlreadyFound2 = $true
                                }
                            } else {
                                $newAppList += $line
                            }
                        }
                        # Write the new list ob blocked apps into the config
                        Set-Content -Path $appListFile -Value $newAppList

                        # Restore original files
                        if ((Test-Path $listDeactivatedFile -PathType Any) -eq $true)
                        {
                            Remove-Item ($modifiedResourcesDir + "\" + (($line -split ";")[0])) -Recurse -Force
	                        Write-Host $textDone
                            Start-Sleep -s 3
                            mainMenu
                        }
                        else
                        {
                            $matchAlreadyFound3 = $false
                            if ($matchAlreadyFound3 -eq $false) {
                                foreach ($line in $appList) {
                                    if ($line -like "*$userEnteredAppName*") {
                                        $matchAlreadyFound3 = $true
                                        Remove-Item ($startMenuShortcutsDir + "\" + ((((($line -split ";")[3])-split "\.")[0]) + ".lnk"))
                                        Move-Item -Path ($originalResourcesDir + "\" + (($line -split ";")[0]) + "\" + (($line -split ";")[2])) -Destination (($line -split ";")[1])
                                        Move-Item -Path ($originalResourcesDir + "\" + (($line -split ";")[0]) + "\" + (($line -split ";")[3])) -Destination $startMenuShortcutsDir
                                        Remove-Item ($originalResourcesDir + "\" + (($line -split ";")[0]))
                                    }
                                }
                            }

	                        Write-Host $textDoneRestartSteam 
                            Write-Host ""
                            Write-Host $textPressAnyKeyToContinue
                            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
                            mainMenu
                        }
                    }
                    "2" {
                        mainMenu
                    }
                    default {
                        Write-Host $textInvalidInput
                        Start-Sleep -s 3
                        mainMenu
                    }
                }
            }
        }
    }

    Write-Host $textNoAppToEnableUpdatesForFound
    Write-Host ""
    Write-Host $textPressAnyKeyToContinue
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    mainMenu
}

# Start main loop
mainMenu