function showForm(names, user_coins, array_prices){
	// Only for new currencies (not already in Portfolio)
	var selectOption = document.querySelector('#new-order');
	var userInput = selectOption.options[selectOption.selectedIndex].value;
	var userInput_coin = userInput.split('|')[0].slice(0,-1)
	var userInput_price = userInput.split('|')[2].slice(0,-1)

	if (user_coins.indexOf(userInput_coin) > -1) {
	 	window.location.href = "/lookup?q=" + userInput_coin;
	} else {
	 	document.querySelector('#form-new').style.visibility = 'visible'
	 	document.querySelector('#total-amount-footer').style.visibility = 'visible'
	 	document.querySelector('#selected-symbol').value = userInput_coin
	 	document.querySelector('#selected-price').value = (userInput_price * 1.001).toFixed(5)
	 	document.querySelector('#selected-price').min = (userInput_price * 1.001).toFixed(5)
		document.querySelector('#total-amount').value = (userInput_price * 1.001).toFixed(5)
	}
	return false;
}

function showTotalAmount(){
	document.querySelector('#total-amount').value = (document.querySelector('#selected-price').value * document.querySelector('#selected-quantity').value * 1.001).toFixed(5)
	checkAmount();
	checkQuantity();
}	

function checkAmount(){
	var total_to_buy =  document.querySelector('#total-amount').value
	var total_available = document.querySelector('#total-amount-available').value

	if ((total_to_buy - total_available > 0) || (total_to_buy < 0)){
		showError()
	}else{
		hideError()
	}
}

function checkQuantity(){
	if (document.querySelector('#quantity-owned')){ 
		var quantity_owned = document.querySelector('#quantity-owned').innerHTML
		if ($('#selected-checkbox').is(":checked")){
			if (document.querySelector('#selected-quantity').value - quantity_owned > 0) {
				showError()
			}else{
				hideError()
			}
		}else{
			hideError();
			checkAmount();
		}
	}
}

function showError(){
	document.querySelector('#error-amount').style.visibility = 'visible';
	document.querySelector('#button-submit').disabled = true;
}
function hideError(){
	document.querySelector('#error-amount').style.visibility = 'hidden';
	document.querySelector('#button-submit').disabled = false;
}

function checkboxText(){
	if ($('#selected-checkbox').is(":checked")) {
		document.querySelector('#text-checkbox').innerHTML = "Sell"
		checkQuantity()
	}else {
		document.querySelector('#text-checkbox').innerHTML = "Buy"
		checkQuantity()
	}
}

$(document).on('turbolinks:load', function() {
	// Set the first value when editing
	if (document.querySelector('#total-amount')) {
		document.querySelector('#total-amount').value = (document.querySelector('#current-price').value * 1.001).toFixed(5)
	}
	if (document.querySelector('#text-checkbox') != null){
		checkboxText();
		checkAmount();
	}
});
