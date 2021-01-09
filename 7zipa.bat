@echo off

set archiverPath="C:\Program Files\7-Zip\7z.exe"

echo destinationFolder?
echo If not entered, the same directory as the compression source.
set destinationFolder=%~dp0
set /p destinationFolder="> "

rem password
rem set pass="XXXXXXXX"
set format=7z
set level=9

echo format=%format% level=%level%
echo ok?
pause

for %%f in (%*) do (
  %archiverPath% a -mmt=on -mx=%level% -ssw -t%format% "%destinationFolder%%%~nf.7z" %%f
)
rem -mmt=on/off/n マルチスレッディング
rem -mx=n(0無圧縮-9超圧縮) 圧縮率
rem -ssw 開かれているファイルも圧縮対象ファイルとして含める
rem -t(フォーマット)
rem ignore option -p%pass%

echo completed
pause
