REM # Sahitha Nelanga De Silva (C) 2016

@ECHO OFF
title Wifi Hotspot Manager - Sahitha Nelanga
color 4

:head
ECHO [                                                           ]
ECHO [            Date: %date%     Time: %TIME%         ]
ECHO [                                                           ]
ECHO [ --------------------------------------------------------- ]
ECHO [                                                           ]
ECHO [                   Wifi Hotspot Manager                    ]
ECHO [                Sahitha Nelanga De Silva                   ]
ECHO [                                                           ]
ECHO [ --------------------------------------------------------- ]
call:home

:home
ECHO.
ECHO ********************************************
ECHO.
ECHO		1- On
ECHO		2- Off
ECHO		3- Show connected user MAC addresses
ECHO		4- View Password
ECHO		5- Change Password
ECHO		6- Create New Hotspot
ECHO		T- Test Hotspot Compatibility [New Users Only!]
ECHO		X- Exit
ECHO.
ECHO.
set input=
set /p input=Enter Selection: 
ECHO.
ECHO ********************************************
ECHO initializing command...
timeout /t 1 >nul
IF %input%==1 (goto:activate)
IF %input%==2 (goto:deactivate)
IF %input%==3 (goto:show)
IF %input%==4 (goto:key)
IF %input%==5 (goto:refresh)
IF %input%==6 (goto:create)
IF %input%==t (goto:test)
IF %input%==x (
	taskkill /im cmd.exe /f 
) ELSE (
	ECHO.
	ECHO Invalid input!!! Please try again.
)
call:home

:activate
ECHO.
ECHO =======================
ECHO.
netsh wlan start hostednetwork
ECHO =======================
call:home

:deactivate
ECHO.
ECHO =======================
ECHO.
netsh wlan stop hostednetwork
ECHO =======================
call:home

:show
ECHO.
ECHO =======================
ECHO.
netsh wlan show hostednetwork
ECHO =======================
call:home

:key
ECHO.
ECHO =======================
ECHO.
netsh wlan show hostednetwork setting=security
ECHO =======================
call:home

:refresh
ECHO.
ECHO =======================
ECHO.
set /p key="Please enter the new password: "
netsh netsh wlan refresh hostednetwork %key%
ECHO =======================
call:home

:test
ECHO.
ECHO =======================
ECHO ---------- Creating a temporary text file on desktop named "temp.txt".
ECHO.
netsh wlan show drivers > "%systemdrive%\Users\%username%\Desktop\temp.txt"
find /i "hosted" "%systemdrive%\Users\%username%\Desktop\temp.txt" 
DEL "%systemdrive%\Users\%username%\Desktop\temp.txt"
ECHO.
ECHO If "YES" your device is compatible!. If "NO" Sorry! Your device is not compatible.
ECHO.
ECHO ---------- "temp.txt" Delete complete.
ECHO =======================
PAUSE
call:head
call:home

:create
ECHO [=======================================]
ECHO [        Create WiFi Hotspot            ]
ECHO [=======================================]
ECHO.
set /p name="Please enter the Hotspot name(SSID): "
ECHO.
set /p key="Please enter the Hotspot key: 
ECHO.
ECHO ======================
ECHO %name%
ECHO %key%
ECHO ======================
PAUSE
netsh wlan set hostednetwork mode=allow ssid=%name% key=%key%
CLS
call:home
