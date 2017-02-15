// TODO: detect scroll direction and scroll to different locations
var init = true;

document.onscroll = function() {
	// console.log(window.pageYOffset || document.documentElement.scrollTop);
	if(init) {
		init = false;
		document.getElementById('content').scrollIntoView({
			behavior: 'smooth'
		});
	}
}