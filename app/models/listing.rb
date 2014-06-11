class Listing < ActiveRecord::Base

  belongs_to :user
  
  named_scope :not_belonging_to_current_user, lambda { |current_user_id| 
    { :conditions => ["user_id != ?", current_user_id] }
  }
  
end
