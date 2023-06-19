@echo off
setlocal

REM Script: remove_bin_obj.bat
REM Description: This script removes the 'bin' and 'obj' folders from a specified directory and its subdirectories.
REM Author: Anton Kalis
REM Disclaimer: This script is provided as-is, without any warranty or guarantee. Use it at your own risk.

REM Check if the start directory parameter is provided
IF "%~1"=="" (
    echo Please provide the start directory.
    exit /b 1
)

REM Set the start directory from the command-line parameter
set "start_directory=%~1"

REM Function to remove bin and obj folders
:remove_bin_obj
    setlocal
    set "dir=%~1"
    if exist "%dir%\*.*" (
        echo Removing bin and obj folders from %dir%
        for /d /r "%dir%" %%d in (bin obj) do (
            if exist "%%d" (
                echo Removing %%d
                rd /s /q "%%d"
            )
        )
    ) else (
        echo Directory %dir% does not exist.
    )
    endlocal
    exit /b

REM Call the function to remove bin and obj folders in the start directory
call :remove_bin_obj "%start_directory%"

REM Iterate through subdirectories
for /r "%start_directory%" /d %%s in (*) do (
    call :remove_bin_obj "%%s"
)

endlocal
