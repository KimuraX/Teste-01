@echo off

REM Feito pelo Balaclava; intuitos educacionais
REM Código pra executar como administrador.

:init
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"

if '%cmdInvoke%'=='1' goto InvokeCmd 

ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation

:InvokeCmd
ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

ECHO %batchName% Arguments:

REM Código do cleaner.
REM Menu.

cls
:termos
cls

color 04
title balaclava#1912

echo   Bem vindo ao cleaner, %username%!

echo.

echo   Limpar o navegador vai resultar na exclusao de todos os dados, incluindo senhas e extensoes.

echo.

pause

cls
:menu
cls


echo.

echo     Cleaner

echo.

echo        1. Limpeza completa (escolha o navegador)
echo        2. Limpeza completa (limpar os dois navegadores)
echo        3. Arquivos temporarios sem limpar navegador.
echo        4. Rede
echo        5. Sair

echo.

set /p opcao= Digite apenas uma tarefa por vez e aguarde o processo:
echo ------------------------------
if %opcao% equ 1 goto opcao1
if %opcao% equ 2 goto opcao2
if %opcao% equ 3 goto opcao3
if %opcao% equ 4 goto opcao4
if %opcao% equ 5 goto opcao5

pause

REM Limpeza completa (escolha o navegador)

:opcao1
cls

echo.

echo     Cleaner

echo.

echo        1. Limpeza completa (apagar dados do Chrome)
echo        2. Limpeza completa (apagar dados do Edge)
echo        3. Voltar ao menu principal

echo.

set /p opcao= Digite apenas uma tarefa por vez e aguarde o processo:
echo ------------------------------
if %opcao% equ 1 goto chromedel
if %opcao% equ 2 goto edgedel
if %opcao% equ 3 goto opcao6

REM Limpeza local completa.

:opcao2
cls

set prefetch=C:\Windows\prefetch\*.*
set temp01=C:\Users\%USERNAME%\AppData\Local\Temp\*.*
set temp02=C:\Windows\Temp\*.*
set google=C:\Users\%USERNAME%\AppData\Local\Google
set edge=C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\*.*

del /Q "%prefetch%" /S
rmdir /Q "%prefetch%" /S
del /Q "%temp01%" /S
rmdir /Q "%temp01%" /S
del /Q "%temp02%" /S
rmdir /Q "%temp02%" /S
del /Q "%google%" /S
rmdir /Q "%google%" /S
del /Q "%edge%" /S
rmdir /Q "%edge%" /S

sfc /purgecache
sfc /cachesize=50
IPCONFIG /RELEASE
IPCONFIG /FLUSHDNS
NET STOP DNSCACHE
NET STOP DHCP
NET START DNSCACHE
NET START DHCP
IPCONFIG /REGISTERDNS
IPCONFIG /RENEW
arp -a -d
netsh interface ip delete arpcache
netsh interface ip delete destinationcache
nbtstat -R
nbtstat -RR
netsh int ip reset
netsh winsock reset catalog

goto opcao1feita

REM Limpeza completa sem navegadores.

:opcao3
cls

set prefetch=C:\Windows\prefetch\*.*
set temp01=C:\Users\%USERNAME%\AppData\Local\Temp\*.*
set temp02=C:\Windows\Temp\*.*

del /Q "%prefetch%" /S
rmdir /Q "%prefetch%" /S
del /Q "%temp01%" /S
rmdir /Q "%temp01%" /S
del /Q "%temp02%" /S
rmdir /Q "%temp02%" /S

sfc /purgecache
sfc /cachesize=50
IPCONFIG /RELEASE
IPCONFIG /FLUSHDNS
NET STOP DNSCACHE
NET STOP DHCP
NET START DNSCACHE
NET START DHCP
IPCONFIG /REGISTERDNS
IPCONFIG /RENEW
arp -a -d
netsh interface ip delete arpcache
netsh interface ip delete destinationcache
nbtstat -R
nbtstat -RR
netsh int ip reset
netsh winsock reset catalog

goto opcao1feita

REM Limpar apenas a rede.

:opcao4
cls

sfc /purgecache
sfc /cachesize=50
IPCONFIG /RELEASE
IPCONFIG /FLUSHDNS
NET STOP DNSCACHE
NET STOP DHCP
NET START DNSCACHE
NET START DHCP
IPCONFIG /REGISTERDNS
IPCONFIG /RENEW
arp -a -d
netsh interface ip delete arpcache
netsh interface ip delete destinationcache
nbtstat -R
nbtstat -RR
netsh int ip reset
netsh winsock reset catalog

goto opcao1feita

REM Limpeza completa, apenas o Chrome.

:chromedel
cls

set prefetch=C:\Windows\prefetch\*.*
set temp01=C:\Users\%USERNAME%\AppData\Local\Temp\*.*
set temp02=C:\Windows\Temp\*.*
set google=C:\Users\%USERNAME%\AppData\Local\Google

del /Q "%prefetch%" /S
rmdir /Q "%prefetch%" /S
del /Q "%temp01%" /S
rmdir /Q "%temp01%" /S
del /Q "%temp02%" /S
rmdir /Q "%temp02%" /S
del /Q "%google%" /S
rmdir /Q "%google%" /S

sfc /purgecache
sfc /cachesize=50
IPCONFIG /RELEASE
IPCONFIG /FLUSHDNS
NET STOP DNSCACHE
NET STOP DHCP
NET START DNSCACHE
NET START DHCP
IPCONFIG /REGISTERDNS
IPCONFIG /RENEW
arp -a -d
netsh interface ip delete arpcache
netsh interface ip delete destinationcache
nbtstat -R
nbtstat -RR
netsh int ip reset
netsh winsock reset catalog

goto opcao1feita

REM Limpeza completa, apenas o Edge.

:edgedel
cls

set prefetch=C:\Windows\prefetch\*.*
set temp01=C:\Users\%USERNAME%\AppData\Local\Temp\*.*
set temp02=C:\Windows\Temp\*.*
set edge=C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\*.*

del /Q "%prefetch%" /S
rmdir /Q "%prefetch%" /S
del /Q "%temp01%" /S
rmdir /Q "%temp01%" /S
del /Q "%temp02%" /S
rmdir /Q "%temp02%" /S
del /Q "%edge%" /S
rmdir /Q "%edge%" /S

sfc /purgecache
sfc /cachesize=50
IPCONFIG /RELEASE
IPCONFIG /FLUSHDNS
NET STOP DNSCACHE
NET STOP DHCP
NET START DNSCACHE
NET START DHCP
IPCONFIG /REGISTERDNS
IPCONFIG /RENEW
arp -a -d
netsh interface ip delete arpcache
netsh interface ip delete destinationcache
nbtstat -R
nbtstat -RR
netsh int ip reset
netsh winsock reset catalog

goto opcao1feita










REM Código pra voltar ao menu inicial.

:opcao1feita
cls

echo Tudo feito, voltando para o menu inicial...
timeout 3
goto menu

REM Opção pra sair.

:opcao5
cls

exit

REM Opção pra voltar.

:opcao6
cls

goto menu