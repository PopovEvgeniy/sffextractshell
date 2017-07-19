[Setup]
AppName=SFFEXTRACT SHELL
AppVersion=2.5.8
AppPublisher=Tuzik
AppPublisherURL=http://tuzik87.ru54.com/
AppSupportURL=http://tuzik87.ru54.com/
AppUpdatesURL=http://tuzik87.ru54.com/
DefaultDirName={pf}\SFFEXTRACT SHELL
DefaultGroupName=SFFEXTRACT SHELL
DisableProgramGroupPage=true
OutputDir=C:\SFFEXTRACT SHELL
OutputBaseFilename=sffsetup
Compression=lzma
SolidCompression=true
InternalCompressLevel=ultra64
RestartIfNeededByRun=false
PrivilegesRequired=none
AllowCancelDuringInstall=false
UsePreviousAppDir=false
UsePreviousGroup=false
DisableStartupPrompt=true
DisableReadyMemo=true
DisableReadyPage=true
UsePreviousSetupType=false
UsePreviousTasks=false
MinVersion=4.1.1998,5.0.2195
LicenseFile=C:\SFFEXTRACT SHELL\Version 2.5.8\deploy\copying.txt
ShowLanguageDialog=no
Uninstallable=IsTaskSelected('typical')

[Types]
Name: normal; Description: Typical install; Flags: iscustom

[Components]
Name: main; Description: Main component; Flags: fixed; Types: normal
Name: source; Description: Source code

[Tasks]
Name: typical; Description: Normal install; Flags: exclusive
Name: portable; Description: Install to portable media; Flags: exclusive unchecked

[Files]
Source: C:\SFFEXTRACT SHELL\Version 2.5.8\deploy\copying.txt; DestDir: {app}
Source: C:\SFFEXTRACT SHELL\Version 2.5.8\deploy\readme.txt; DestDir: {app}
Source: C:\SFFEXTRACT SHELL\Version 2.5.8\deploy\sffshell.exe; DestDir: {app}
Source: C:\SFFEXTRACT SHELL\Version 2.5.8\deploy\source.zip; DestDir: {app}; Components: source

[Icons]
Name: {group}\Documentation\Help; Filename: {app}\readme.txt; Flags: runmaximized; Tasks: typical
Name: {group}\Documentation\License; Filename: {app}\copying.txt; Flags: runmaximized; Tasks: typical
Name: {group}\SFFEXTRACT SHELL; Filename: {app}\sffshell.exe; Tasks: typical
Name: {group}\Source code; Filename: {app}\source.zip; Components: source; Tasks: typical
Name: {group}\Unistall SFFEXTRACT SHELL; Filename: {app}\unins000.exe; Tasks: typical
