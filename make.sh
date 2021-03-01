duration=$1
while true
do
	cd src
		bash index.sh > ../dist/index.html
		yui-compressor style.css -o ../dist/style.css
		terser --compress --mangle --toplevel script.js -o ../dist/script.js
		cp icon.png ../dist/icon.png
	cd ..

	firebase deploy
	sleep ${duration}
done
