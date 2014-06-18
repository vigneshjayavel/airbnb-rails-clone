class PagesController < ApplicationController

	def index
		
	end

	def search
		search_attr = params[:search]
		if search_attr[:guests_count]!="" && search_attr[:place]!=""
			check_in = "#{search_attr["check_in(1i)"]}-#{search_attr["check_in(2i)"]}-#{search_attr["check_in(3i)"]}"
			check_out = "#{search_attr["check_out(1i)"]}-#{search_attr["check_out(2i)"]}-#{search_attr["check_out(3i)"]}"
			@listings = Listing.find(:all, 
				:conditions => ["place = ? and maximum_guests >= ? and user_id != ? and availability_from <= ? and availability_to >= ? ", 
				search_attr[:place], search_attr[:guests_count], current_user.id, check_in, check_out ])	
		else 
			@listings = Listing.not_belonging_to_current_user(current_user.id)
		end
	end

end