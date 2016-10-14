$(document).ready(function() {
	var win = $(window);
	$('#loading').hide();

	// Each time the user scrolls
	win.scroll(function() {
		// End of the document reached?
    // Top
    // $(document).height() - win.height() == win.scrollTop()
		if (win.scrollTop() + win.height() == $(document).height()) {


    	$('#loading').show();

			$.ajax({
				url: '/gimme_random',
				dataType: 'json',
        crossDomain: true,
				success: function(response) {
					$('#loading').hide();
					var string_to_insert = "";

					response["data"].forEach(function(line){
						console.log(line)
						string_to_insert = '<li>'+ line.trim() + '</li>'
						$("ul").append(string_to_insert);
					});


					string = '<li>'+ line.trim() + '</li>'
					$("ul").append('<li><a href="/user/messages"><span class="tab">Message Center</span></a></li>');
				}
			});
		}
	});
});
