set archiverPath="C:\Program Files\7-Zip\7z.exe"

setlocal enabledelayedexpansion
for %%f in (*.zip) do (
    %archiverPath% x -mmt=on "%%f" -o"%%~nf"

    cd "%%~nf"

    mogrify -format png -quality 96 *.jpg
    del *.jpg

    ffmpeg -y -r 30 -i %%06d.png -vcodec libx264 -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -crf 0 "%%~nf_30f.mp4"
    ffmpeg -y -r 15 -i %%06d.png -vcodec libx264 -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -crf 0 "%%~nf_15f.mp4"
    ffmpeg -y -r 10 -i %%06d.png -vcodec libx264 -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -crf 0 "%%~nf_10f.mp4"
    ffmpeg -y -r 5 -i %%06d.png -vcodec libx264 -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -crf 0 "%%~nf_5f.mp4"
    
    cd ..\
)

pause
exit
