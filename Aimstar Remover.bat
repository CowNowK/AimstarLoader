@echo off
:: by CowNow
:: You still need to delete the AimStar program yourself

net session >nul 2>&1 && (
    goto MAIN
) || (
    echo Please running as admministrator!
    echo.
    echo Press any key to continue...
    pause > nul
    exit
)

:MAIN
cls
echo What do you want to remove?
echo [1] Delete AimStar Caches
echo [2] Delete AimStar Config
echo [3] Clear Traces
echo [4] Exit
echo [5] Exit and Reboot
set /p INPUT="Please enter a number (1-5): "

if "%INPUT%" == "1" (
    goto DELCACHE
) else if "%INPUT%" == "2" (
    goto DELCFG
) else if "%INPUT%" == "3" (
    goto DELRECNT
) else if "%INPUT%" == "4" (
    goto END
) else if "%INPUT%" == "5" (
    goto CLR
) else (
    cls
    goto MAIN
)

:DELCACHE
cls
if exist "%TEMP%\ASL" (
    rmdir /s /q "%TEMP%\ASL"
    echo AimStar cache folder deleted successfully.
) else (
    echo Could not find AimStar cache folder.
)
if exist "%TEMP%\Aimstar" (
    del /f /q "%TEMP%\Aimstar"
    echo Aimstar verify cache deleted successfully.
) else (
    echo Could not find AimStar verify cache.
)
echo.
echo Press any key to continue..
pause > nul
goto MAIN

:DELCFG
cls
for /f "tokens=2*" %%a in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Personal') do set "mydocuments=%%~b"
if exist "%mydocuments%\AimStar" (
    echo Folder found: %mydocuments%\AimStar
    rmdir /s /q "%mydocuments%\AimStar"
    echo AimStar config folder deleted successfully.
) else (
    echo Could not find AimStar config folder.
)
echo.
echo Press any key to continue..
pause > nul
goto MAIN

:DELRECNT
for /R "%APPDATA%\Microsoft\Windows\Recent" %%G in (*) do (
    del /f /q "%%G"
    echo Recent traces cleared
)
echo.
echo Press any key to continue..
pause > nul
goto MAIN

:CLR
shutdown /r /t 3
del %0
goto END

:END
exit
