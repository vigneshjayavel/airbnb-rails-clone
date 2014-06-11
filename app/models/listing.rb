class Listing < ActiveRecord::Base

	belongs_to :user

	# named_scope :not_belonging_to_current_user, :conditions => ["user_id != ?", current_user.id]
end
