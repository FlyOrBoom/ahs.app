def n: join("");
def slug: gsub("[^\\w\\d]+";"-") | gsub("^-|-$";"");
def rot13: explode | map(
	if 65 <= . and . <= 90 then ((. - 52) % 26) + 65
	elif 97 <= . and . <= 122 then (. - 84) % 26 + 97
	else . end
) | implode;

.[0] as $locationIDs
| .[1] as $locations
| .[2] as $categories
| .[3] as $snippets
| $locationIDs | map( . as $id | $locations[.] | "
	<section id=\($id) class=location>
		<h2><a href=#\($id)>\(.title)</a></h2>
		\( .categoryIDs | map( . as $id | $categories[.] | select( .visible ) | .layout as $layout | "
			<section id=\($id) style=--color:\(.color) class='category layout-\($layout)'>
				<h3><a href=#\($id)>\(.title)</a></h3>
				<section class=snippets>
				\( .articleIDs | .? | map( . as $id | $snippets[.] | "
					<a href=/\(.title|slug)/\($id|rot13) style=--color:\(.color) class=snippet>
						\( if .thumbURLs then "<img src=\(.thumbURLs[0]) crossorigin loading=lazy width=180 height=180 alt>" else "" end )
						<h4>\(.title)</h4>
						\( if .blurb != "" then "<p>\(.blurb)</p>" else "" end )
					</a>
				") |n )
				</section>
			</section>
		") |n )
	</section>
" ) |n
