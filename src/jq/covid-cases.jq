def n: join("");
def value_list: .value | map(.);
def current_value: value_list | last;
def cumulative_value: value_list | add;

.[0]
| to_entries
| sort_by( .key ) | reverse
| sort_by( current_value )
| map( select( cumulative_value > 0 ) )
| map( select( .key | startswith("totals-") | not) )
| to_entries
| . as $y | map(.key as $k0 | .value.key as $k1 | .value.value as $v1 | {key: $k1, value: ($v1|keys|map(. as $k2|{key: $k2, value: ($y[0:$k0+1]|map(.value.value[$k2])|add)})|from_entries)})
| from_entries
| (map(map(.)|max)|max) as $max_value
| (map(keys|map(tonumber)|max)|max) as $max_key
| (map(keys|map(tonumber)|min)|min) as $min_key
| ( $max_key - $min_key ) as $key_span
| (24*60*60) as $key_step
| ([range(0;$key_span/$key_step+1;4)]) as $key_axis
| ([range($max_value+1)]) as $value_axis
| to_entries
| ( $key_axis | length -1 ) as $key_n
| ( $value_axis | length -1 ) as $value_n
| "
	<text> \( $key_axis | to_entries | map ( "
		<tspan y='1075' x='\(1000*.key/$key_n-50)'>\($min_key + .value*$key_step | strftime("%m/%d"))</tspan>
	") | n ) </text>
	<text y='\(-1000/$value_n)'> \( $value_axis | map ( "
		<tspan x='-50' dy='\(1000/$value_n)'>\(.)</tspan>
	") | reverse | n ) </text>
	<text x='1050' y='-375' class='people'>
		Current cases:
	</text>
	\( to_entries | reverse | map( .
		| .key as $k
		| ($k/($value_n-1)) as $n
		| .value
		| .key as $location
		| .value
		| to_entries
		| "
		<text x='1150' y='\(1000-1100*$n-40)'>
			<tspan class='location'>
				\($location | gsub("-|elementary|middle|school|students|staff";" ") | ascii_upcase )
			</tspan>
			<tspan class='people' x='1150' dy='45'>
				\( $y[$k].value.value|map(.)|last ) \($location | split("-") | last)
			</tspan>
		</text>
		<path
			fill='hsl(\(360*$n)deg,80%,\(25 + 50*$n)%)'
			id='\($location)'
			d='
			M1000,1000H0
			\( map ( "
				V\( ( 1 - .value/$max_value ) * 1000 )
				H\( (.key | tonumber - $min_key ) / $key_span * 1000 )
				V1000
				h10
			" ) |n )
			Z
			M1050,\(1000-1100*$n)h75v-\(400/$value_n)h-75Z
			'
		/>
	" ) |n
)
"
