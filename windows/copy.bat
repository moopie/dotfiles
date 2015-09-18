@echo off

echo Copying files...
echo.
echo.

set dotfiles="%UserProfile%\dotfiles"

:: Copy vimfiles
xcopy /S /I "%dotfiles%\vim" "%UserProfile%\.vim"
xcopy "%dotfiles%\vim\vimrc" "%UserProfile%\.vimrc"

:: Bash and etc
xcopy "%dotfiles%\bashrc" "%UserProfile%\.bashrc"

:: git
xcopy "%dotfiles%\gitconfig" "%UserProfile%\.gitconfig"
xcopy "%dotfiles%\gitignore_global" "%UserProfile%\.gitignore_global"

:: Copy AutoHotkey
xcopy "%dotfiles%\windows\AutoHotkey.ahk" "%HOMEDRIVE%%HOMEPATH%\Start Menu\Programs\Startup\AutoHotkey.ahk"

exit
