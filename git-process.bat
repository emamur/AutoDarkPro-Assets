@echo off
setlocal enabledelayedexpansion

REM Tarih ve saat al (YYYY-MM-DD HH:MM:SS)
for /f "tokens=1-3 delims=." %%a in ("%date%") do (
    set DAY=%%a
    set MONTH=%%b
    set YEAR=%%c
)

for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
    set HOUR=%%a
    set MIN=%%b
)

set COMMIT_DATE=%YEAR%-%MONTH%-%DAY%
set COMMIT_TIME=%HOUR%:%MIN%

set COMMIT_MSG=Auto update %COMMIT_DATE% %COMMIT_TIME%

REM Git işlemleri
git add .

git diff --cached --quiet
if errorlevel 1 (
    git commit -m "%COMMIT_MSG%"
    git push origin main
) else (
    echo No changes to commit.
)

endlocal
