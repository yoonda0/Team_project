/* SHIN BADA 220823 */
/* Javascript reponsible for header function  */

/* jQuery Object */

$(function() {
	const HIDE_CLASS = 'sticky-hide';
	const FIXED_CLASS = 'fixed';

	/* Variable */
	let lastScrollTop = 0;
	$sticky = $(".sticky-wrapper");
	stickyTop = $sticky.offset().top;

	// limit of degree of scrolling.
	let delta = { up: 50, down: 2 };

	/* Function */
	// Calculate position of sticky bar based on the scroll position.
	function calculateStickyTop() {

		// Value of the top of viewport.
		let y = window.pageYOffset;

			$sticky.addClass(FIXED_CLASS);

			if (y - delta.down > lastScrollTop) {
				if (y > 1) {
					$sticky.addClass(HIDE_CLASS);
				}

				lastScrollTop = y;

			} else if (y + delta.up < lastScrollTop || y < delta.down) {
                $sticky.removeClass(HIDE_CLASS);
                lastScrollTop = y;
            }

            if (y - delta.down > lastScrollTop || y + delta.up < lastScrollTop)
                // Keep track only outside of delta range.
                lastScrollTop = y;
	}

	// Calculate state of sticky bar based on the scroll position.
	function calculateStickyFixed() {
		if (window.pageYOffset > stickyTop){
			$sticky.addClass(FIXED_CLASS);

			calculateStickyTop();
		} else { $sticky.removeClass(FIXED_CLASS); }
	}

	/* EventListener */

	// When exists sticky bar and scrolls.
	if ($sticky.length > 0) {
		$(window).on('scroll', calculateStickyFixed);

		// Initialize state of sticky bar. 
		calculateStickyFixed();
	}
});