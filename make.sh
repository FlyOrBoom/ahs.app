duration=$1
while true
do
	git fetch --all
	git reset --hard origin/main

	mkdir public
	(
		cd public
		bash index.sh > ../public/index.html
		yui-compressor style.css -o ../public/style.css
		terser --compress --mangle --toplevel script.js -o ../public/script.js
		cp icon.png ../public/icon.png
	)

	firebase deploy
	sleep ${duration}
done
