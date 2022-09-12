/* SHIN BADA 220906 */
/* Javascript reponsible for function of product tab */

$(function() {
	const TAB_REG_EX = /tab-([A-Za-z]+)/
	const DURATION = 300;


	let $contentTab = $('.content-tab');
	let navTop = $('.sticky-nav-wrapper').offset().top;
	let contentTops = new Array($contentTab.length - 1);

	let oldLastIndex;

	$contentTab.each(function(i, e) {
		contentTops[i] = $(".content-" + $(e).attr('class').match(TAB_REG_EX)[1]).offset().top;
	});

	$contentTab.on('click', function() {
		if(!$(this).hasClass('active')) {
			let $this = $(this);
			let thisContentClass = ".content-" + $this.attr('class').match(TAB_REG_EX)[1];
			
			let $thisContent = $(thisContentClass);

			if ($thisContent.length) {
				let index = $contentTab.index(this);

				$('html').stop().animate({scrollTop: $thisContent.offset().top + 1}, 
					DURATION, () => {
						setTimeout(() => $('.content-nav-wrapper').removeClass('sticky-hide'), 10);
					});

				$('.animation-bar').css('transform', 'translateX(' + parseInt(index) * 100 + "%)");


				$('.active').removeClass('active');

				$this.addClass('active');
			}
		}
	});

	function animateBar(e) {
		let i = contentTops.findLastIndex((e) => e < window.pageYOffset);

		i = i != -1 ? i : 0;

		if (oldLastIndex != i) {
			$('.animation-bar').css('transform', 'translateX(' + parseInt(i) * 100 + "%)");

			$('.active').removeClass('active');
			$($contentTab.get(i)).addClass('active');

			oldLastIndex = i;
		}
	}

	$(window).on('scroll', animateBar);

	animateBar();
});