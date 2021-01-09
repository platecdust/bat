@echo off
set /p comment="comment >"
git add .
git commit -m "%comment%"
git push origin master
cmd /k