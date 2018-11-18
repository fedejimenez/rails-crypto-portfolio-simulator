// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require jquery.easy-autocomplete
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require lookup.js
//= require sweetalert2
//= require sweet-alert2-rails
//= require Chart.bundle
//= require chartkick
//= require jquery.minicolors
//= require jquery.minicolors.simple_form
//= require_tree .
//= stub 'validation'
//= stub 'tabs'
//= stub 'fadeinup-animation'
//= stub 'tabs-slides'
//= stub 'count'

// Add style to search bar (easyAutocomplete)
$(document).on('turbolinks:load', function() {
	document.querySelector('#q').classList.add("lookup-input")
	document.querySelector('#q').parentNode.classList.add("lookup-input")
})

// Add style to variation if positive/negative number
$(document).on('turbolinks:load', function() {
	textColor();
})
$(document).ready(function() {
	textColor();
})

function textColor(){
	var vals = document.querySelectorAll('.color-text')
	for(var i = 0; i < vals.length; i++){
		if (parseFloat(vals[i].innerText) < 0 ) {
			vals[i].classList.add("red")
		}else{
			vals[i].classList.add("green")
		}
	}
}

// Flash Messages - Close
$(function() {
    $('.page-alert .close').click(function(e) {
        e.preventDefault();
        $(this).closest('.page-alert').slideUp();
    });
});

$(document).on('turbolinks:load', function() {
	// Search Bar 
	$('.search-trigger').on('click', function(event) {
		event.preventDefault();
		event.stopPropagation();
		$('.search-trigger').parent('.header-left').addClass('open');
	});

	$('.search-close').on('click', function(event) {
		event.preventDefault();
		event.stopPropagation();
		$('.search-trigger').parent('.header-left').removeClass('open');
	});

	// Left Menu Trigger
	$('#menuToggle').on('click', function(event) {
        var windowWidth = $(window).width();         
	    if (windowWidth<1010) { 
	        $('body').removeClass('open'); 
	        if (windowWidth<760){ 
	            $('#left-panel').slideToggle(); 
	        } else {
	            $('#left-panel').toggleClass('open-menu');  
	        } 
	    } else {
	        $('body').toggleClass('open');
	        $('#left-panel').removeClass('open-menu');  
	    } 
	}); 

})

	// Load Resize 
	$(window).on("load resize", function(event) { 
		var windowWidth = $(window).width();  		 
		if (windowWidth<1010) {
			$('body').addClass('small-device'); 
		} else {
			$('body').removeClass('small-device');  
		} 
		
	});
   