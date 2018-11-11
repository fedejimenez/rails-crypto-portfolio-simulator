 /*========================================================================
                 DATATABLES 
 ========================================================================*/

$(document).on('turbolinks:load', function() {
	 $('#table-movements').DataTable({
	 });

	 $('#table-index').DataTable({
    	"iDisplayLength": 10,
    	 "order": [[ 0, "asc" ]]
	 });

	 $('#table-cryptos').DataTable({
	 });

	 $('#table-movements').parent().addClass('table-responsive');
	 $('#table-index').parent().addClass('table-responsive');
	 $('#table-cryptos').parent().addClass('table-responsive');

})