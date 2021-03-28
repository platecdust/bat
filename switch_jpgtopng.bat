@echo off

set sdDrive=G

if not exist "%sdDrive%:\Nintendo\" (
	goto directoryError
)

rem SD�J�[�h��Album�t�H���_������jpg��original�t�H���_�փR�s�[
cd /d %sdDrive%:\Nintendo\Album\
forfiles /m *.jpg /s /c "cmd /c copy /n @file "%~dp0original\""
rem Album�t�H���_������mp4��complete�t�H���_�փR�s�[
forfiles /m *.mp4 /s /c "cmd /c copy /n @file "%~dp0complete\""
rem forfile /m�����}�X�N /s�T�u�t�H���_�����܂߂� /c�R�}���h

cd /d %~dp0original

rem jpg��png�ɕϊ�
for %%f in (*.jpg) do (
    echo %%~f
    if not exist "..\complete\%%~nf.png" (
        echo �ϊ���
        magick convert "%%f" -quality 96 "%%~nf.png"
        move /y "%%~nf.png" ..\complete\
    ) else (
        echo �X�L�b�v���܂�
    )
)

goto end

:directoryError
echo %sdDrive%:\Nintendo �t�H���_��������܂���
pause
exit

:end
pause
exit
