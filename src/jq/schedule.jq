def n: join("");

.[0] as $weekIDs
| .[1] as $weeks
| $weekIDs[
	now
	| strflocaltime("%V")
	| tonumber - 1
] as $weekID
| $weeks[$weekID] as $week
| $week.scheduleIDs[
	now
	| strflocaltime("%w")
	| tonumber
] as $scheduleID
| .[2][$scheduleID]
| . as $schedule
| .periodIDs as $periodIDs
| .timestamps as $timestamps
| "<p>
	<span id=current-schedule-title>\(.title)</span>
	<span id=current-schedule-status></span>
</p>" + if .periodIDs then "
	<table style=--color:\(.color)>
		<td data-timestamp=0></td>
		\( $timestamps
		| ( .[-1] - .[0] ) as $span
		| to_entries | map( "
		<td data-timestamp=\(.value) title=\($periodIDs[.key]) width=\(
			( ($timestamps + [.value])[.key+1] - .value )
			/ $span * 100 * 100
			| floor / 100
		)%%>
			<time>\( .value*60 | strftime("%l:%M" ) )</time>
		</td>
		") |n )
	</table>
" else "" end
