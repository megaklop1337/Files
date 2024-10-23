@echo off
chcp 65001 >nul
setlocal

:: Путь к системным папкам
set SYSTEM_FOLDERS="%USERPROFILE%\Pictures" "%USERPROFILE%\Documents" "%USERPROFILE%\Downloads" "%USERPROFILE%\Music" "%USERPROFILE%\Videos" "%USERPROFILE%\Desktop"

:: Проверка пути
set currentPath=%~dp0

for %%F in (%SYSTEM_FOLDERS%) do (
    if /I "%currentPath:~0,-1%" == "%%~F" (
        echo Скрипт не может быть запущен из системной папки: %%~F
        echo Создайте отдельную папку под названием "QuickNet" или любим другим латинским названеим
        del "%~dp0cygwin1.dll" /f /q
        del "%~dp0quic_initial_www_google_com.bin" /f /q
        del "%~dp0list-general.txt" /f /q
        del "%~dp0tls_clienthello_www_google_com.bin" /f /q
        del "%~dp0WinDivert.dll" /f /q
        del "%~dp0WinDivert64.sys" /f /q
        del "%~dp0winws.exe" /f /q
        pause
        exit /b
    )
)

    set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-65535 ^
--filter-udp=443 --hostlist=\"%~dp0list-general.txt\" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-udplen-increment=10 --dpi-desync-udplen-pattern=0xDEADBEEF --dpi-desync-fake-quic=\"%~dp0quic_initial_www_google_com.bin\" --new ^
--filter-udp=50000-65535 --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --dpi-desync-fake-quic=\"%~dp0quic_initial_www_google_com.bin\" --new ^
--filter-tcp=80 --hostlist=\"%~dp0list-general.txt\" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist=\"%~dp0list-general.txt\" --dpi-desync=fake,split --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls=\"%~dp0tls_clienthello_www_google_com.bin\"

set SRVCNAME=QuickNet

:menu
echo.
echo Выберите действие:
echo 1. Для удаления или обновления (Если вы хотите установить обновление, то для выберите пункт 1. После удаления файлов запустите приложение по новой и установите сервис выбрав 2)
echo 2. Установить сервис
echo 3. Обновить файлы (скоро)
echo 4. Выход
set /p choice=Введите номер (1-4): 

if "%choice%"=="1" (
    net stop %SRVCNAME%
    sc delete %SRVCNAME%
    echo Сервис остановлен и удален.
    goto after_action
) else if "%choice%"=="2" (
net stop %SRVCNAME%
sc delete %SRVCNAME%
sc create %SRVCNAME% binPath= "\"%~dp0winws.exe\" %ARGS%" DisplayName= "by SiresMacro: %SRVCNAME%" start= auto
sc description %SRVCNAME% "by SiresMacro"
sc start %SRVCNAME%
    goto after_action
) else if "%choice%"=="3" (
    echo Обновление файлов будет добавлено позже.
    goto after_action
) else if "%choice%"=="4" (
    echo Выход из программы.
    exit /b
) else (
    echo Неверный выбор. Пожалуйста, попробуйте еще раз.
    goto menu
)

:after_action
rem Открытие социальных сетей
start "" "https://www.youtube.com/@siresmacro"
pause
