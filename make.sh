#!/bin/bash

cd src

html=$(cat index.html)
js=$(cat script.js)
css=$(cat style.css)

curl -ZL "db.ahs.app/{locationIDs,locations,categories,snippets,week,schedules}.json" -o "/tmp/#1.json"

snippets=$(jq -sfr snippets.jq /tmp/locationIDs.json /tmp/locations.json /tmp/categories.json /tmp/snippets.json)
schedule=$(jq -sfr schedule.jq /tmp/week.json /tmp/schedules.json)

time=$(TZ=":America/Los_Angeles" date +"%l:%M %P Pacific Time")

cd ..

printf "$html" "$css" "$schedule" "$snippets" "$time" "$js" > dist/index.html

echo "
built site"
