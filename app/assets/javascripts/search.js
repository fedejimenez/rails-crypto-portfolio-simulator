// $(document).ready(function(){
$(document).on('turbolinks:load', function() {
	var options = {
		url: "/search.json",
		getValue: function(element) {
			return element.symbol + " | " + element.name;
		},
		list: {
			onChooseEvent: function(){
				let url = $('#search').getSelectedItemData().symbol
				window.location.href = "/search?q=" + url
			}
		}
	}
	$('#search').easyAutocomplete(options)
})