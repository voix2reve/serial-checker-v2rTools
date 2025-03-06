@echo off
chcp 65001
title V2R Tools - Serial Checker
mode con: cols=110 lines= 40


rem made by vie2reve (v2r)
cls
echo.
echo.[32m
echo    ██╗   ██╗██████╗ ██████╗     ████████╗ ██████╗  ██████╗ ██╗     ███████╗ 
echo    ██║   ██║╚════██╗██╔══██╗    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝
echo    ██║   ██║ █████╔╝██████╔╝       ██║   ██║   ██║██║   ██║██║     ███████╗
echo    ╚██╗ ██╔╝██╔═══╝ ██╔══██╗       ██║   ██║   ██║██║   ██║██║     ╚════██║
echo     ╚████╔╝ ███████╗██║  ██║       ██║   ╚██████╔╝╚██████╔╝███████╗███████║
echo      ╚═══╝  ╚══════╝╚═╝  ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
echo.
echo    ███████╗███████╗██████╗ ██╗ █████╗ ██╗          ██████╗██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗
echo    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗██║         ██╔════╝██║  ██║██╔════╝██╔════╝██║ ██╔╝██╔════╝██╔══██╗
echo    ███████╗█████╗  ██████╔╝██║███████║██║         ██║     ███████║█████╗  ██║     █████╔╝ █████╗  ██████╔╝
echo    ╚════██║██╔══╝  ██╔══██╗██║██╔══██║██║         ██║     ██╔══██║██╔══╝  ██║     ██╔═██╗ ██╔══╝  ██╔══██╗
echo    ███████║███████╗██║  ██║██║██║  ██║███████╗    ╚██████╗██║  ██║███████╗╚██████╗██║  ██╗███████╗██║  ██║
echo    ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝     ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
echo    [!]-github.com/vie2reve
echo.[97m




echo ============ MAIN MENU ============
echo 1. Check Serials
echo 2. Fix wmic error
echo 3. Exit
set /p option= [+] Choose an option (1/2/3): 

if "%option%"=="1" goto CheckSerials
if "%option%"=="2" goto InstallWmic
if "%option%"=="3" exit
goto MainMenu

:InstallWmic
cls
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
exit


:CheckSerials
cls
echo [93m=========== [+] DISK ==================[97m
for /f "tokens=*" %%A in ('wmic diskdrive get serialnumber ^| findstr /r /v "^$"') do echo %%A
echo.
echo [93m=========== [+] MOTHERBOARD ===========[97m
for /f "tokens=*" %%A in ('wmic baseboard get serialnumber ^| findstr /r /v "^$"') do echo %%A
echo.
echo [93m=========== [+] SMBios ================[97m
for /f "tokens=*" %%A in ('wmic path win32_computersystemproduct get uuid ^| findstr /r /v "^$"') do echo %%A
echo.
echo [93m=========== [+] GPU ===================[97m
for /f "tokens=*" %%A in ('wmic path Win32_VideoController get Description ^| findstr /r /v "^$"') do echo %%A
echo.

echo -------------------------------------
for /f "tokens=*" %%A in ('wmic memorychip get serialnumber ^| findstr /r /v "^$"') do echo %%A
echo.
echo [93m=========== [+] BIOS ===================[97m
for /f "tokens=*" %%A in ('wmic csproduct get uuid ^| findstr /r /v "^$"') do echo %%A
echo.
echo [93m=========== [+] CPU ====================[97m
for /f "tokens=*" %%A in ('wmic cpu get processorid ^| findstr /r /v "^$"') do echo %%A
echo.
echo [93m=========== [+] MAC ADDRESS ============[97m
for /f "tokens=*" %%A in ('wmic path Win32_NetworkAdapter where "PNPDeviceID like '%%PCI%%' AND NetConnectionStatus=2 AND AdapterTypeID='0'" get MacAddress ^| findstr /r /v "^$"') do echo %%A
echo.


echo.
echo 1. Save serials
echo 2. Exit
set /p option=[+] Choose an option (1/2): 

if "%option%"=="1" goto SaveSerials
if "%option%"=="2" exit
goto CheckSerials

rem Function to save serial numbers with the date
:SaveSerials
cls
setlocal


set date=%date%
set time=%time%
set datetime=%date%_%time%


set datetime=%datetime:/=-%
set datetime=%datetime::=-%


set filepath=%~dp0serials_%datetime%.txt


echo ===========  [+] DISK ==================  > "%filepath%"
for /f "tokens=*" %%A in ('wmic diskdrive get serialnumber ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"
echo. >> "%filepath%"
echo ===========  [+] MOTHERBOARD ===========  >> "%filepath%"
for /f "tokens=*" %%A in ('wmic baseboard get serialnumber ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"
echo. >> "%filepath%"
echo ===========  [+] SMBios ================  >> "%filepath%"
for /f "tokens=*" %%A in ('wmic path win32_computersystemproduct get uuid ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"
echo. >> "%filepath%"
echo ===========  [+] GPU ===================  >> "%filepath%"
for /f "tokens=*" %%A in ('wmic path Win32_VideoController get Description ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"
echo. >> "%filepath%"
echo ===========  [+] RAM ===================  >> "%filepath%"
for /f "tokens=*" %%A in ('wmic memorychip get serialnumber ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"
echo. >> "%filepath%"
echo ===========  [+] BIOS ==================  >> "%filepath%"
for /f "tokens=*" %%A in ('wmic csproduct get uuid ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"
echo. >> "%filepath%"
echo ===========  [+] CPU ===================  >> "%filepath%"
for /f "tokens=*" %%A in ('wmic cpu get processorid ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"
echo. >> "%filepath%"
echo ===========  [+] MAC ADDRESS ===========  >> "%filepath%"
for /f "tokens=*" %%A in ('wmic path Win32_NetworkAdapter where "PNPDeviceID like '%%PCI%%' AND NetConnectionStatus=2 AND AdapterTypeID='0'" get MacAddress ^| findstr /r /v "^$"') do echo %%A >> "%filepath%"

echo Serial numbers have been saved in a .txt file in the same directory as the script.
timeout /t 5 /nobreak >nul
goto CheckSerials

rem made by vie2reve (v2r)
