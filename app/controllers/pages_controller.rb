class PagesController < ApplicationController
	before_filter :require_user, :only => [:index, :search]
	def index
		
	end

	def search
		search_attr = params[:search]
		@listings = Listing.get_listings_for_search_attr search_attr, current_user
	end

end