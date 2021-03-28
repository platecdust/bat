@echo off

set sdDrive=G

if not exist "%sdDrive%:\Nintendo\" (
	goto directoryError
)

rem SDカードのAlbumフォルダ内からjpgをoriginalフォルダへコピー
cd /d %sdDrive%:\Nintendo\Album\
forfiles /m *.jpg /s /c "cmd /c copy /n @file "%~dp0original\""
rem Albumフォルダ内からmp4をcompleteフォルダへコピー
forfiles /m *.mp4 /s /c "cmd /c copy /n @file "%~dp0complete\""
rem forfile /m検索マスク /sサブフォルダ内も含める /cコマンド

cd /d %~dp0original

rem jpgをpngに変換
for %%f in (*.jpg) do (
    echo %%~f
    if not exist "..\complete\%%~nf.png" (
        echo 変換中
        magick convert "%%f" -quality 96 "%%~nf.png"
        move /y "%%~nf.png" ..\complete\
    ) else (
        echo スキップします
    )
)

goto end

:directoryError
echo %sdDrive%:\Nintendo フォルダが見つかりません
pause
exit

:end
pause
exit
