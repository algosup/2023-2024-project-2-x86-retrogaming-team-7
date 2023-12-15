@echo off
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\..\.."
set "BIN_DIR=%ROOT_DIR%\bin"
nasm mainmenu.asm -f bin -o menu.com
