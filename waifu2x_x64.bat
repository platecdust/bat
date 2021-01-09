@echo off

: =の後ろに値を書いてください。(スペース等は必要ありません)
: 空白の場合、デフォルト値(*がついている値)が適用されます。

: 出力先のディレクトリ
set out=
: 最後の\は不要です。
: 空白の場合のファイル名は、
: [元の画像ファイル名][モード名][ノイズ除去レベル][拡大率].png

: 画像のスタイル
set type=
: art	:イラスト	*
: photo	:写真

: 変換モード
set mode=
: noise			:ノイズ除去のみ
: scale			:拡大のみ
: noise_scale	:ノイズ除去と拡大	*

: ノイズ除去レベル
set noise=
: 1	:ノイズ除去レベル 中	*
: 2	:ノイズ除去レベル 強

: 拡大倍率
set scale=
: 小数点付き数値で指定。
: デフォルト値は 2.0

: スレッドの数
set job=
: デフォルト値は 4


: 設定はここまで


if "%~1"=="" (
	rem コマンドライン引数がない場合
	echo 処理する画像を指定してください
	echo 必ず "" で括ってください
	echo 複数指定するときはスペースで区切ってください
	set /p in=">"
	echo.
)


rem オプション設定の案内
echo 事前に設定した内容で実行するには そのままEnterを押してください
echo オプションを指定する場合は o を指定してください
set /p option=">"
echo.
if "%option%"=="o" (
	call :option
)
if "%option%"=="edit" (
	notepad waifu2x_x64.bat
	exit
)
if "%option%"=="processor" (
	waifu2x-converter_x64.exe --list-processor
	goto :bye
)
if "%option%"=="version" (
	waifu2x-converter_x64.exe --version
	goto :bye
)
if "%option%"=="help" (
	waifu2x-converter_x64.exe -h
	goto :bye
)


rem 指定されたオプションを、実際にwaifu2xに渡す文字列に置き換え
if not "%type%"=="" (
	set tt="--model_dir models\%type%"
)else (set tt="--model_dir models\art")
if not "%mode%"=="" (set mm="-m %mode%")
if "%mode%"=="scale" (goto 1)
if not "%noise%"=="" (set nn="--noise_level %noise%")
if "%mode%"=="noise" (goto 2)
:1
if not "%scale%"=="" (set ss="--scale_ratio %scale%")
:2
if not "%job%"=="" (set jj="-j %job%")


rem 処理開始
setlocal enabledelayedexpansion
set n=0
if "%~1"=="" (
	rem コマンドライン引数がない場合
	for %%i in (%in%) do (
		set /a n+=1
		echo !n! 個目  %%~nxi を処理中...
		if not "%out%"=="" (set oo="-o %out%\%%~nxi")
		waifu2x-converter_x64.exe -i %%i !oo! %mm% %jj% %tt% %ss% %nn%
		echo.
	)
)else (
	rem コマンドライン引数がある場合
	cd /d %~dp0
	for /f "usebackq delims==" %%i in (`dir /a-s-d /s /b %*`) do (	
		set /a n+=1
		echo !n! 個目  %%~nxi を処理中...
		if not "%out%"=="" (set oo="-o %out%\%%~nxi")
		waifu2x-converter_x64.exe -i "%%i" !oo! %mm% %jj% %tt% %ss% %nn%
		echo.
	)
)
echo.
goto :bye


:option
echo.
echo ・出力先のディレクトリ
echo 最後の\は不要です
echo  空白の場合のファイル名は
echo  [元の画像ファイル名][モード名][ノイズ除去レベル][拡大率].png
set /p out=">"
echo.
echo ・画像のスタイル
echo art	:イラスト	*
echo photo	:写真
set /p type=">"
echo.
echo ・変換モード
echo noise			:ノイズ除去のみ
echo scale			:拡大のみ
echo noise_scale	:ノイズ除去と拡大	*
set /p mode=">"
rem ノイズ除去1,2以外をモデルディレクトリを分けることで実現しようとしてみた　やめた
echo.
if "%mode%"=="scale" (goto only_scale)
echo ・ノイズ除去レベル
echo 1	:ノイズ除去レベル 中	*
echo 2	:ノイズ除去レベル 強
set /p noise=">"
echo.
if "%mode%"=="noise" (goto only_noise)
:only_scale
echo ・拡大倍率
echo 小数点付き数値で指定。
echo 2.0 以外の数値を指定すると次のような処理を行います
echo  指定された倍率を必要十分にカバーするように 2倍拡大を繰り返し行います
echo  2の累乗以外の数値が指定した場合は 指定倍率以上になるように拡大した後 線形フィルタで縮小します
echo デフォルト値は 2.0
set /p scale=">"
echo.
:only_noise
echo ・スレッドの数
echo このオプションで指定した数のスレッドがプログラム内で起動されます
echo CPUのコア数を指定することでほぼ最速での処理が行えますが
echo CPUを100%で使用することになるので放熱等には十分注意してください
echo デフォルト値は 4
set /p job=">"
echo.
echo オプションの入力は以上です。
pause
echo.
exit /b


:bye
echo 終了します。
pause
exit
