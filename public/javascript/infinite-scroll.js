var lines_in_store = [];
var lines_in_store = gon.starting_buffer_of_poetry;
var request_initiated = 0;

$(document).ready(function() {
	var win = $(window);
	$('#loading').hide();

	// $('#loading').hide();

	// Each time the user scrolls
	win.scroll(function() {
		// End of the document reached?

		// if (win.scrollTop() + win.height() == $(document).height()) {
			if (lines_in_store.length == 0) {

				if (request_initiated ==0) {
					$('#loading').show();
					request_initiated = 1;
					$.ajax({
						url: '/gimme_random',
						dataType: 'json',
		        crossDomain: true,
						success: function(response) {


							var string_to_insert = "";
							lines_in_store = response["data"];
							$('#loading').hide();
							addLine();
							addLine();
							addLine();
							request_initiated = 0;
						},
						error: function(xhr,status,error) {
							$('#loading').hide();
							request_initiated = 0;
							console.log(error);
						}
					});
				};

			} else {
				addLine();
				$('#loading').hide();
			}

		// }
	});
});

function addLine() {
	line_to_add = lines_in_store.pop();
	string_to_insert = '<li>'+ line_to_add.trim() + '</li>'
	$("ul").append(string_to_insert);

}
