def n: join("");
def current_value: .value | map(.) | last;

.[0]
| (map(map(.)|max)|max) as $max_value
| (map(keys|map(tonumber)|max)|max) as $max_key
| (map(keys|map(tonumber)|min)|min) as $min_key
| ( $max_key - $min_key ) as $key_span
| 4 as $key_n | 6 as $value_n
| ([range($min_key+24*60*60;$max_key;$key_span/$key_n)]) as $key_axis
| ([range(0;$max_value+1;$max_value/$value_n | ceil)]) as $value_axis
| to_entries
| ( sort_by( current_value )
	| map( select( current_value > 0 ) )
	| ( ({ "others": { "0" : 0 } } | to_entries) + . )
) as $label_raw_axis
| ( $label_raw_axis | map ( "
	<tspan>
			\( current_value )
		</tspan><tspan class='label'>
			\( .key | split("-") | map( explode | map(.-32) | implode ) | join(" ") )
	</tspan>" )
) as $label_axis
| ( $label_axis | length ) as $label_n
| "
	<text x='\(-1000/$key_n)'> \( $key_axis | map ( "
		<tspan y='1100' dx='\(1000/$key_n)'>\(. | strftime("%m/%d"))</tspan>
	") | n ) </text>
	<text y='\(-1000/$value_n)'> \( $value_axis | map ( "
		<tspan x='-50' dy='\(1000/$value_n)'>\(.)</tspan>
	") | reverse | n ) </text>
	<text y='\(-1000/$label_n)'> \( $label_axis | map ( "
		<tspan x='1200' dy='\(1000/($label_n-1))'>\(.)</tspan>
	") | reverse | n ) </text>
" + "
	<path class='label-connector' d='\(
		$label_raw_axis
		| to_entries
		| map( "M1030,
			\( ( 1 - (.value | current_value) / $max_value) * 1000 )
			L1180,
			\( ( 1 - .key / ($label_n-1) ) * 1000)
		" ) | n
	)'
" + ( map( .key as $location | .value | to_entries | "
		<path id='covid-cases-\($location)' d='M\(
			map ( "
				\( (.key | tonumber - $min_key ) / $key_span * 1000 ),
				\( ( 1 - .value/$max_value ) * 1000 )
			" )
			| join("L")
		)'/>
	" ) |n
)
