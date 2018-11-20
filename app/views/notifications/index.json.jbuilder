json.array! @notifications do |n|
	# json.recipient n.recipient
	# json.id n.id
	json.actor n.actor.username
	json.actor_id n.actor.id
	json.action n.action
	# json.notifiable  do # n.notifiable
	# 	json.type "#{n.notifiable.class.to_s.underscore.humanize.downcase}"
	# end
	json.url user_path(n.actor.id)
end