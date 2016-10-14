$(document).ready(function() {
	var win = $(window);

	// Each time the user scrolls
	win.scroll(function() {
		// End of the document reached?
		if ($(document).height() - win.height() == win.scrollTop()) {
			$('#loading').show();

			$.ajax({
				url: '/gimme_random',
				dataType: 'json',
        crossDomain: true,
				success: function(response) {
					// $('#posts').append(html);
					// $('#loading').hide();

          console.log(response);
				}
			});
		}
	});
});
