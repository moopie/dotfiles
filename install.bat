@echo off

echo Installing chocolatey...
echo.
echo.

powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

start "" "%UserProfile%\dotfiles\windows\applications.bat"
start "" "%UserProfile%\dotfiles\windows\copy.bat"

exit
