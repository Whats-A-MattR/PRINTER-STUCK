@rem ----[ Detect Admin Permissions ]
@echo off 

goto checkPermissions

:deleteQueue
    ECHO Removing Queued Print Files (YOU WILL NEED TO RESTART ANY JOBS YOU WERE WAITING ON)
    DEL C:\WINDOWS\system32\spool\PRINTERS\*.* /F /Q
    timeout 3 > nul
    ECHO Restarting Print Spooler Service
    NET STOP spooler && NET START spooler
    ECHO The script will now close on it's own
    timeout 3 > nul 
    EXIT /B

:checkPermissions
    NET SESSION >nul 2>&1 
    IF %ERRORLEVEL% == 0 (
        ECHO Administrator Privileges Detected
        timeout 1 > nul
        goto deleteQueue
        PAUSE
    ) ELSE (
       echo ######## ########  ########   #######  ########  
       echo ##       ##     ## ##     ## ##     ## ##     ## 
       echo ##       ##     ## ##     ## ##     ## ##     ## 
       echo ######   ########  ########  ##     ## ########  
       echo ##       ##   ##   ##   ##   ##     ## ##   ##   
       echo ##       ##    ##  ##    ##  ##     ## ##    ##  
       echo ######## ##     ## ##     ##  #######  ##     ## 
       echo.
       echo.
       echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
       echo This script must be run as administrator to work properly!  
       echo If you're seeing this after double clicking the script, try right clicking on the script and select "Run As Administrator".
       echo ##########################################################
       echo.
       echo.
       echo. 
       echo Press Any Key to Close.....
       PAUSE > nul 
    )

