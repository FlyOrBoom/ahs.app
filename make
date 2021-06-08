<!DOCTYPE html>
<html lang=en-US dir=ltr>
<head>
	<meta charset=utf-8>

	<title>ahs.app</title>
	<meta name=description content='We keep you up to date with Arcadia High.'>
	<meta name=author content='Arcadia High Mobile Team'>
	<meta name=web-author content='Xing Liu'>
	<meta name=viewport content='width=device-width, initial-scale=1.0'>
	<meta name=color-scheme content='light dark'>
	
	<link rel=icon type=image/png href=/icon.png>
	<link rel=preconnect href=https://ahs-app.firebaseio.com>
	<link rel=stylesheet href=/style.css>
	<script src=/script.js async defer></script>
</head>
<body>
	<h1><a href=/ > ahs.app </a></h1>
	<noscript> Please enable JavaScript in order to load full articles. </noscript>
	<main hidden>
		<article></article>
		<footer>&vellip;</footer>
	</main>
	<aside class=category id=C-Schedule>
		%s
	</aside>
	<nav>
		%s
	</nav>
	<footer class=footer><article>
		<strong>ahs.app</strong>
		<p>
			is a web app designed and programmed by <a href='https://x-ing.space'>Xing</a> of the AHS App Development Team.
		</p><p>
			It features the fonts
			<a href='https://indestructibletype.com/Besley.html'>Besley*</a>
			by
			<a href='https://indestructibletype.com'>Indestructible Type*</a>
			and
			<a href='https://github.com/skosch/Crimson'>Crimson</a>
			by
			<a href='https://aldusleaf.org/'>Sebastian Kosch</a>.
		</p><p>
			It does not collect data from you and does not track you.
			View its source code on
			<a href='https://github.com/FlyOrBoom/ahs.app'>GitHub</a>.
		</p><p>
			However, if you use the embedded video players,
			you must agree to
			<a href='https://www.youtube.com/static?template=terms'>YouTube’s Terms of Use</a>.
		</p><p><strong>
			Get our native app, Arcadia High Mobile, for
			<a href='https://apps.apple.com/us/app/id1305220468'>iOS</a>
			and
			<a href='https://play.google.com/store/apps/details?id=com.hsappdev.ahs'>Android</a>.
		</strong></p><p>
			Want to submit an article? Email us at
			<a href='mailto:hsappdev@students.ausd.net'>
				HsAppDev@students.ausd.net
			</a>
		</p><p>
			Articles fetched at <time>%s</time>.
		</p>
	</article></footer>
	<template class=template-youtube>
		<iframe class=youtube
			src='https://www.youtube-nocookie.com/embed/[URL]?modestbranding=1&rel=0'
			frameborder=0
			allow='clipboard-write; encrypted-media; picture-in-picture'
			allowfullscreen
		></iframe>
	</template>
	<template class=template-image>
		<img class=image>
	</template>
	<template class=template-snippet>
		<a class=snippet>
			<img class=image>
			<h4></h4>
			<p></p>
		</a>
	</template>
	<template class=template-article>
		<article class=article>
			<h2 class=title heading tabindex=0>
				Loading article&hellip;
			</h2>
			<section class='media carousel'></section>
			<section class=metadata>
				<address class=author></address>
				<time class=date></time>
			</section>
			<section class=body>
				<p> If it’s taking too long, you may have been sent a broken link. </p>
			</section>
			<section class=category id=C-Related data-layout=list>
				<h3>Related</h3>
				<section class='related snippets'>
					
				</section>
			</section>
		</article>
	</template>
</body>
</html>
