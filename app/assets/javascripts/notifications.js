class Notifications {
	constructor() {
		this.handleClick = this.handleClick.bind(this);
		this.handleSuccess = this.handleSuccess.bind(this);
		this.notifications = $("[data-behavior='notifications']");
		if (this.notifications.length > 0) { this.setup(); } 
	}

	setup() { 
		$("[data-behavior='notifications-link']").on("click", this.handleClick); 
		return $.ajax({
			url: "/notifications.json",
			dataType: "JSON",
			method: "GET",
			success: this.handleSuccess
		});
	}

	handleClick(e) {
		return $.ajax({
			url: "/notifications/mark_as_read",
			dataType: "JSON",
			method: "POST",
			success() {
				return $("[data-behavior='unread-count']").text(0);
			}
		});	
	}

	handleSuccess(data) {
	    if (data.length > 0) {
	      const items = $.map(data, notification => `<a class='nav-link' href='${notification.url}'><i class='fa fa-info'></i>${notification.actor} ${notification.action}</a>`);

	      $("[data-behavior='unread-count']").text(items.length);
	      return $("[data-behavior='notification-items']").html(items);
	      
	    } else {
	      return $("[data-behavior='notification-items']").html("<a class='nav-link'><i class='fa fa-envelope-open'></i>No new notifications</a>");
		}	
	}
}

$(document).on('turbolinks:load', function() {
   new Notifications;
})