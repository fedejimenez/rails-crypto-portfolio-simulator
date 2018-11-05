$(document).on('turbolinks:load', function() {
	 $('#table-movements').DataTable({
	 });

	 $('#table-index').DataTable({
    	"iDisplayLength": 25
	 });

	 $('#table-cryptos').DataTable({
	 });
})