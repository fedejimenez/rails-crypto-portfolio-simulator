/*========================================================================
                 Google Places autocomplete (Search Bar)
========================================================================*/

var autocomplete;

function initAutocomplete() {
	// Create the autocomplete object
	autocomplete = new google.maps.places.Autocomplete(
	    /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
	    {types: ['geocode']});
	autocomplete.addListener('place_changed',  function() {
	// var place = autocomplete.getPlace();
  });
}

