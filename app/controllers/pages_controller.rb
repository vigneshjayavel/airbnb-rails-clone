class PagesController < ApplicationController

	def index
		
	end

	def search
		search_attr = params[:search]
		if search_attr[:guests_count]!=nil && search_attr[:place]!=nil
			check_in = "#{search_attr["check_in(1i)"]}-#{search_attr["check_in(2i)"]}-#{search_attr["check_in(3i)"]}"
			check_out = "#{search_attr["check_out(1i)"]}-#{search_attr["check_out(2i)"]}-#{search_attr["check_out(3i)"]}"
			@listings = Listing.not_belonging_to_current_user(current_user).apply_full_search_criteria(search_attr[:place], search_attr[:guests_count], check_in, check_out)
		elsif search_attr[:place] != nil
			@listings = Listing.not_belonging_to_current_user(current_user.id).apply_place_search_criteria(search_attr[:place])
		else
			@listings = Listing.not_belonging_to_current_user(current_user.id)
		end
	end

end