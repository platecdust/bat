cd /d %~dp0
rem 日付を取得
set yyyy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set time2=%time%
set hh=%time2:~0,2%
set hr=%hh: =0%
set mn=%time2:~3,2%
set ss=%time2:~6,2%
set pross=00
set dirname=backup_%yyyy%%mm%%dd%_%hr%%mn%%pross%

xcopy /e "doragons" %dirname%\
7z.exe a -mmt=on -mx=1 -ssw -tzip %dirname%.zip %dirname%
copy /n %dirname%.zip D:\plate\OneDrive\バックアップ\MinecraftWorlds\
rmdir /s /q %dirname%

set /a isleap=%yyyy% %% 4
if %mm%=="01" set end=31
if %mm%=="02" set end=31
if %mm%=="03" (
	if %isleap%==0 (
		set end=29
	) else (
		set end=28
	)
)
if %mm%=="04" set end=31
if %mm%=="05" set end=30
if %mm%=="06" set end=31
if %mm%=="07" set end=30
if %mm%=="08" set end=31
if %mm%=="09" set end=31
if %mm%=="10" set end=30
if %mm%=="11" set end=31
if %mm%=="12" set end=30
if %dd% leq 10 (
	set /a delbakdd=%end%-%dd%-10
) else (
	set /a delbakdd=%dd%-10
)
set delbakdd=0%delbakdd%
set delbak=backup_%yyyy%%mm%%delbakdd:~-2%_%hr%%mn%%pross%.zip
rem OneDriveバックアップ用
if %dd% leq 2 (
	set /a od_delbakdd=%end%-%dd%-1
) else (
	set /a od_delbakdd=%dd%-1
)
set od_delbakdd=0%od_delbakdd%
set od_delbak=backup_%yyyy%%mm%%od_delbakdd:~-2%_%hr%%mn%%pross%.zip

del %delbak%
del D:\plate\OneDrive\バックアップ\MinecraftWorlds\%od_delbak%

rem pause
exit
