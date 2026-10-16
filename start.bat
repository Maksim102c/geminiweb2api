@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Geminiweb2api
python start.py
pause