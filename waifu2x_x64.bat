@echo off

: =�̌��ɒl�������Ă��������B(�X�y�[�X���͕K�v����܂���)
: �󔒂̏ꍇ�A�f�t�H���g�l(*�����Ă���l)���K�p����܂��B

: �o�͐�̃f�B���N�g��
set out=
: �Ō��\�͕s�v�ł��B
: �󔒂̏ꍇ�̃t�@�C�����́A
: [���̉摜�t�@�C����][���[�h��][�m�C�Y�������x��][�g�嗦].png

: �摜�̃X�^�C��
set type=
: art	:�C���X�g	*
: photo	:�ʐ^

: �ϊ����[�h
set mode=
: noise			:�m�C�Y�����̂�
: scale			:�g��̂�
: noise_scale	:�m�C�Y�����Ɗg��	*

: �m�C�Y�������x��
set noise=
: 1	:�m�C�Y�������x�� ��	*
: 2	:�m�C�Y�������x�� ��

: �g��{��
set scale=
: �����_�t�����l�Ŏw��B
: �f�t�H���g�l�� 2.0

: �X���b�h�̐�
set job=
: �f�t�H���g�l�� 4


: �ݒ�͂����܂�


if "%~1"=="" (
	rem �R�}���h���C���������Ȃ��ꍇ
	echo ��������摜���w�肵�Ă�������
	echo �K�� "" �Ŋ����Ă�������
	echo �����w�肷��Ƃ��̓X�y�[�X�ŋ�؂��Ă�������
	set /p in=">"
	echo.
)


rem �I�v�V�����ݒ�̈ē�
echo ���O�ɐݒ肵�����e�Ŏ��s����ɂ� ���̂܂�Enter�������Ă�������
echo �I�v�V�������w�肷��ꍇ�� o ���w�肵�Ă�������
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


rem �w�肳�ꂽ�I�v�V�������A���ۂ�waifu2x�ɓn��������ɒu������
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


rem �����J�n
setlocal enabledelayedexpansion
set n=0
if "%~1"=="" (
	rem �R�}���h���C���������Ȃ��ꍇ
	for %%i in (%in%) do (
		set /a n+=1
		echo !n! ��  %%~nxi ��������...
		if not "%out%"=="" (set oo="-o %out%\%%~nxi")
		waifu2x-converter_x64.exe -i %%i !oo! %mm% %jj% %tt% %ss% %nn%
		echo.
	)
)else (
	rem �R�}���h���C������������ꍇ
	cd /d %~dp0
	for /f "usebackq delims==" %%i in (`dir /a-s-d /s /b %*`) do (	
		set /a n+=1
		echo !n! ��  %%~nxi ��������...
		if not "%out%"=="" (set oo="-o %out%\%%~nxi")
		waifu2x-converter_x64.exe -i "%%i" !oo! %mm% %jj% %tt% %ss% %nn%
		echo.
	)
)
echo.
goto :bye


:option
echo.
echo �E�o�͐�̃f�B���N�g��
echo �Ō��\�͕s�v�ł�
echo  �󔒂̏ꍇ�̃t�@�C������
echo  [���̉摜�t�@�C����][���[�h��][�m�C�Y�������x��][�g�嗦].png
set /p out=">"
echo.
echo �E�摜�̃X�^�C��
echo art	:�C���X�g	*
echo photo	:�ʐ^
set /p type=">"
echo.
echo �E�ϊ����[�h
echo noise			:�m�C�Y�����̂�
echo scale			:�g��̂�
echo noise_scale	:�m�C�Y�����Ɗg��	*
set /p mode=">"
rem �m�C�Y����1,2�ȊO�����f���f�B���N�g���𕪂��邱�ƂŎ������悤�Ƃ��Ă݂��@��߂�
echo.
if "%mode%"=="scale" (goto only_scale)
echo �E�m�C�Y�������x��
echo 1	:�m�C�Y�������x�� ��	*
echo 2	:�m�C�Y�������x�� ��
set /p noise=">"
echo.
if "%mode%"=="noise" (goto only_noise)
:only_scale
echo �E�g��{��
echo �����_�t�����l�Ŏw��B
echo 2.0 �ȊO�̐��l���w�肷��Ǝ��̂悤�ȏ������s���܂�
echo  �w�肳�ꂽ�{����K�v�\���ɃJ�o�[����悤�� 2�{�g����J��Ԃ��s���܂�
echo  2�̗ݏ�ȊO�̐��l���w�肵���ꍇ�� �w��{���ȏ�ɂȂ�悤�Ɋg�債���� ���`�t�B���^�ŏk�����܂�
echo �f�t�H���g�l�� 2.0
set /p scale=">"
echo.
:only_noise
echo �E�X���b�h�̐�
echo ���̃I�v�V�����Ŏw�肵�����̃X���b�h���v���O�������ŋN������܂�
echo CPU�̃R�A�����w�肷�邱�Ƃłقڍő��ł̏������s���܂���
echo CPU��100%�Ŏg�p���邱�ƂɂȂ�̂ŕ��M���ɂ͏\�����ӂ��Ă�������
echo �f�t�H���g�l�� 4
set /p job=">"
echo.
echo �I�v�V�����̓��͈͂ȏ�ł��B
pause
echo.
exit /b


:bye
echo �I�����܂��B
pause
exit
