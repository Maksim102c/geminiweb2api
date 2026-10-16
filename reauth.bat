@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Geminiweb2api - Reauth
echo Запуск Geminiweb2api (Reauth Mode)...
echo ВНИМАНИЕ: Старая сессия будет удалена!
python start.py --reauth
pause