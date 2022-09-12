$('.window-btn').on('click', function() {
	let link = $(this).closest('.product-link').attr('href');
	window.open(link);
})

$('.quick-btn.cart-btn').on('click', function() {
})

$('.product-link').on('click', function(e) {
	if ($(e.target) === $('.quick-btn') || $(e.target).closest('.quick-btn').length > 0) {
		e.target.closest('.quick-btn').blur();
		return false;
	}
})