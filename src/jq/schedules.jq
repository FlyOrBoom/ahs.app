def n: join("\n");
def e: join("");

.[0] as $scheduleIDs
| .[1] as $schedules
| $scheduleIDs | map( . as $id | $schedules[.] | [
	( "<section id="+$id+" class=schedule>" ),
	( "<h4><a href=#"+$id+">"+.title+"</a></h4>" ),
	( .timestamps 
	| . as $timestamps
	| ( .[-1] - .[0] ) as $span
	| to_entries
	| [
		( "<table><td data-timestamp=0></td>" ),
		( . | map( [
			( "<td data-timestamp=" ),
			( .value ),
			( " width=" ),
			( 
				( ($timestamps + [.value])[.key+1] - .value )
				/ $span * 100 * 100
				| floor / 100
			),
			( "%%>" ),
			( "<time>" ),
			( .value*60 | strftime("%l:%M" ) ),
			( "</time>" ),
			( "</td>" )
		] |e ) |e ),
	( "</table>" )
	] |e ),
	( "</section>" )
] |n ) |n
