ren *.jfif *.jpg
ren *.jpeg *.jpg

mogrify -format png -quality 96 *.jpg

rem グレースケール
rem mogrify -format png -colorspace Gray -define png:color-type=0 -quality 96 *.jpg

md original
move /y *.jpg original\