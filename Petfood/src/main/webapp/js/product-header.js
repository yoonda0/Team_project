/* SHIN BADA 220906 */
/* Javascript reponsible for function of product header */

$(function() {
	const WAIT_TIME = 300;

	/* Variable */
	let lastScrollTop = 0;

	/* jQuery Object */
	let navTop = $('.sticky-nav-wrapper').offset().top;
	let $nav = $('.content-nav-wrapper');
	let $oldSticky = $sticky;
	let oldStickyTop = stickyTop;

	changingTimer = null;
	
	let isStickyChanged;

	function changeSticky() {
		if (!changingTimer) {
			if (window.pageYOffset > navTop && !isStickyChanged){
					$oldSticky = $sticky;
					$oldSticky.addClass('sticky-hide');
					oldStickyTop = stickyTop;
					$sticky = $('.content-nav-wrapper').addClass('sticky-wrapper')
							.addClass('fixed');
					stickyTop = navTop;

					isStickyChanged = true;
				} else if (window.pageYOffset < navTop && isStickyChanged) {
					$sticky.removeClass('sticky-wrapper');
					$sticky = $oldSticky.addClass('fixed').removeClass('sticky-hide');
					stickyTop = oldStickyTop;

					changingTimer = setTimeout(() => { changingTimer = null; }, WAIT_TIME);

					isStickyChanged = false;
				}
			}
		};

	if ($sticky.length > 0 && $nav.length > 0) {
		$(window).on('scroll', changeSticky);
	}

	changeSticky();
})