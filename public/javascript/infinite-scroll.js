var lines_in_store = [];
var lines_in_store = gon.starting_buffer_of_poetry;

$(document).ready(function() {
	var win = $(window);


	// $('#loading').hide();

	// Each time the user scrolls
	win.scroll(function() {
		// End of the document reached?

		if (win.scrollTop() + win.height() == $(document).height()) {
			console.log("in scroll")
			// $('#loading').show();
			if (lines_in_store.length == 0) {
				$('#loading').show();
				// console.log("awaiting response");

				$.ajax({
					url: '/gimme_random',
					dataType: 'json',
	        crossDomain: true,
					success: function(response) {
						// console.log("response received");

						var string_to_insert = "";
						lines_in_store = response["data"];

						addLine();
						addLine();
						addLine();
						$('#loading').hide();
					}
				});
			} else {
				addLine();
			}

		}
	});
});

function addLine() {
	line_to_add = lines_in_store.pop();
	string_to_insert = '<li>'+ line_to_add.trim() + '</li>'
	$("ul").append(string_to_insert);

	console.log(lines_in_store.length);
}
