/* SHIN BADA 220831 */
/* Javascript reponsible for slide function  */

$(function() {
	/* Constant */
	const WAIT_TIME = 5000;

	// Same as css transition time of slide.
	const SLIDE_DURATION = 500;

	const DATA_ATTR = 'data-index';
	const ARIA_LABEL = 'aria-label';
	const BALL_LABEL_FIRST = '슬라이드 볼 ';
	const BALL_LABEL_LAST = '번째';
	const SLIDE_ACTIVE_CLASS = 'slide-active';
	const PRESENT_CLASS = 'slide-visable';
	const NEXT_CLASS = 'slide-next';
	const PREV_CLASS = 'slide-prev';
	const BALL_CLASS = 'pagination-ball';
	const BALL_ACTIVE_CLASS = 'active';
	const PREV = 0;
	const NEXT = 1;

	/* jQuery DOM */

	let $slideBannerWrapper = $('.slide.banner-wrapper');

	let $slideBanner = $slideBannerWrapper.children('.banner-link');

	var $prevBanner, $presentBanner, $nextBanner;

	let $slidePagination = $slideBannerWrapper.children('.slide-pagination');

	let $slideBall;

	/* Variable */

	let maxIndex = $slideBanner.length - 1;
	let presentIndex = 0;
	let nextIndex = presentIndex + 1;
	let prevIndex = maxIndex;

	let slideItemsArr = new Array(maxIndex + 1);

	let slideBallStr = "";

	$slideBanner.each( function (i, e) {
		slideItemsArr[i] = $(e);

		slideItemsArr[i].attr(DATA_ATTR, i);

		slideBallStr += '<button';
		slideBallStr += ' ';
		slideBallStr += 'class="' + BALL_CLASS + '"';
		slideBallStr += ' ';
		slideBallStr += DATA_ATTR + '="' + i + '"';
		slideBallStr += ' ';
		slideBallStr += ARIA_LABEL + '="' + BALL_LABEL_FIRST + ((i + 1) * 1) + BALL_LABEL_LAST + '"';
		slideBallStr += '></button>';
	});

	$slidePagination.append(slideBallStr);

	$slideBall = $('.' + BALL_CLASS);

	/* Timer */

	let waitTimer;

	/* Function */
	function activeSlide(e, position, time) {
		e.addClass(position).css('transition', 'none').addClass(SLIDE_ACTIVE_CLASS);
		$($slideBall[presentIndex]).addClass(BALL_ACTIVE_CLASS);
		setTimeout(function () { e.css('transition', ''); }, SLIDE_DURATION);
	}

	function slide(state, time, hasIndex) {
		if (!waitTimer) {
			if (maxIndex == 1) {
				if (state == NEXT) {
					if (!$nextBanner.hasClass(NEXT_CLASS)) {
						$nextBanner.removeClass(SLIDE_ACTIVE_CLASS).removeClass(PREV_CLASS)
							.addClass(NEXT_CLASS);
						setTimeout(function () { $nextBanner.addClass(SLIDE_ACTIVE_CLASS); }, 1);
					} else { $nextBanner.addClass(SLIDE_ACTIVE_CLASS); }

					$prevBanner = $presentBanner.removeClass(PRESENT_CLASS).addClass(PREV_CLASS);
					
					setTimeout(function() { $presentBanner = $nextBanner.removeClass(NEXT_CLASS)
							.addClass(PRESENT_CLASS); }, 1);

					setTimeout(function () {
						$nextBanner = $prevBanner.removeClass(SLIDE_ACTIVE_CLASS);
					}, SLIDE_DURATION);
				} else {
					if (!$prevBanner.hasClass(PREV_CLASS)) {
						$prevBanner.removeClass(SLIDE_ACTIVE_CLASS).removeClass(NEXT_CLASS)
							.addClass(PREV_CLASS);

						setTimeout(function () { $prevBanner.addClass(SLIDE_ACTIVE_CLASS); }, 1);
					} else { $prevBanner.addClass(SLIDE_ACTIVE_CLASS); }

					$nextBanner = $presentBanner.removeClass(PRESENT_CLASS).addClass(NEXT_CLASS);

					setTimeout(function () { $presentBanner = $prevBanner.removeClass(PREV_CLASS)
							.addClass(PRESENT_CLASS); }, 1);

					setTimeout(function () {
						$prevBanner = $nextBanner.removeClass(SLIDE_ACTIVE_CLASS);
					}, SLIDE_DURATION);
				}

				presentIndex = moveIndex(presentIndex, state);
				nextIndex = moveIndex(nextIndex, state);
				prevIndex = moveIndex(prevIndex, state);
			} else {
				if (hasIndex) {
					$prevBanner.removeClass(SLIDE_ACTIVE_CLASS).removeClass(PREV_CLASS);

					$presentBanner.css('transition-duration', time + 'ms').addClass(SLIDE_ACTIVE_CLASS)
						.removeClass(PRESENT_CLASS).addClass(PREV_CLASS);

					$nextBanner.css('transition-duration', time + 'ms').addClass(SLIDE_ACTIVE_CLASS).removeClass(NEXT_CLASS);

					initBanner(NEXT);

					$presentBanner.addClass(PRESENT_CLASS);
					$nextBanner.addClass(NEXT_CLASS);

					setTimeout(() => $prevBanner.css('transition-duration', ''), SLIDE_DURATION);
					setTimeout(() => $presentBanner.css('transition-duration', ''), SLIDE_DURATION);
				} else {
					if (state == NEXT) {
						$prevBanner.removeClass(SLIDE_ACTIVE_CLASS);
					} else {
						$nextBanner.removeClass(SLIDE_ACTIVE_CLASS);
					}

					$presentBanner.addClass(SLIDE_ACTIVE_CLASS);

					$prevBanner.removeClass(PREV_CLASS);
					$presentBanner.removeClass(PRESENT_CLASS);
					$nextBanner.removeClass(NEXT_CLASS);

					initBanner(state);

					if (state == NEXT) {
						$prevBanner.addClass(SLIDE_ACTIVE_CLASS);
					} else {
						$nextBanner.addClass(SLIDE_ACTIVE_CLASS);
					}

					$presentBanner.addClass(SLIDE_ACTIVE_CLASS);

					$prevBanner.addClass(PREV_CLASS);
					$presentBanner.addClass(PRESENT_CLASS);
					$nextBanner.addClass(NEXT_CLASS);
				}
			}

			if (state == NEXT) {
				$($slideBall[presentIndex]).addClass(BALL_ACTIVE_CLASS);
				$($slideBall[prevIndex]).removeClass(BALL_ACTIVE_CLASS);
			} else {
				$($slideBall[presentIndex]).addClass(BALL_ACTIVE_CLASS);
				$($slideBall[nextIndex]).removeClass(BALL_ACTIVE_CLASS);
			}

			setTimeout(() => slideItemsArr.forEach((e, i) => $(e).css('transition', '')), time);
		
			waitTimer = setTimeout(function() { waitTimer = null }, time);
		}
	}

	function initSlide() {
		if (!waitTimer) {
			if (maxIndex > 1) {
				$presentBanner = slideItemsArr[presentIndex];
				$nextBanner = slideItemsArr[nextIndex];
				$prevBanner = slideItemsArr[prevIndex];

				activeSlide($presentBanner, PRESENT_CLASS, SLIDE_DURATION);
				activeSlide($nextBanner, NEXT_CLASS, SLIDE_DURATION);
				activeSlide($prevBanner, PREV_CLASS, SLIDE_DURATION);
			} else if (maxIndex == 1) {
				$presentBanner = slideItemsArr[presentIndex];
				$nextBanner = slideItemsArr[nextIndex];
				$prevBanner = $nextBanner;

				activeSlide($presentBanner, PRESENT_CLASS, SLIDE_DURATION)
				activeSlide($nextBanner, NEXT_CLASS, SLIDE_DURATION);
			} else {
				$presentBanner = slideItemsArr[presentIndex];
				activeSlide($presentBanner, PRESENT_CLASS, SLIDE_DURATION);

				$('.slide-btn').off('click');
				clearInterval(slideTimer);
			}

			waitTimer = setTimeout(function() { waitTimer = null }, SLIDE_DURATION)
		}
	}

	function moveIndex(i, state) {
		if (state == NEXT) {
			i = i + 1 <= maxIndex ? i + 1 : 0;
		} else {
			i = i - 1 >= 0 ? i - 1 : maxIndex;
		}

		return i;
	}

	const slideIndex = async (index, waitTime) => {
		let isOdd = index % 2;
		let median = index / 2;
		let timeDiff = waitTime / 10;

		let sum = 0;

		for (let i = 0; i < index; i++) {
			let product = i < median ? -1 : 1;

			if (i) {
				if(isOdd) {
					waitTime += timeDiff * product;
				} else if (i != median) {
					waitTime += timeDiff * product;
				}	
			}

			sum += waitTime;

			slide(NEXT, waitTime, true);

			await new Promise((res) => setTimeout(res, waitTime));
		}
	}

	function initBanner(state) {
		presentIndex = moveIndex(presentIndex, state);
		$presentBanner = slideItemsArr[presentIndex];

		nextIndex = moveIndex(nextIndex, state);
		$nextBanner = slideItemsArr[nextIndex];

		prevIndex = moveIndex(prevIndex, state);
		$prevBanner = slideItemsArr[prevIndex];
	}

	let slideTimer = setInterval(slide, WAIT_TIME, NEXT);
	
	/* Eventlistner */
	$('.slide-btn').on('click', function() {
		$this = $(this);

		if ($this.hasClass('prev')) {
			slide(PREV, SLIDE_DURATION, false);
		} else if ($this.hasClass('next')) {
			slide(NEXT, SLIDE_DURATION, false);
		}

		clearInterval(slideTimer);
		slideTimer = setInterval(slide, WAIT_TIME, NEXT);
	});
	
	$slideBall.on('click', function() {
		dataIndex = $(this).attr(DATA_ATTR);
		let SlideTimes;

		clearInterval(SlideTimes);

		let times = dataIndex < presentIndex ? maxIndex - presentIndex + (dataIndex * 1) + 1
			 : dataIndex - presentIndex;

		let slideTime = times != 0  ? SLIDE_DURATION / times : 0;

		if (slideTime) {
			slideIndex(times, slideTime);
		}

		clearInterval(slideTimer);
		slideTimer = setInterval(slide, WAIT_TIME, NEXT);
	});

	initSlide();
});