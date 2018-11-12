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

	 var tableRanking = $('#table-ranking').DataTable({
    	"iDisplayLength": 10,
    	 "order": [[ 2, "desc" ]]
	 });

     tableRanking.on('order.dt search.dt', function () {
     tableRanking.column(0, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
            cell.innerHTML = i + 1;
        });
     }).draw();

	 $('#table-cryptos').DataTable({
	 });

	 $('#table-movements').parent().addClass('table-responsive');
	 $('#table-index').parent().addClass('table-responsive');
	 $('#table-cryptos').parent().addClass('table-responsive');

})