'use strict'

const Main = document.querySelector('main')
const Media = Main.querySelector('.media')
const Title = document.querySelector('h1>a')
const Canvas = document.createElement('canvas')
Canvas.ctx = Canvas.getContext('2d')

main()

async function main() {
	show_article()

	document.body
		.querySelectorAll('[href^="/"]')
		.forEach(link=>link.addEventListener('click', internal_link))
	
	window.addEventListener('popstate', show_article)
	window.addEventListener('resize', safe_center)

	Canvas.width = Canvas.height = 1
	Canvas.ctx.filter = 'saturate(1000%)'
}
async function show_article() {
	Main.hidden = window.location.pathname==='/'
	if(Main.hidden) return
	window.scrollTo(0,0)
	const id = rot13(window.location.pathname.split('/')[2])
	const article  = await db('articles/'+id)
	if (!article) return false
	Main.querySelector('h2').focus()
	for (const property in article) {
		const element = Main.querySelector('.' + property)
		if (!element) continue
		element.innerHTML = article[property]
	}
	
	const media_cache = []
	if(article.videoIDs) for (const id of article.videoIDs){
		const embed = clone_template('youtube')
		embed.src = embed.src.replace('$URL$',id)
		media_cache.push(embed)
		embed.addEventListener('load',safe_center)
	}
	if(article.imageURLs) for (const url of article.imageURLs){
		const image = clone_template('image')
		image.src = url
		media_cache.push(image)
		image.addEventListener('load',safe_center)
	}
	Media.style.alignContent = 'safe center'
	Media.replaceChildren(...media_cache)
}
async function safe_center(){
	Media.style.alignContent = Media.scrollWidth > window.innerWidth ? 'flex-start' : 'safe center'
}
async function db(...path) {
	const response = await fetch(`https://arcadia-high-mobile.firebaseio.com/${path.join('/')}.json`)
	return await response.json()
}
function internal_link(event){
	history.pushState({}, '', event.target.href)
	show_article()
	event.preventDefault()
}
async function gradient_background(element, image) {
	if(!['i.ibb.co','imgur.com'].includes(image.src.split('/')[2])) return false
	image.crossOrigin = 'Anonymous'
	image.addEventListener('load', () => {
		Canvas.ctx.drawImage(image, 0, 0, 1, 1)
		const data = Canvas.ctx.getImageData(0, 0, 1, 1).data
		let color = `rgba(${data[0]}, ${data[1]}, ${data[2]}, 0.2)`
		let gradients = `
			radial-gradient(circle at 100% 100%,${color},transparent),
			radial-gradient(circle at 0% 0%,transparent,var(--secondary))
		`
		element.style.backgroundImage = gradients
	})
}
function clone_template(name) {
	return document.querySelector('.template-' + name)
		.content.cloneNode(true)
		.querySelector('*')
}
function rot13(str) {
	const input     = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
	const output    = 'NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm';
	const index     = x => input.indexOf(x);
	const translate = x => index(x) > -1 ? output[index(x)] : x;
	return str.split('').map(translate).join('');
}
  
