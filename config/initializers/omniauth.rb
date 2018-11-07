Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET']
	{
		scope: 'userinfo.email, userinfo.profile, plus.me, http://gdata.youtube.com',
		prompt: 'select_account',
		image_aspect_ratio: 'square',
		image_size: 50
	}

  	provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  	{
  		scope: 'email, user_friends, public_profile',
  		display: 'popup'
  	}
end