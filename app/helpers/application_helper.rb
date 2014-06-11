# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def current_user_is_listing_owner?(listing)
		current_user.id == listing.user_id
	end

end
