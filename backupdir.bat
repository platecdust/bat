cd /d %~dp0

rem 7z.exe�̏ꏊ
set archiver="C:\Program Files\7-Zip"

rem �o�b�N�A�b�v�Ώۃt�H���_
set target=

rem ���t���擾
set yyyy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set time2=%time%
set hh=%time2:~0,2%
set hr=%hh: =0%
set mn=%time2:~3,2%
set ss=%time2:~6,2%
set dirname=backup_%yyyy%%mm%%dd%_%hr%%mn%%ss%

xcopy /e %target% %dirname%\
%archiver%\7z.exe a %dirname%.zip %dirname%
rmdir /s /q %dirname%
