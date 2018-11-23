 /*========================================================================
                 AJAX AUTOCOMPLETE - SEARCHBAR
 ========================================================================*/

$(document).on('turbolinks:load', function() {
	var options = {
		url: "/lookup.json",
		getValue: function(element) {
			return element.symbol + " | " + element.name + " | " + element.price_usd +" U$D ";
		},
		list: {
			onChooseEvent: function(){
				let url = $('.lookup').getSelectedItemData().symbol
				window.location.href = "/lookup?q=" + url
			}
		}
	}
	$('.lookup').easyAutocomplete(options)
})